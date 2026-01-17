const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

pub const PPM = u32;
pub const PPM_MAX: PPM = 1_000_000;

/// Represents the current "Memory" of explored possibilities.
pub const Tradespace = struct {
  allocator: Allocator,
  population: ArrayList(Solution),

  pub fn init(allocator: Allocator) Tradespace {
    return .{
      .allocator = allocator,
      .population = ArrayList(Solution).init(allocator),
  };
  }

  pub fn deinit(self: *Tradespace) void {
    self.population.deinit();
  }

  /// Absorbs a new solution into the collective.
  pub fn add(self: *Tradespace, sol: Solution) !void {
    try self.population.append(sol);
  }

  /// Returns the subset of the population that is non-dominated.
  pub fn findParetoFrontier(
    allocator: std.mem.Allocator,
    candidates: []const Solution
  ) ![]Solution {
    var frontier = std.ArrayList(Solution).init(allocator);

    for (candidates) |candidate| {
      var dominated = false;

      // Check if this candidate is dominated by anyone currently in the frontier
      for (frontier.items) |existing| {
        if (existing.dominates(candidate)) {
          dominated = true;
          break;
        }
      }

      if (dominated) continue;

      // If we survive, we add ourselves, but we must remove anyone WE dominate
      var i: usize = 0;
      while (i < frontier.items.len) {
        if (candidate.dominates(frontier.items[i])) {
          _ = frontier.swapRemove(i);
        } else {
          i += 1;
        }
      }

      try frontier.append(candidate);
    }

    return frontier.toOwnedSlice();
  }
};

/// Defines the constraints for the candidates.
pub const DesignSpace = struct {
  entropy_limit: u32 = 100,
  requiresUniqueSolution: bool = true,

  /// Samples a random candidate from this Design Space.
  pub fn propose(self: DesignSpace, allocator: Allocator, rng: std.Random) !Candidate {
    // Use 'self' (the constraints) to shape the output.
    const buffer = try allocator.alloc(u8, self.entropy_limit);
    rng.bytes(buffer);

    // TODO: Apply other constraints from 'self' here.

    return Candidate{
      .configuration = buffer,
      .allocator = allocator,
    };
  }
};

/// A Candidate is a specific instance sampled from the Design Space.
/// This is the "un-evaluated" abstraction.
pub const Candidate = struct {
  /// The specific choices made for this candidate (The Design Vector).
  /// e.g. { .length = 42.0, .material = "CarbonFiber" }
  configuration: []u8, 

  allocator: Allocator,

  pub fn init(allocator: Allocator, config: []const u8) !Candidate {
    const copy = try allocator.dupe(u8, config);
    return Candidate{
      .configuration = copy,
      .allocator = allocator,
  };
  }

  pub fn deinit(self: *Candidate) void {
    self.allocator.free(self.configuration);
  }
};

/// Represents one possible "Future" or "Thought".
/// This is the "evaluated" abstraction, resulting from a Candidate.
pub const Solution = struct {
  id: u64,

  // The "Energy" Axis (Cost)
  // We want to MINIMIZE these.
  cost_atp: u64,      // Compute cycles
  cost_latency: u64,  // Wall time (nanoseconds)

  // Fixed-point risk (0 = Safe, 1_000_000 = Doomed)
  risk_ppm: PPM,   

  // The "Motivation" Axis (Utility)
  // Integer utility units (Arbitrary Scale)
  // We want to MAXIMIZE these.
  utility_meaning: u32, 
  utility_novelty: u32, 

  /// Returns true if 'self' dominates 'other'.
  /// A solution dominates another if it is better (or equal) in ALL dimensions
  /// and strictly better in at least one.
  pub fn dominates(self: Solution, other: Solution) bool {
    // Check strict superiority in at least one dimension
    const strictly_better =
      (self.cost_atp < other.cost_atp) or
      (self.utility_meaning > other.utility_meaning);

    if (!strictly_better) return false;

    // Check non-inferiority in all others
    return (self.cost_atp <= other.cost_atp) and
      (self.cost_latency <= other.cost_latency) and
      (self.risk_ppm <= other.risk_ppm) and // Integer compare
      (self.utility_meaning >= other.utility_meaning) and
      (self.utility_novelty >= other.utility_novelty);
  }
};
