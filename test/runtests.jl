using FilterHelpers
using Test
using JSON3

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

@testset "JSON3.Array compatibility" begin
    # Create a JSON3.Array by parsing JSON
    json_data = """
    [
        {"id": 1, "name": "Brad"},
        {"id": 2, "name": "Audra"},
        {"id": 3, "name": "Ellie"},
        {"id": 1, "name": "Julia"}
    ]
    """

    people_json = JSON3.read(json_data)

    # Test filtersingle with JSON3.Array
    @test filtersingle(x->x.id == 2, people_json).name == "Audra"
    @test isnothing(filtersingle(x->x.id == 5, people_json))
    @test_throws FilterHelpers.NotUniqueError filtersingle(x->x.id == 1, people_json)

    # Test filterfirst and filterlast as well
    @test filterfirst(x->x.id == 1, people_json).name == "Brad"
    @test filterlast(x->x.id == 1, people_json).name == "Julia"
end
