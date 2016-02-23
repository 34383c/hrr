using hrr

# would a macro be better?
# print vectors
function printv(x::Vector{Float64})
    println(summary(x))
    println("    $(join(length(x) > 7 ? [x[1:3];"...";x[end-2:end]] : x, "  "))")
end

# define Vector{Pair{AbstractString,AbstractVector}} list of relationship types (for now just: class and member)
relationships = Dict("class" => getidvec(), "member" => getidvec())
# define Associative Memory of all synsets (for now just: dog, canine, pack)

function example1()
    println("Given a vector x = [1, 2, 3, 4, 5], the involution of x should ",
            "return the vector x_bar = [1, 5, 4, 3, 2].")
    input = Vector{Float64}([1.0,2.0,3.0,4.0,5.0])
    println("\nInput:")
    printv(input)
    output = hrr.invol(input)
    println("Output:")
    printv(output)
    println("\n\n")
end


println("####### START OF EXAMPLES #######\n\n\n")

index = 1
while true
    if !isdefined(symbol("example$index"))
        println("No \'example$index\' function; assuming end of examples.")
        break
    end

    print("Example $index.   ")
    try
        eval(parse("example$index()"))
        index += 1
    catch err
        showerror(STDERR, err, catch_backtrace())
    end
end

println("\n\n\n######## END OF EXAMPLES ########")
