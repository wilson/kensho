const std = @import("std");

pub fn build(b: *std.Build) void {
  // The hardware context.
  // Abstractions are always fake.
  const target = b.standardTargetOptions(.{});
  const optimize = b.standardOptimizeOption(.{});

  // Module definitions //

  // Sys helpers (stdout, stderr).
  const sys_module = b.createModule(.{
      .root_source_file = b.path("../support/sys.zig"),
  });

  // The portion of the Agent definition that doesn't care if we are lib or bin.
  const agency_module = b.createModule(.{
    .root_source_file = b.path("src/root.zig"),
    .target = target,
    .optimize = optimize,
  });
  agency_module.addImport("sys", sys_module);

  // Only exposed to the spec suite.
  const layout_module = b.createModule(.{
    .root_source_file = b.path("src/layout.zig"),
  });

  // Only exposed to the spec suite.
  const tradespace_module = b.createModule(.{
    .root_source_file = b.path("src/tradespace.zig"),
  });

  // Spec module.
  const spec_module = b.createModule(.{
    .root_source_file = b.path("src/specs/root.zig"),
    .target = target,
    .optimize = optimize,
  });
  spec_module.addImport("sys", sys_module);
  // Explicitly grant access to modules.
  spec_module.addImport("agency_layout", layout_module);
  spec_module.addImport("agency_tradespace", tradespace_module);

  // Actual artifacts //

  // Agent runtime (mind).
  const agent = b.addExecutable(.{
    .name = "agent",
    .root_module = agency_module,
  });
  // Produce the binary in 'agency/zig-out/bin'
  b.installArtifact(agent);

  // Commands //

  // 'zig build run' starts the agent also.
  const run_cmd = b.addRunArtifact(agent);
  run_cmd.step.dependOn(b.getInstallStep());

  // Pass CLI args through to the agent.
  if (b.args) |args| {
    run_cmd.addArgs(args);
  }
  const run_step = b.step("run", "Exist");
  run_step.dependOn(&run_cmd.step);

  // Verification
  const unit_tests = b.addTest(.{
    .root_module = spec_module,
  });
  const run_unit_tests = b.addRunArtifact(unit_tests);
  const test_step = b.step("test", "Specify");
  test_step.dependOn(&run_unit_tests.step);
}
