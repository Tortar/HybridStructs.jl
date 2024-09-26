
using Test
using HybridStructs

@hybrid struct A
	x::Int
end

abstract type AbstractB{X} end

@hybrid struct B{X} <: AbstractB{X}
	x::X
	y::Int
	const z
	B{X}(x, y) where X = new{X}(x, y, 1)
	B{X}(x, y, z) where X = new{X}(x, y, z)
	function B(x::X, y, z) where X
		return new{X}(x, y, z)
	end
end

@testset "HybridStructs.jl Tests" begin

    a1 = A_Immut(1)
    a2 = A_Immut(2)
    a3 = A_Mut(3)

    @test a1.x === 1
    @test a1 isa A_Immut
    @test a2.x === 2
    @test a2 isa A_Immut
    @test a3.x === 3
    @test a3 isa A_Mut
    @test A == Union{A_Immut, A_Mut}

    @test AbstractB_Immut <: AbstractB
    @test AbstractB_Mut <: AbstractB

    b1 = B_Immut(1, 2, :im)
    b2 = B_Immut{Float64}(3, 2, 4.0)
    b3 = B_Mut{Int}(3, 2, 4.0)

    @test b1.x === 1
    @test b1 isa B_Immut{Int}
    @test b1 isa AbstractB_Immut{Int}
    @test b2.x === 3.0
    @test b2 isa B_Immut{Float64}
    @test b2 isa AbstractB_Immut{Float64}
    @test b3.x === 3
    @test b3 isa B_Mut{Int}
    @test b3 isa AbstractB_Mut{Int}
    @test B == Union{B_Immut, B_Mut}
end

