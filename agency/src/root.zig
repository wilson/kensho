const std = @import("std");
const sys = @import("sys");

pub fn main() !void {
  const stdout = sys.Writer.getStdOut();
  try stdout.print("I AM A PROTOTYPE OF A MUCH LARGER SYSTEM.\n", .{});
  // Future endless loop.
}
