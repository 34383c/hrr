module hrr

# TODO: introduce in-place methods?
# TODO: doc-strings?

export cconv, vadd, invol

typealias AssociativeMemory Vector{Tuple{AbstractVector, AbstractVector, AbstractString}}

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

function getIDvector(dimensions::Integer = 512)
    # Return a uniformly distributed (see Note 1) random vector from the
    # D-dimensional unit hypersphere (see Note 2).
    #
    # Note 1: we use the fact that a D-dimensional random Gaussian
    # (i.e. normally-distributed) vector, when normalised, is uniformly
    # distributed over the D-dimensional unit hypersphere.
    #
    # Note 2: A vector from the D-dimensional unit hypersphere is a unit
    # D-dimensional vector, i.e. a D-dimensional vector with vector norm
    # (i.e. L-2 norm) equal to 1.

    random_gaussian_vector = randn(dimensions)
    return random_gaussian_vector / norm(random_gaussian_vector)
end

const threshold = 0.3
function associate{T <: Real}(input::AbstractVector{T}, assoc_mem::AssociativeMemory)
    if isempty(input) || isempty(assoc_mem)
        throw(ArgumentError("arguments must not be empty"))
    end

    sum = zeros(input)
    for (sp, id, name) in assoc_mem
        similarity = dot(id, input)
        scale = (similarity > threshold) ? 1 : 0
        # if similarity > threshold
        #     if sum != zeros(sum)
        #         println("Found first id vector from assoc mem that exceeds the similarity threshold ($(name))")
        #         sum = sp
        #     else
        #         println("OOPS! Similarity threshold was exceeded for more than one id vector from the assoc mem ($(name))")
        sum += scale * sp
    end
    return sum
end

end # module hrr
