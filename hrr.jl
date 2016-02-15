# circular convolution of two vectors with the same dimension
function vcconv(x::Array{Float64, 1}, y::Array{Float64, 1}, debug=false)
    @assert length(x) == length(y)
    if (debug)
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
    if (debug)
        println("x*y = $result")
    end
end
