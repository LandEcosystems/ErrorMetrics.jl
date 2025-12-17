"""
    ErrorMetrics

The `ErrorMetrics` module provides tools for evaluating model performance by comparing model outputs with observations using a variety of loss / skill / correlation metrics.

# Purpose
This module defines metric types and a `metric(m, ŷ, y[, yσ])` API to compute standard performance measures in a lightweight, extensible way.

# Included Files
- `ErrorMetricsTypes.jl`: Core ErrorMetrics types.
- `metric.jl`: Metric definitions (e.g., MSE, NSE, correlations) and helpers.


# Notes
- The module is designed to be extensible, allowing users to define custom metrics for specific use cases.
- Metrics are computed in a modular fashion and can be used in optimization / evaluation workflows.

# Examples
1. **Calculating MSE**:
```julia
using ErrorMetrics
mse = metric(MSE(), model_output, observations)
```

2. **Computing correlation**:
```julia
using ErrorMetrics
correlation = metric(Pcor(), model_output, observations)
```

"""
module ErrorMetrics

   using StatsBase

   include("ErrorMetricsTypes.jl")
   include("metric.jl")

end # module ErrorMetrics
