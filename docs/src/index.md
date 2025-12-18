# ErrorMetrics.jl

A Julia package providing error / performance metrics for comparing model outputs with observations.

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

## Available Metrics

### Error-based Metrics

- `MSE`: Mean squared error - Measures the average squared difference between predicted and observed values
- `NAME1R`: Normalized Absolute Mean Error with 1/R scaling - Measures the absolute difference between means normalized by the range of observations
- `NMAE1R`: Normalized Mean Absolute Error with 1/R scaling - Measures the average absolute error normalized by the range of observations

### Nash-Sutcliffe Efficiency Metrics

- `NSE`: Nash-Sutcliffe Efficiency - Measures model performance relative to the mean of observations
- `NSEInv`: Inverse Nash-Sutcliffe Efficiency - Inverse of NSE for minimization problems
- `NSEσ`: Nash-Sutcliffe Efficiency with uncertainty - Incorporates observation uncertainty in the performance measure
- `NSEσInv`: Inverse Nash-Sutcliffe Efficiency with uncertainty - Inverse of NSEσ for minimization problems
- `NNSE`: Normalized Nash-Sutcliffe Efficiency - Measures model performance relative to the mean of observations, normalized to [0,1] range
- `NNSEInv`: Inverse Normalized Nash-Sutcliffe Efficiency - Inverse of NNSE for minimization problems, normalized to [0,1] range
- `NNSEσ`: Normalized Nash-Sutcliffe Efficiency with uncertainty - Incorporates observation uncertainty in the normalized performance measure
- `NNSEσInv`: Inverse Normalized Nash-Sutcliffe Efficiency with uncertainty - Inverse of NNSEσ for minimization problems

### Correlation-based Metrics

- `Pcor`: Pearson Correlation - Measures linear correlation between predictions and observations
- `PcorInv`: Inverse Pearson Correlation - Inverse of Pcor for minimization problems
- `Pcor2`: Squared Pearson Correlation - Measures the strength of linear relationship between predictions and observations
- `Pcor2Inv`: Inverse Squared Pearson Correlation - Inverse of Pcor2 for minimization problems
- `NPcor`: Normalized Pearson Correlation - Measures linear correlation between predictions and observations, normalized to [0,1] range
- `NPcorInv`: Inverse Normalized Pearson Correlation - Inverse of NPcor for minimization problems

### Rank Correlation Metrics

- `Scor`: Spearman Correlation - Measures monotonic relationship between predictions and observations
- `ScorInv`: Inverse Spearman Correlation - Inverse of Scor for minimization problems
- `Scor2`: Squared Spearman Correlation - Measures the strength of monotonic relationship between predictions and observations
- `Scor2Inv`: Inverse Squared Spearman Correlation - Inverse of Scor2 for minimization problems
- `NScor`: Normalized Spearman Correlation - Measures monotonic relationship between predictions and observations, normalized to [0,1] range
- `NScorInv`: Inverse Normalized Spearman Correlation - Inverse of NScor for minimization problems

## Adding a New Metric

### 1. Define the Metric Type

Create a new metric type in the ErrorMetrics.jl source:

```julia
export NewMetric
struct NewMetric <: ErrorMetric end
```

Requirements:
- Use PascalCase for the type name
- Make it a subtype of `ErrorMetric`
- Export the type
- Add a purpose function describing the metric's role

### 2. Implement the Metric Function

Implement the metric calculation:

```julia
function metric(::NewMetric, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    # Your metric calculation here
    return metric_value
end
```

Requirements:
- Function must be named `metric`
- Must take four arguments:
  - `ŷ`: Model simulation data/estimate
  - `y`: Observation data
  - `yσ`: Observational uncertainty data
  - The metric type
- Must return a scalar value

### 3. Define Purpose

Add a purpose function for your metric type:

```julia
import OmniTools: purpose

purpose(::Type{NewMetric}) = "Description of what NewMetric does"
```

### 4. Testing

Test your new metric by:
- Running it on sample data
- Comparing results with existing metrics
- Verifying it works correctly with different data types and sizes
- Testing edge cases (e.g., NaN values)

## Examples

### Calculating Metrics

```julia
using ErrorMetrics

# Define observations and model output
y = [1.0, 2.0, 3.0]  # observations
yσ = [0.1, 0.1, 0.1]  # uncertainties
ŷ = [1.1, 2.1, 3.1]  # model output

# Calculate MSE
mse = metric(MSE(), ŷ, y, yσ)

# Calculate correlation
correlation = metric(Pcor(), ŷ, y, yσ)

# Calculate NSE with uncertainty
nse_uncertain = metric(NSEσ(), ŷ, y, yσ)
```

### Using Multiple Metrics

```julia
using ErrorMetrics

# Calculate multiple metrics for comparison
metrics = Dict(
    :mse => metric(MSE(), ŷ, y, yσ),
    :nse => metric(NSE(), ŷ, y, yσ),
    :pcor => metric(Pcor(), ŷ, y, yσ),
    :scor => metric(Scor(), ŷ, y, yσ)
)
```

## Best Practices

1. **Documentation**
   - Add clear documentation for your new metric
   - Include mathematical formulas if applicable
   - Provide usage examples

2. **Testing**
   - Test with various data types and sizes
   - Verify edge cases (e.g., NaN values)
   - Compare with existing metrics

3. **Performance**
   - Optimize for large datasets
   - Consider memory usage
   - Handle missing values appropriately

4. **Compatibility**
   - Ensure compatibility with existing workflows
   - Follow the established interface
   - Maintain consistent error handling

## Defining Purpose for Metric Types

Each metric type in ErrorMetrics.jl should have a `purpose` function that describes its role. This helps with documentation and provides clear information about what each metric does.

### How to Define Purpose

1. Make sure that the base `purpose` function from OmniTools is already imported:
```julia
import OmniTools: purpose
```

2. Then, `purpose` can be easily extended for your metric type:
```julia
# For a concrete metric type
purpose(::Type{MyMetric}) = "Description of what MyMetric does"
```

### Best Practices
- Keep descriptions concise but informative
- Focus on what the metric measures and how it's calculated
- Include any normalization or scaling factors in the description
- For abstract types, clearly indicate their role in the type hierarchy
