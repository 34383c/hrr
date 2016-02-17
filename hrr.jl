module hrr

# TODO: introduce in-place methods?

export cconv, vadd, invol

# BINDING -- circular convolution of two vectors with the same dimensions
function cconv{T <: Real}(x::AbstractVector{T}, y::AbstractVector{T})
    (isempty(x) || isempty(y)) && throw(ArgumentError("arguments must not be empty"))
    (length(x) != length(y)) && throw(ArgumentError("dimensions must match"))
    # TODO: result and term need to be of the correct type...
    result = Array{Float64, 1}(length(x))
    for i in 1:length(result)
        term = Float64(0)
        for j in 1:length(result)
            term += x[j] * y[mod((i - j) - 1, 3) + 1]
        end
        result[i] = term
    end
    result
end

# SUPERPOSITION -- vector addition
function vadd{T <: Real}(x::AbstractVector{T}, y::AbstractVector{T})
    (isempty(x) || isempty(y)) && throw(ArgumentError("arguments must not be empty"))
    x+y
end

# UNBINDING -- involution of a vector (approximate inverse of a vector with respect to circular convolution).
function invol{T <: Real}(x::AbstractVector{T})
    isempty(x) && throw(ArgumentError("argument must not be empty"))
    [x[mod(-i + 1, 5) + 1] for i in 1:length(x)]
end

end # module hrr
