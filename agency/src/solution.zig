const std = @import("std");

/// A point in the decision manifold.
/// Represents one possible "Future" or "Thought".
pub const Solution = struct {
  id: u64,

  // The "Energy" Axis (Cost)
  // We want to MINIMIZE these.
  cost_atp: u64,      // Compute cycles
  cost_latency: u64,  // Wall time
  risk_factor: f32,   // Probability of failure (0.0 - 1.0)

  // The "Motivation" Axis (Utility)
  // We want to MAXIMIZE these.
  utility_meaning: f32, // Relevance to core goal
  utility_novelty: f32, // Information gain

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
      (self.risk_factor <= other.risk_factor) and
      (self.utility_meaning >= other.utility_meaning) and
      (self.utility_novelty >= other.utility_novelty);
  }
};

/// Filters a cloud of possibilities down to the Pareto Frontier.
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
