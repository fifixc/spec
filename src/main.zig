const clap = @import("clap");
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const params = comptime clap.parseParamsComptime(
        \\-h, --help     Display this help and exit.
        \\-v, --version  Output version information and exit.
        \\
    );

    var res = try clap.parse(clap.Help, &params, clap.parsers.default, .{
        .allocator = gpa.allocator(),
    });
    defer res.deinit();

    if (res.args.help != 0)
        return clap.help(std.io.getStdErr().writer(), clap.Help, &params, .{});
}
