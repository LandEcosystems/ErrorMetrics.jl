# ErrorMetrics.jl

[![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] [![][ci-img]][ci-url] [![][codecov-img]][codecov-url] [![Julia][julia-img]][julia-url] [![License: EUPL-1.2](https://img.shields.io/badge/License-EUPL--1.2-blue)](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12)

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://earthyscience.github.io/SINDBAD/dev/

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://earthyscience.github.io/SINDBAD/stable/

[ci-img]: https://github.com/LandEcosystems/ErrorMetrics.jl/workflows/CI/badge.svg
[ci-url]: https://github.com/LandEcosystems/ErrorMetrics.jl/actions?query=workflow%3ACI

[codecov-img]: https://codecov.io/gh/LandEcosystems/ErrorMetrics.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/LandEcosystems/ErrorMetrics.jl

[julia-img]: https://img.shields.io/badge/julia-v1.10+-blue.svg
[julia-url]: https://julialang.org/

A Julia package providing error / performance metrics for comparing model outputs with observations, designed for use in the SINDBAD framework.

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

- `MSE`
- `NAME1R`, `NMAE1R`
- `NSE`, `NSEInv`, `NSEσ`, `NSEσInv`
- `NNSE`, `NNSEInv`, `NNSEσ`, `NNSEσInv`
- `Pcor`, `PcorInv`, `Pcor2`, `Pcor2Inv`
- `Scor`, `ScorInv`, `Scor2`, `Scor2Inv`
- `NPcor`, `NPcorInv`
- `NScor`, `NScorInv`

## Documentation

For detailed documentation, see the [SINDBAD documentation](https://earthyscience.github.io/SINDBAD/stable/).

## License

This package is licensed under the EUPL-1.2 (European Union Public Licence v. 1.2). See the [LICENSE](LICENSE) file for details.

## Contributing

This package is part of the SINDBAD project. For contribution guidelines, please refer to the main [Sindbad repository](https://github.com/LandEcosystems/Sindbad).

## Authors

SINDBAD Contributors
