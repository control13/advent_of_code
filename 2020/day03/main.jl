lines = readlines(joinpath(Base.source_dir(), "input"))

count_tree(c::Char) = c=='#' ? 1 : 0
clock_counter(val, n, increase=3) = ((val-1) + increase) % n + 1
# part 1
y_pos = 1
tree_count = 0
for line in lines
    tree_count += count_tree(line[y_pos])
    y_pos = clock_counter(y_pos, length(line))
end
println(tree_count)

# part 2
steps = [(1, false), (3, false), (5, false), (7, false), (1, true)]

product = 1
for (forward, skip_line) in steps
    y_pos = 1
    tree_count = 0
    current_line = true
    for line in lines
        current_line = !current_line
        if skip_line && current_line
            continue
        end
        tree_count += count_tree(line[y_pos])
        y_pos = clock_counter(y_pos, length(line), forward)
    end
    product *= tree_count
end
println(product)
