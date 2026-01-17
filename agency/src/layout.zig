const std = @import("std");

/// Reality.
pub const Machine = struct {
  cache_line_bytes: u32 = 64,
  simd_width_bytes: u32 = 64,
  tlb_miss_cost: u32 = 20,
};

/// What is being proposed.
pub const Mode = struct {
  shape: u64,
  stride: u64,

  pub fn lessThan(context: void, a: Mode, b: Mode) bool {
    _ = context;
    if (a.stride < b.stride) return true;
    if (a.stride > b.stride) return false;

    // STRICT Weak Ordering: Must be strictly less than.
    // If strides are equal, compare shapes.
    return a.shape < b.shape;
  }
};

/// Awfulness that might be detected.
pub const LayoutError = error{
  RankMismatch,
  InvalidZeroGeometry,
  FracturedTopology,
  CacheLineMisalignment,
};

/// Verifies if a memory layout is topologically-sound and physically-aligned.
pub fn isSympathetic(
  allocator: std.mem.Allocator,
  machine: Machine,
  element_size: u64,
  shape: []const u64,
  stride: []const u64,
) !bool {
  if (shape.len != stride.len) return error.RankMismatch;
  if (shape.len == 0) return true;
  if (shape.len == 1) return true;

  var modes = try allocator.alloc(Mode, shape.len);
  defer allocator.free(modes);

  for (shape, 0..) |s, i| {
    modes[i] = Mode{ .shape = s, .stride = stride[i] };
  }
  std.sort.block(Mode, modes, {}, Mode.lessThan);

  for (0..modes.len - 1) |i| {
    const current = modes[i];
    const next = modes[i + 1];

    if (current.stride == 0) continue;

    const block_size_logical = current.shape * current.stride;
    if (block_size_logical == 0) return error.InvalidZeroGeometry;

    // Check topology.
    if (next.stride % block_size_logical != 0) {
      return error.FracturedTopology;
    }

    // Check alignment.
    if (next.stride > block_size_logical) {
      const stride_bytes = next.stride * element_size;
      if (stride_bytes % machine.cache_line_bytes != 0) {
        return error.CacheLineMisalignment;
      }
    }
  }

  return true;
}
