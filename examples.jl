using hrr

# would a macro be better?
# print vectors
function printv{T <: Real}(x::AbstractVector{T})
    println(summary(x))
    println("    $(join(length(x) > 7 ? [x[1:3];"...";x[end-2:end]] : x, "  "))")
end

println("####### START OF EXAMPLES #######\n")

# array of pairs of examples? (to easily enumerate them?)
println("Example 1.  Given a vector x = [1, 2, 3, 4, 5], the involution of x ",
        "should return the vector x_bar = [1, 5, 4, 3, 2].")
printv(hrr.invol([1, 2, 3, 4, 5]))

println("\n######## END OF EXAMPLES ########")
