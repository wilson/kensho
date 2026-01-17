const std = @import("std");
const testing = std.testing;
const tradespace = @import("agency_tradespace");

// Trivial fake sensor.
const EntropySensor = struct {
    pub fn read(sol: tradespace.Candidate) f32 {
        return @as(f32, @floatFromInt(sol.configuration.len)) * 0.5;
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
    try testing.expectEqual(@as(f32, 9.5), entropy); // 19 chars * 0.5
}

// Tests sampling a valid candidate from the Design Space.
test "DesignSpace: propose() samples a vector within the constraints" {
    const allocator = testing.allocator;
    var prng = std.rand.DefaultPrng.init(42);
    const rng = prng.random();

    const space = tradespace.DesignSpace{ 
        .entropy_limit = 10,
    };

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
        .risk_factor = 0.1,
        .utility_meaning = 100.0,
        .utility_novelty = 50.0,
    };

    // Solution B: Expensive and Meaningless (Obvious Loser)
    const b = tradespace.Solution{
        .id = 2,
        .cost_atp = 20,      // Worse
        .cost_latency = 20,  // Worse
        .risk_factor = 0.5,  // Worse
        .utility_meaning = 10.0, // Worse
        .utility_novelty = 10.0, // Worse
    };

    // Solution C: The Trade-off (The High Road, Expensive)
    const c = tradespace.Solution{
        .id = 3,
        .cost_atp = 50,       // Much Worse
        .cost_latency = 10,   // Equal
        .risk_factor = 0.1,   // Equal
        .utility_meaning = 100.0, // Equal
        .utility_novelty = 900.0, // BETTER!
    };

    // A should dominate B
    try testing.expect(a.dominates(b));
    // B should NOT dominate A
    try testing.expect(!b.dominates(a));
    // A should NOT dominate C (C is strictly better at Novelty)
    try testing.expect(!a.dominates(c));
}
