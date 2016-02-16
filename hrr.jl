module hrr

# TODO: ::Vector{T} (or ::AbstractVector{T} (whats the difference?)) instead of
#       ::Array{Float64, 1}, where T <: Real? (If implem for diff types are too
#       diff, consider methods?)
# TODO: throw argument errors instead of asserts?
# TODO: consider removing the debug functionality?

# move to another file?
# would a macro be better?
# print vectors
function printv(x::Vector)
    println(summary(x))
    println("    $(join(length(x) > 7 ? [x[1:3];"...";x[end-2:end]] : x, "  "))")
end

export cconv, vadd, invol

# BINDING -- circular convolution of two vectors with the same dimensions
function cconv(x::Array{Float64, 1}, y::Array{Float64, 1}; debug=false)
    @assert(length(x) > 0 && length(y) > 0, "the length of the vectors must be greater than zero")
    @assert(length(x) == length(y), "the vectors must be of the same dimensions")
    if debug
        println("x = $x")
        println("y = $y")
    end
    result = Array{Float64, 1}(length(x))
    for i in 1:length(result)
        term = Float64(0)
        for j in 1:length(result)
            term += x[j] * y[mod((i - j) - 1, 3) + 1]
        end
        result[i] = term
    end
    if debug
        println("x*y = $result")
    end
    result
end

# TODO: ::Vector instead of ::Array{Float64, 1}? (Need to make sure cconv is valid for any type of vector)
# SUPERPOSITION -- vector addition
function vadd(x::Array{Float64, 1}, y::Array{Float64, 1}; debug=false)
    isempty(x) && throw(ArgumentError("argument must not be empty"))
    if debug
        println("x = $x")
        println("y = $y")
    end
    x+y
end

# UNBINDING -- involution of a vector (approximate inverse of a vector with respect to circular convolution).
function invol(x::Vector; debug=false)
    isempty(x) && throw(ArgumentError("argument must not be empty"))
    if debug
        printv(x)
    end
    result = [x[mod(-i + 1, 5) + 1] for i in 1:length(x)]
    if debug
        printv(result)
    end
    result
end

end # module hrr
