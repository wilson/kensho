const std = @import("std");
const testing = std.testing;
const tradespace = @import("agency_tradespace");

// Arbitrary placeholder cost: 1 char = 500 units of entropy
const ENTROPY_PER_CHAR: u32 = 500;

// Trivial fake sensor.
const EntropySensor = struct {
  // Returns arbitrarily-scaled integer entropy.
  pub fn read(sol: tradespace.Candidate) u32 {
    return @as(u32, @intCast(sol.configuration.len)) * ENTROPY_PER_CHAR;
  }
};

test "Sensor: extracts attribute from configuration without judgment" {
  const allocator = testing.allocator;

  // Generate a Candidate (Design Vector)
  var candidate = try tradespace.Candidate.init(allocator, "carbon_fiber_matrix");
  defer candidate.deinit();

  // Measure it:
  const entropy = EntropySensor.read(candidate);

  // Verify:
  // 19 (chars) * ENTROPY_PER_CHAR (500) = 9500 "arbitrary cost units".
  try testing.expectEqual(@as(u32, 9500), entropy);
}

// Tests sampling a valid candidate from the Design Space.
test "DesignSpace: propose() samples a vector within the constraints" {
  const allocator = testing.allocator;
  var prng = std.Random.DefaultPrng.init(std.testing.random_seed);
  const rng = prng.random();

  const space = tradespace.DesignSpace{ .entropy_limit = 10, };

  var candidate = try space.propose(allocator, rng);
  defer candidate.deinit();

  try testing.expectEqual(@as(usize, 10), candidate.configuration.len);
}

// Actually evaluate Candidates and consider Solutions.
test "Evaluator: dominance logic identifies strictly superior solutions" {
  // Solution A: Cheap and Meaningful (Obvious Winner)
  const a = tradespace.Solution{
    .id = 1,
    .cost_atp = 10,
    .cost_latency = 10,
    .risk_ppm = 100_000, // 10% of max
    .utility_meaning = 100,
    .utility_novelty = 50,
  };

  // Solution B: Expensive and Meaningless (Obvious Loser)
  const b = tradespace.Solution{
    .id = 2,
    .cost_atp = 20,      
    .cost_latency = 20,  
    .risk_ppm = 500_000, // 50% of max
    .utility_meaning = 10, 
    .utility_novelty = 10, 
      };

  // Solution C: The Trade-off (The High Road, Expensive)
  const c = tradespace.Solution{
    .id = 3,
    .cost_atp = 50,       
    .cost_latency = 10,   
    .risk_ppm = 100_000, // 10% of max again
    .utility_meaning = 100, 
    .utility_novelty = 900, // BETTER!
      };

  // A should dominate B
  try testing.expect(a.dominates(b));
  // B should NOT dominate A
  try testing.expect(!b.dominates(a));
  // A should NOT dominate C (C is strictly better at Novelty)
  try testing.expect(!a.dominates(c));
}
