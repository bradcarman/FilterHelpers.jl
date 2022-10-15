module FilterHelpers

# EXCEPTIONS
struct NotUniqueError <: Exception end

function filterfirst(f::Function,items::Vector{T}) where T
    for item in items
        if f(item)
            return item
        end
    end

    return nothing
end

filterlast(f::Function,items::Vector{T}) where T = filterfirst(f, reverse(items))

function filtersingle(f,items::Vector{T}) where T
    
    found = T[]
    for item in items
        if f(item)
            push!(found, item)
        end
    end

    n = length(found)

    if n == 0
        return nothing
    elseif n == 1
        return found[]
    elseif n > 1
        @error "Found $n items, expected 1" found
        throw(NotUniqueError())
    end

end

export filterfirst, filterlast, filtersingle

end
