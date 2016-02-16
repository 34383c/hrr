module hrr

export cconv, invol

# BINDING -- circular convolution of two vectors with the same dimensions
function cconv(x::Array{Float64, 1}, y::Array{Float64, 1}, debug=false)
    @assert length(x) > 0
    @assert length(x) == length(y)
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
end

# UNBINDING -- involution of a vector (approximate inverse of a vector with respect to circular convolution).
function invol(x::Array{Float64, 1})
    @assert length(x) > 0
    result = Array{Float64, 1}(length(x))
    result
end

end # module hrr
