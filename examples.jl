using hrr

# would a macro be better?
# print vectors
function printv{T <: Real}(x::AbstractVector{T})
    println(summary(x))
    println("    $(join(length(x) > 7 ? [x[1:3];"...";x[end-2:end]] : x, "  "))")
end

# define Vector{Pair{AbstractString,AbstractVector}} list of relationship types (for now just: class and member)
# define Associative Memory of all synsets (for now just: dog, canine, pack)

println("####### START OF EXAMPLES #######")

index = 1
for test in (
("Given a vector x = [1, 2, 3, 4, 5], the involution of x should return the vector x_bar = [1, 5, 4, 3, 2].",
        :(hrr.invol([1, 2, 3, 4, 5]))),
("Vector with more than 7 elements.",
        :([7,7,7,7,7,7,7,7,7,7])),
)
    println("\n\n\nExample $index.   $(test[1])")
    printv(eval(test[2]))
    index += 1
end

println("\n\n\n######## END OF EXAMPLES ########")
