# ErrorMetrics.jl

A small Julia package providing error / performance metrics for comparing model outputs with observations.

## Quick start

```julia
using ErrorMetrics

y  = randn(100)             # observations
ŷ  = y .+ 0.1randn(100)     # model output

mse  = metric(MSE(),  ŷ, y)
nse  = metric(NSE(),  ŷ, y)
pcor = metric(Pcor(), ŷ, y)

# with observational uncertainty
yσ = 0.2 .* ones(100)
nseσ = metric(NSEσ(), ŷ, y, yσ)
```

See the [API](api.md) page for the full list of metrics.
