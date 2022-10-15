# FilterHelpers.jl

[![Build Status](https://github.com/bradcarman/FilterHelpers.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/bradcarman/FilterHelpers.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/bradcarman/FilterHelpers.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/bradcarman/FilterHelpers.jl)

This package provides some simple functions I often find I would like to have in the Julia language, similar to the `find` functions (i.e. `findfirst`, `findlast`, etc.), which return the object rather than the index.  This also includes `filtersingle` which provides the same functionality as c# [Enumerable.Single](https://learn.microsoft.com/en-us/dotnet/api/system.linq.enumerable.single?view=net-7.0) method.  

For example:

```julia
    struct Person
        id::Int
        name::String
    end

    brad = Person(1, "Brad")
    julia = Person(1, "Julia")
    audra = Person(2, "Audra")
    ellie = Person(3, "Ellie")

    people = [brad, audra, ellie, julia]

    x = filtersingle(x->x.id == 3, people) #returns the object `ellie`
    x = filtersingle(x->x.id == 1, people) #throws an exception
    x = filterfirst(x->x.id == 1, people) #returns `brad`
```
