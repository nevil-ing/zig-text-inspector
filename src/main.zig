const std = @import("std");
//const Io = std.Io;
//a small terminal program that analzyes a piece of text

const zig_text_inspector = @import("zig_text_inspector");

pub fn main() !void {
    const text: []const u8 = "Zig is simple, fast and explicit. Learning Zig is fun";
    var vowel_count: usize = 0;
    var space_count: usize = 0;
    var word_count: usize = 0;
    var zig_count: usize = 0;

    //flag to track when inside words.
    var in_word: bool = false;

    //print text len.
    std.debug.print("'{s}' this text has  {d} characters\n", .{ text, text.len });

    var byte_array: [text.len]u8 = undefined;
    @memcpy(&byte_array, text);

    //get the first 3 bytes and last 4 bytes
    const first_bytes = byte_array[0..3];
    const text_len = byte_array.len;
    const last_bytes = byte_array[text_len - 4 .. text_len];
    //print
    std.debug.print("First 3 bytes: {s}\n", .{first_bytes});
    std.debug.print("Last 4 bytes: {s}\n", .{last_bytes});

    //check if "zig" and "fun" exists.
    std.debug.print("Text starts with Zig: {any}\n", .{std.mem.startsWith(u8, text, "Zig")});
    std.debug.print("Text Ends with fun: {any}\n", .{std.mem.endsWith(u8, text, "fun")});

    //loop
    for (text) |char| {
        switch (char) {
            'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U' => {
                vowel_count += 1;
            },
            ' ' => {
                space_count += 1;
            },
            else => {},
        }

        if (char == ' ') {
            in_word = false;
        } else if (!in_word) {
            in_word = true;
            word_count += 1;
        }
    }

    std.debug.print("word_count:{d}\n", .{word_count});
    std.debug.print("vowel_count:{d}\n", .{vowel_count});
    std.debug.print("space_count:{d}\n", .{space_count});
    std.debug.print("Zig_count:{d}\n", .{zig_count});
}
