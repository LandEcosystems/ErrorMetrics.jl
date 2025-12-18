# ErrorMetrics.jl

[![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] [![][ci-img]][ci-url] [![][codecov-img]][codecov-url] [![Julia][julia-img]][julia-url] [![License: EUPL-1.2](https://img.shields.io/badge/License-EUPL--1.2-blue)](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12)

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://LandEcosystems.github.io/ErrorMetrics.jl/dev/

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://LandEcosystems.github.io/ErrorMetrics.jl/stable/

[ci-img]: https://github.com/LandEcosystems/ErrorMetrics.jl/workflows/CI/badge.svg
[ci-url]: https://github.com/LandEcosystems/ErrorMetrics.jl/actions?query=workflow%3ACI

[codecov-img]: https://codecov.io/gh/LandEcosystems/ErrorMetrics.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/LandEcosystems/ErrorMetrics.jl

[julia-img]: https://img.shields.io/badge/julia-v1.10+-blue.svg
[julia-url]: https://julialang.org/

A Julia package providing error / performance metrics for comparing model outputs with observations.

## Features

- **Loss & skill metrics**: MSE, NSE/NNSE (and inverse forms for minimization)
- **Correlation metrics**: Pearson and Spearman (and squared / normalized variants)
- **Optional uncertainty weighting**: variants that accept observational uncertainty `yσ`
- **Simple, extensible API**: dispatch on metric types via `metric(m, ŷ, y[, yσ])`

## Installation

```julia
using Pkg
Pkg.add("ErrorMetrics")
```

## Quick Start

```julia
using ErrorMetrics

y  = randn(100)           # observations
ŷ  = y .+ 0.1randn(100)   # model output

mse  = metric(MSE(),  ŷ, y)
nse  = metric(NSE(),  ŷ, y)
pcor = metric(Pcor(), ŷ, y)

# with observational uncertainty
yσ = 0.2 .* ones(100)
nseσ = metric(NSEσ(), ŷ, y, yσ)
```

## Available Metrics

- `MSE`: Mean Squared Error: Measures the average squared difference between predicted and observed values
- `NAME1R`: Normalized Absolute Mean Error with 1/R scaling: Measures the absolute difference between means normalized by the range of observations
- `NMAE1R`: Normalized Mean Absolute Error with 1/R scaling: Measures the average absolute error normalized by the range of observations
- `NSE`: Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations
- `NSEInv`: Inverse Nash-Sutcliffe Efficiency: Inverse of NSE for minimization problems
- `NSEσ`: Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the performance measure
- `NSEσInv`: Inverse Nash-Sutcliffe Efficiency with uncertainty: Inverse of NSEσ for minimization problems
- `NNSE`: Normalized Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations, normalized to [0,1] range
- `NNSEInv`: Inverse Normalized Nash-Sutcliffe Efficiency: Inverse of NNSE for minimization problems, normalized to [0,1] range
- `NNSEσ`: Normalized Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the normalized performance measure
- `NNSEσInv`: Inverse Normalized Nash-Sutcliffe Efficiency with uncertainty: Inverse of NNSEσ for minimization problems
- `Pcor`: Pearson Correlation: Measures linear correlation between predictions and observations
- `PcorInv`: Inverse Pearson Correlation: Inverse of Pcor for minimization problems
- `Pcor2`: Squared Pearson Correlation: Measures the strength of linear relationship between predictions and observations
- `Pcor2Inv`: Inverse Squared Pearson Correlation: Inverse of Pcor2 for minimization problems
- `Scor`: Spearman Correlation: Measures monotonic relationship between predictions and observations
- `ScorInv`: Inverse Spearman Correlation: Inverse of Scor for minimization problems
- `Scor2`: Squared Spearman Correlation: Measures the strength of monotonic relationship between predictions and observations
- `Scor2Inv`: Inverse Squared Spearman Correlation: Inverse of Scor2 for minimization problems
- `NPcor`: Normalized Pearson Correlation: Measures linear correlation between predictions and observations, normalized to [0,1] range
- `NPcorInv`: Inverse Normalized Pearson Correlation: Inverse of NPcor for minimization problems
- `NScor`: Normalized Spearman Correlation: Measures monotonic relationship between predictions and observations, normalized to [0,1] range
- `NScorInv`: Inverse Normalized Spearman Correlation: Inverse of NScor for minimization problems

## Documentation

For detailed documentation, see the [ErrorMetrics.jl documentation](https://landecosystems.github.io/ErrorMetrics.jl).

## License

This package is licensed under the EUPL-1.2 (European Union Public Licence v. 1.2). See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or pull request in this repository.
