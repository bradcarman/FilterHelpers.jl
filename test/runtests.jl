using FilterHelpers
using Test

@testset "FilterHelpers.jl" begin
    struct Person
        id::Int
        name::String
    end

    brad = Person(1, "Brad")
    julia = Person(1, "Julia")
    audra = Person(2, "Audra")
    ellie = Person(3, "Ellie")

    people = [brad, audra, ellie, julia]

    @test filterfirst(x->x.id == 1, people) == brad
    @test filterlast(x->x.id == 1, people) == julia
    @test filtersingle(x->x.id == 2, people) == audra

    @test isnothing(filterfirst(x->x.id == 5, people))
    @test isnothing(filterlast(x->x.id == 5, people))
    @test isnothing(filtersingle(x->x.id == 5, people))

    @test_throws FilterHelpers.NotUniqueError filtersingle(x->x.id == 1, people)

end
