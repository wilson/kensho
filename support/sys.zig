const std = @import("std");
const builtin = @import("builtin");

// Define the handle-type based on the OS:
const Handle = if (builtin.os.tag == .windows) std.os.windows.HANDLE else std.posix.fd_t;

// Unbuffered writer.
// TODO: Reader may be useful for STDIN.
pub const Writer = struct {
  const Self = @This(); // Our own "type".

  // The underlying OS handle (pointer on Windows, integer on Linux)
  fd: Handle,

  // Input must be pre-formatted.
  // The Win32 implementation is Hell, but that seems to be what we have.
  pub fn writeAll(self: Self, bytes: []const u8) !void {
    var index: usize = 0;
    while (index < bytes.len) {
      var written: usize = 0;

      if (builtin.os.tag == .windows) {
        var bytes_written: u32 = 0; // Destination for lpNumberOfBytesWritten

        // WriteFile accepts a DWORD (u32) for length.
        // We must clamp the chunk size to avoid overflow if the buffer > 4GB.
        const max_chunk = std.math.maxInt(u32);
        const remaining = bytes.len - index;
        const chunk_len = @min(remaining, max_chunk);

        // Call kernel32 directly with the C-ABI arguments:
        // (HANDLE, [*]const u8, DWORD, *DWORD, ?*OVERLAPPED)
        const rc = std.os.windows.kernel32.WriteFile(
          self.fd,
          bytes[index..].ptr, // Extract raw pointer
          @as(u32, @intCast(chunk_len)),
          &bytes_written,
          null
        );

        if (rc == 0) return error.SystemError;
        written = @as(usize, bytes_written);

      } else {
        written = try std.posix.write(self.fd, bytes[index..]);
      }

      if (written == 0) return; // EOF
      index += written;
    }
  }

  // Uses a stack buffer to format text before writing.
  // This avoids needing the unstable std.Io interface types.
  pub fn print(self: Self, comptime template: []const u8, args: anytype) !void {
    // "4KB should be enough for anybody."
    var buf: [4096]u8 = undefined;
    const slice = try std.fmt.bufPrint(&buf, template, args);
    try self.writeAll(slice);
  }

  // We cannot use a const for stdout/stderr on Windows, they are runtime handles.
  // Note: std.os.windows might be unstable, but it's the only way to get the handle strictly.
  pub fn getStdOut() Self {
    if (builtin.os.tag == .windows) {
      const handle = std.os.windows.GetStdHandle(std.os.windows.STD_OUTPUT_HANDLE) catch std.os.windows.INVALID_HANDLE_VALUE;
      return Self{ .fd = handle };
    } else {
      return Self{ .fd = std.posix.STDOUT_FILENO };
    }
  }

  pub fn getStdErr() Self {
    if (builtin.os.tag == .windows) {
      const handle = std.os.windows.GetStdHandle(std.os.windows.STD_ERROR_HANDLE) catch std.os.windows.INVALID_HANDLE_VALUE;
      return Self{ .fd = handle };
    } else {
      return Self{ .fd = std.posix.STDERR_FILENO };
    }
  }
};
