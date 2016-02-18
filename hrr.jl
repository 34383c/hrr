module hrr

# TODO: introduce in-place methods?

export cconv, vadd, invol

# BINDING -- circular convolution of two vectors with the same dimensions
function cconv{T <: Real}(x::AbstractVector{T}, y::AbstractVector{T})
    if isempty(x) || isempty(y)
        throw(ArgumentError("arguments must not be empty"))
    end
    if length(x) != length(y)
        throw(ArgumentError("dimensions of arguments must match"))
    end

    result = zeros(x)
    for i in 1:length(result)
        for j in 1:length(result)
            result[i] += x[j] * y[mod((i - j) - 1, length(result)) + 1]
        end
    end
    return result
end

# SUPERPOSITION -- vector addition
function vadd{T <: Real}(x::AbstractVector{T}, y::AbstractVector{T})
    if isempty(x) || isempty(y)
        throw(ArgumentError("arguments must not be empty"))
    end

    return x + y
end

# UNBINDING -- involution of a vector (approximate inverse of a vector with respect to circular convolution).
function invol{T <: Real}(x::AbstractVector{T})
    if isempty(x)
        throw(ArgumentError("argument must not be empty"))
    end

    return [x[mod(-i + 1, length(x)) + 1] for i in 1:length(x)]
end

end # module hrr
