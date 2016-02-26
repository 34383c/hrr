using hrr

# would a macro be better?
# print vectors
function printv(x::Vector{Float64})
    println(summary(x))
    print("    ")
    if length(x) > 7
        for i in x[1:3] @printf "%+.4f " i end
        print(" ...  ")
        for i in x[end-2:end] @printf "%+.4f " i end
    else
        for i in x @printf "%+.4f " i end
    end
    println()
end

function example1()
    println("Involution.")

    println("\na)  Given a vector x = [1, 2, 3, 4, 5], the involution of x should return the vector [1, 5, 4, 3, 2].")

    println("\nx:")
    input = Vector{Float64}([1.0,2.0,3.0,4.0,5.0])
    printv(input)

    println("Involution of x:")
    output = hrr.invol(input)
    printv(output)

    println("\nb) Given a vector x, the involution of the involution of x should be x.")

    println("\nInvolution of the involution of x:")
    printv(hrr.invol(output))

    println("\n\n")
end

function example2()
    # Dot product can be used to measure the similarity between two
    # vectors. For unit vectors:
    # if dot product is 0, the two vectors are very dissimilar
    #     e.g. dot([1,0,1,0],[0,1,0,1]) == 0 (not unit vectors, but same principle)
    # if dot product is 1, the two vectors are the same
    #     e.g. dot(a,a) ~~ 1
    # if dot product is -1, the two vectors are the inverse of one another
    #     e.g. dot(a,-a) ~~ -1
    println("Circular convolution.")

    println("\na)  Given two uniformly distributed random vectors from the D-dimensional unit hypersphere, x and y, their circular convolution, xy, should be dissimilar to both of them.")

    println("x:")
    x = hrr.getidvec()
    printv(x)

    println("y:")
    y = hrr.getidvec()
    printv(y)

    println("xy:")
    xy = hrr.cconv(x, y)
    printv(xy)

    @printf "\nvector norm of xy (before normalizing): %f\n" norm(xy)
    #xy = xy / norm(xy)
    #@printf "vector norm of xy (after normalizing):  %f\n\n" norm(xy)

    @printf "similarity between x and xy: %f\n" dot(x,xy)
    @printf "similarity between y and xy: %f\n" dot(y,xy)

    println("\nb)  Given two uniformly distributed random vectors from the D-dimensional unit hypersphere, x and y,  and their circular convolution, xy, the circular convolution of xy with x (or y) should return a good approximation of y (or x).")

    println("x:")
    printv(x)

    println("xyy:")
    xyy = hrr.cconv(xy, hrr.invol(y))
    printv(xyy)

    @printf "\nvector norm of xyy (before normalizing): %f\n" norm(xyy)
    #xyy = xyy / norm(xyy)
    #@printf "vector norm of xyy (after normalizing):  %f\n\n" norm(xyy)

    @printf "similarity between xyy and x: %f\n" dot(xyy, x)

    println("y:")
    printv(y)

    println("xxy:")
    xxy = hrr.cconv(xy, hrr.invol(x))
    printv(xxy)

    @printf "\nvector norm of xxy (before normalizing): %f\n" norm(xxy)
    #xxy = xxy / norm(xxy)
    #@printf "vector norm of xxy (after normalizing):  %f\n\n" norm(xxy)

    @printf "similarity between xxy and y: %f\n" dot(xxy, y)

    println("\n\n")
end

#=
function example3()
    println("...")
    relationships = Dict{ASCIIString, Vector{Float64}}(
            "class"  => hrr.getidvec(),
            "member" => hrr.getidvec()
            )
    synsets = Dict{ASCIIString, Array{Float64, 2}}(
            "dog"    => [hrr.getidvec() Vector{Float64}(512)],
            "canine" => [hrr.getidvec() ones(Float64,(512))],
            "pack"   => [hrr.getidvec() Vector{Float64}(512)]
            )

    # to get dog's id vec: synsets["dog"][:, 1]
    # similarly, for the sp: synsets["dog"][:, 2]
    # to associate: hrr.associate(vec, collect(values(synsets)))
    println("\ndog_id:")
    printv(synsets["dog"][:, 1])
    dog_sp = hrr.cconv(relationships["class"], synsets["canine"][:, 1])
            + hrr.cconv(relationships["member"], synsets["pack"][:, 1])
    synsets["dog"][:, 2] = dog_sp
    println("dog_sp:")
    printv(dog_sp)

    approx_canine_id = hrr.cconv(dog_sp, hrr.invol(relationships["class"]))
    println("\ncanine_id:")
    printv(synsets["canine"][:, 1])
    println("canine_id + noise:")
    printv(approx_canine_id)

    println("\nshould be all ones...")
    associated_spvec = hrr.associate(approx_canine_id, collect(values(synsets)))
    printv(associated_spvec)

    println("\n\n")
end
=#

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
        break
    end
end

println("\n\n\n######## END OF EXAMPLES ########")
