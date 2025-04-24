const std = @import("std");
const meta = std.meta;

pub fn main() !void {
    const file = try std.fs.cwd().createFile("abc.txt", .{ .read = true });
    defer file.close();

    const bytes_written = try file.writeAll("Hello File!!");
    _ = bytes_written;

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

    std.debug.print("{any}", .{buffer[0..bytes_read]});
}

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}
