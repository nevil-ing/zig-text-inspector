const std = @import("std");
//const Io = std.Io;
//a small terminal program that analzyes a piece of text

const zig_text_inspector = @import("zig_text_inspector");

pub fn main() !void {
    const text: []const u8 = "Zig is simple, fast and explicit. Learning Zig is fun";
    const vowel_c = vowel_count(text);
    const space_count = countSpaces(text);
    const word = "Zig";
    const zig_c = zig_count(text, word);
    const word_count = countWords(text);

    std.debug.print("The word '{s}' appears {d} times.\n", .{ word, zig_c });

    //flag to track when inside words.

    //print text len.
    std.debug.print("'{s}' this text has  {d} bytes\n", .{ text, text.len });

    //get the first 3 bytes and last 4 bytes
    //
    const first_bytes = text[0..3];
    const text_len = text.len;
    const last_bytes = text[text_len - 4 .. text_len];
    //print
    std.debug.print("First 3 bytes: {s} \n", .{first_bytes});
    for (first_bytes) |byte| {
        std.debug.print("{x:0>2}", .{byte});
    }
    std.debug.print("\n", .{});
    std.debug.print("Last 4 bytes: {s}\n", .{last_bytes});
    for (last_bytes) |byte| {
        std.debug.print("{x:0>2}", .{byte});
    }
    std.debug.print("\n", .{});

    //check if "zig" and "fun" exists.
    std.debug.print("Text starts with Zig: {any}\n", .{std.mem.startsWith(u8, text, "Zig")});
    std.debug.print("Text Ends with fun: {any}\n", .{std.mem.endsWith(u8, text, "fun")});

    std.debug.print("word_count:{d}\n", .{word_count});
    std.debug.print("vowel_count:{d}\n", .{vowel_c});
    std.debug.print("space_count:{d}\n", .{space_count});
    std.debug.print("Zig_count:{d}\n", .{zig_c});
}

//fn to count space_count
fn countSpaces(text: []const u8) usize {
    var count_sp: usize = 0;
    for (text) |char| {
        switch (char) {
            ' ' => {
                count_sp += 1;
            },
            else => {},
        }
    }
    return count_sp;
}
//function to count words.
fn countWords(text: []const u8) usize {
    var count: usize = 0;
    var in_word: bool = false;

    for (text) |char| {
        if (char == ' ') {
            in_word = false;
        } else if (!in_word) {
            in_word = true;
            count += 1;
        }
    }
    return count;
}

//function to count vowel_count
fn vowel_count(text: []const u8) usize {
    var vowels: usize = 0;

    for (text) |char| {
        switch (char) {
            'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U' => {
                vowels += 1;
            },
            else => {},
        }
    }
    return vowels;
}

//function to count no. of times "zig" appears in the text.
fn zig_count(text: []const u8, word: []const u8) usize {
    if (word.len == 0 or text.len < word.len) return 0;
    var count: usize = 0;
    var index: usize = 0;

    while (index <= text.len - word.len) {
        if (std.mem.startsWith(u8, text[index..], word)) {
            count += 1;
            index += word.len;
        } else {
            index += 1;
        }
    }
    return count;
}
