const std = @import("std");
const testing = std.testing;

/// "Omni-Expect": intelligent dispatch based on the type of "expected".
pub fn expect(expected: anytype, actual: anytype) !void {
  const T = @TypeOf(expected);

  // Floats: Automatic tolerance check
  if (T == f64 or T == f32) {
    return expectApprox(expected, actual);
  }

  // Strings: literals and slices
  if (comptime isString(T)) {
    return testing.expectEqualStrings(expected, actual);
  }

  // Error types
  if (@typeInfo(T) == .error_set) {
    return testing.expectError(expected, actual);
  }

  // Deep equality for everything else
  return testing.expectEqualDeep(expected, actual);
}

/// Assert that two floats are within a reasonable tolerance.
fn expectApprox(expected: anytype, actual: anytype) !void {
  // Use a looser-than-epsilon tolerance to account for accumulation errors.
  // This is not a floating-point mathematics library.
  const tolerance = 1e-9;

  if (@abs(expected - actual) > tolerance) {
    std.debug.print(
      "\nExpected {d} (approx), found {d}\n",
      .{ expected, actual }
    );
    return error.TestExpectedApproxEq;
  }
}

// Helper to detect string-like types
fn isString(comptime T: type) bool {
  switch (@typeInfo(T)) {
    .pointer => |ptr| {
      // Case: slice ([]u8 or []const u8)
      if (ptr.size == .slice and ptr.child == u8) return true;

      // Case: pointer to array (*const [N]u8) (String Literals)
      if (ptr.size == .one) {
        switch (@typeInfo(ptr.child)) {
          .array => |arr| return arr.child == u8,
          else => return false,
        }
      }
      return false;
  },
  else => return false,
  }
}
