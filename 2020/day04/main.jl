lines = *(readlines(joinpath(Base.source_dir(), "input"), keep=true)...)[1:end-1]
passports = split.(replace.(split(lines, "\n\n"), "\n" => " "), " ")

# part 1
valid_count = 0
for passport in passports
    length(passport) <= 6 && continue
    length(passport) == 7 && any(SubString.(passport, 1, 3) .== "cid") && continue
    valid_count += 1
end
println(valid_count)

# part 2
struct V{x} end
V(x) = V{x}()

function check_validity(::V{:byr}, s) 
    length(s) != 4 && return false
    1920 <= parse(Int, s) <= 2002 && return true
    return false
end

function check_validity(::V{:iyr}, s) 
    length(s) != 4 && return false
    2010 <= parse(Int, s) <= 2020 && return true
    return false
end

function check_validity(::V{:eyr}, s) 
    length(s) != 4 && return false
    2020 <= parse(Int, s) <= 2030 && return true
    return false
end

function check_validity(::V{:hgt}, s)
    number = s[1:end-2]
    unit = s[end-1:end]
    if unit == "cm"
        150 <= parse(Int, number) <= 193 && return true
    elseif unit == "in"
        59 <= parse(Int, number) <= 76 && return true
    end
    return false
end

function check_validity(::V{:hcl}, s) 
    s[1] != '#' && return false
    length(s) != 7 && return false
    return tryparse(Int, s[2:end], base=16) !== nothing
end

function check_validity(::V{:ecl}, s) 
    return s in ["amb" "blu" "brn" "gry" "grn" "hzl" "oth"]
end

function check_validity(::V{:pid}, s) 
    length(s) != 9 && return false
    return tryparse(Int, s) !== nothing
end

check_validity(::V{:cid}, s) = true

check_validity(s1::SubString, s2) = check_validity(V(Symbol(s1)), s2)
valid(passport) = all(map(x -> check_validity(x[1], x[2]), split.(passport, ":"))) ? 1 : 0

valid_count = 0
for passport in passports
    length(passport) <= 6 && continue
    length(passport) == 7 && any(SubString.(passport, 1, 3) .== "cid") && continue
    valid_count += valid(passport)
end
println(valid_count)
