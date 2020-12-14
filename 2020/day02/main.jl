lines = readlines(joinpath(Base.source_dir(), "input"))

function parse_range(s::String)
    range, char_part, pw = split(s, " ")
    return (parse.(Int, split(range, "-")), char_part[1], pw)
end

# part 1
success_count = 0
for line in lines
    (r_min, r_max), search_char, pw = parse_range(line)
    occurences = sum(collect(pw) .== search_char)
    if r_min <= occurences <= r_max
        success_count += 1
    end
end
println(success_count)

# part 2
success_count = 0
for line in lines
    (first_pos, second_pos), search_char, pw = parse_range(line)
    if pw[first_pos] == search_char && pw[second_pos] != search_char || pw[second_pos] == search_char && pw[first_pos] != search_char
        success_count += 1
    end
end
println(success_count)
