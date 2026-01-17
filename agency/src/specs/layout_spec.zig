const std = @import("std");
const expect = @import("spec_helpers.zig").expect;
const layout = @import("agency_layout");

test "vanilla hardware sympathy checks" {
  const ally = std.testing.allocator;

  // x86_64 / Typical ARM64 - Not Apple Silicon.
  const machine = layout.Machine{ .cache_line_bytes = 64, .simd_width_bytes = 64 };
  const f32_size = 4;

  // Perfect Column-Major
  // Expectation: Success (true)
  try expect(true, try layout.isSympathetic(ally, machine, f32_size, &.{ 16, 16 }, &.{ 1, 16 }));

  // Hostile Layout (Fractured)
  // Expectation: FAILURE (FracturedTopology)
  try expect(layout.LayoutError.FracturedTopology, layout.isSympathetic(ally, machine, f32_size, &.{ 4, 8 }, &.{ 3, 3 }));

  // Broadcasting
  // Expectation: Success (true)
  try expect(true, try layout.isSympathetic(ally, machine, f32_size, &.{ 128, 128 }, &.{ 0, 0 }));

  // Misalignment
  // Expectation: FAILURE (CacheLineMisalignment)
  const rgb8_size = 3;
  try expect(layout.LayoutError.CacheLineMisalignment, layout.isSympathetic(ally, machine, rgb8_size, &.{ 16, 2 }, &.{ 1, 32 }));
}
