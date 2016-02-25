using hrr

# would a macro be better?
# print vectors
function printv(x::Vector{Float64})
    println(summary(x))
    println("    $(join(length(x) > 7 ? [x[1:3];"...";x[end-2:end]] : x, "  "))")
end

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

function example2()
    println("...")
    relationships = Dict{ASCIIString, Vector{Float64}}(
            "class"  => hrr.getidvec(),
            "member" => hrr.getidvec()
            )
    synsets = Dict{ASCIIString, Array{Float64, 2}}(
            "dog"    => [hrr.getidvec() Vector{Float64}(512)],
            "canine" => [hrr.getidvec() Vector{Float64}(512)],
            "pack"   => [hrr.getidvec() Vector{Float64}(512)]
            )

    # to get dog's id vec: synsets["dog"][:, 1]
    # similarly, for the sp: synsets["dog"][:, 2]
    # to associate: hrr.associate(vec, collect(values(synsets)))
    dog_sp = hrr.cconv(relationships["class"], synsets["canine"][:, 1])
            + hrr.cconv(relationships["member"], synsets["pack"][:, 1])
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
