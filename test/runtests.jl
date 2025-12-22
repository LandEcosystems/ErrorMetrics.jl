using Test
import Pkg

# Allow running this file directly from `test/` as well as via `Pkg.test()`.
if Base.find_package("ErrorMetrics") === nothing
    Pkg.develop(Pkg.PackageSpec(path=joinpath(@__DIR__, "..")))
    Pkg.instantiate()
end

@testset "ErrorMetrics.jl" begin
    using ErrorMetrics

    y = [1.0, 2.0, 3.0, 4.0, 5.0]
    ŷ = [1.1, 2.2, 2.9, 4.1, 4.8]
    yσ = fill(0.1, length(y))

    @testset "MSE" begin
        @test isapprox(metric(MSE(), ŷ, y), 0.022; atol=1e-12, rtol=0)
    end

    @testset "NSE family" begin
        nse = metric(NSE(), ŷ, y)
        @test isapprox(nse, 0.989; atol=1e-12, rtol=0)
        @test isapprox(metric(NSEInv(), ŷ, y), 1 - nse; atol=1e-12, rtol=0)

        nseσ = metric(NSEσ(), ŷ, y, yσ)
        @test isapprox(nseσ, nse; atol=1e-12, rtol=0)  # constant σ cancels in ratio
        @test isapprox(metric(NSEσ(), ŷ, y), nse; atol=1e-12, rtol=0) # omitted σ defaults to ones
        @test isapprox(metric(NSEσInv(), ŷ, y, yσ), 1 - nseσ; atol=1e-12, rtol=0)
    end

    @testset "Correlation family" begin
        p = metric(Pcor(), ŷ, y)
        @test isapprox(p, 0.9966065527770355; atol=1e-12, rtol=0)
        @test isapprox(metric(PcorInv(), ŷ, y), 1 - p; atol=1e-12, rtol=0)
        @test isapprox(metric(Pcor2(), ŷ, y), p^2; atol=1e-12, rtol=0)
        @test isapprox(metric(Pcor2Inv(), ŷ, y), 1 - p^2; atol=1e-12, rtol=0)
    end

    @testset "Argument order bridge" begin
        @test metric(y, yσ, ŷ, NSEσ()) == metric(NSEσ(), ŷ, y, yσ)
    end
end


