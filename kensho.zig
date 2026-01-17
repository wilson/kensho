const std = @import("std");
const sys = @import("support/sys.zig");
const MAX_PATH = 4096;

pub fn main() !void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){};
  defer _ = gpa.deinit();
  const allocator = gpa.allocator();
  // The more-portable Threaded backend.
  var runtime = std.Io.Threaded.init(allocator, .{});
  defer runtime.deinit();

  const io = runtime.io();
  const cwd = std.Io.Dir.cwd();

  const stdout = sys.Writer.getStdOut();
  try stdout.print("\n=== Validating ===\n", .{});

  // We tell the handle: "Resolve the real path"
  var buffer: [MAX_PATH]u8 = undefined;
  const cwd_path = try std.process.getCwd(&buffer);

  // Perform the string "math" to find the Engine relative to us.
  const parent_dir = std.fs.path.dirname(cwd_path) orelse return error.NoParentDir;
  const engine_source_path = try std.fs.path.join(allocator, &.{ parent_dir, "UnrealEngine" });
  defer allocator.free(engine_source_path);

  try stdout.print("Engine: {s}\n", .{engine_source_path});

  // Link "../UnrealEngine/Engine" -> "./world/Engine"
  try stdout.print("Status: Linking Engine... ", .{});
  const engine_subdir = try std.fs.path.join(allocator, &.{ engine_source_path, "Engine" });
  defer allocator.free(engine_subdir);
  // We use the handle 'cwd' to create the link relative to itself.
  if (cwd.symLink(io, engine_subdir, "world/Engine", .{ .is_directory = true })) |_| {
    try stdout.print("Created.\n", .{});
  } else |err| switch (err) {
    error.PathAlreadyExists => try stdout.print("Link active.\n", .{}),
    else => return err,
  }

  try generateUProject(cwd, io, stdout);
  try stdout.print("\nEND OF LINE.\n", .{});
}

fn generateUProject(dir: std.Io.Dir, io: std.Io, stdout: sys.Writer) !void {
  const content =
        \\{
        \\  "FileVersion": 3,
        \\  "EngineAssociation": "",
        \\  "Category": "",
        \\  "Description": "This Unreal Dream",
        \\  "Modules": [
        \\    {
        \\      "Name": "Kensho",
        \\      "Type": "Runtime",
        \\      "LoadingPhase": "Default"
        \\    }
        \\  ],
        \\  "Plugins": [
        \\    {
        \\      "Name": "ModelingToolsEditorMode",
        \\      "Enabled": true,
        \\      "TargetAllowList": [ "Editor" ]
        \\    }
        \\  ]
        \\}
  ;

  // Overwrite any previous state.
  const file = try dir.createFile(io, "world/Kensho.uproject", .{
    .truncate = true,
    .exclusive = false
  });
  defer file.close(io);

  try stdout.print("Status: Regenerating Kensho.uproject... ", .{});
  try file.writeStreamingAll(io, content ++ "\n");
  try stdout.print("Done.\n", .{});
}
