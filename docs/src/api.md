```@meta
CurrentModule = ErrorMetrics
```

# API

## Complete API Reference

```@autodocs
Modules = [ErrorMetrics]
Order = [:module, :type, :function]
```

## Metrics

## Error-based Metrics

### MSE

Mean Squared Error: Measures the average squared difference between predicted and observed values

\$\$
\text{MSE} = \frac{1}{n}\sum_{i=1}^{n}(y_i - \hat{y}_i)^2
\$\$



::: details Code

```julia
function metric(::MSE, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    return mean(abs2.(y .- ŷ))
end
```

:::

---

### NAME1R

Normalized Absolute Mean Error with 1/R scaling: Measures the absolute difference between means normalized by the range of observations

\$\$
\text{NAME1R} = \frac{|\bar{\hat{y}} - \bar{y}|}{1 + \bar{y}}
\$\$



::: details Code

```julia
function metric(::NAME1R, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    μ_y = mean(y)
        μ_ŷ = mean(ŷ)
        NMAE1R = abs(μ_ŷ - μ_y) / (one(eltype(ŷ)) + μ_y)
        return NMAE1R
end
```

:::

---

### NMAE1R

Normalized Mean Absolute Error with 1/R scaling: Measures the average absolute error normalized by the range of observations

\$\$
\text{NMAE1R} = \frac{1}{n}\sum_{i=1}^{n}\frac{|y_i - \hat{y}_i|}{1 + \bar{y}}
\$\$



::: details Code

```julia
function metric(::NMAE1R, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    μ_y = mean(y)
        NMAE1R = mean(abs.(ŷ - y)) / (one(eltype(ŷ)) + μ_y)
        return NMAE1R
end
```

:::

---

## Nash-Sutcliffe Efficiency Metrics

### NNSE

Normalized Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations, normalized to [0,1] range

\$\$
\text{NNSE} = \frac{1}{1 + (1 - \text{NSE})} = \frac{1}{2 - \text{NSE}}
\$\$



::: details Code

```julia
function metric(::NNSE, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NSE_v = metric(y, yσ, ŷ, NSE())
        NNSE = one(eltype(ŷ)) / (one(eltype(ŷ)) + one(eltype(ŷ)) - NSE_v)
        return NNSE
end
```

:::

---

### NNSEInv

Inverse Normalized Nash-Sutcliffe Efficiency: Inverse of NNSE for minimization problems, normalized to [0,1] range

\$\$
\text{NNSEInv} = 1 - \text{NNSE}
\$\$



::: details Code

```julia
function metric(::NNSEInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NNSEInv = one(eltype(ŷ)) - metric(y, yσ, ŷ, NNSE())
        return NNSEInv
end
```

:::

---

### NNSEσ

Normalized Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the normalized performance measure

\$\$
\text{NNSE}_\sigma = \frac{1}{1 + (1 - \text{NSE}_\sigma)} = \frac{1}{2 - \text{NSE}_\sigma}
\$\$



::: details Code

```julia
function metric(::NNSEσ, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NSE_v = metric(y, yσ, ŷ, NSEσ())
        NNSE = one(eltype(ŷ)) / (one(eltype(ŷ)) + one(eltype(ŷ)) - NSE_v)
        return NNSE
end
```

:::

---

### NNSEσInv

Inverse Normalized Nash-Sutcliffe Efficiency with uncertainty: Inverse of NNSEσ for minimization problems

\$\$
\text{NNSE}_\sigma\text{Inv} = 1 - \text{NNSE}_\sigma
\$\$



::: details Code

```julia
function metric(::NNSEσInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NNSEInv = one(eltype(ŷ)) - metric(y, yσ, ŷ, NNSEσ())
        return NNSEInv
end
```

:::

---

### NSE

Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations

\$\$
\text{NSE} = 1 - \frac{\sum_{i=1}^{n}(y_i - \hat{y}_i)^2}{\sum_{i=1}^{n}(y_i - \bar{y})^2}
\$\$



::: details Code

```julia
function metric(::NSE, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NSE = one(eltype(ŷ)) .- sum(abs2.((y .- ŷ))) / sum(abs2.((y .- mean(y))))
        return NSE
end
```

:::

---

### NSEInv

Inverse Nash-Sutcliffe Efficiency: Inverse of NSE for minimization problems

\$\$
\text{NSEInv} = 1 - \text{NSE}
\$\$



::: details Code

```julia
function metric(::NSEInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NSEInv = one(eltype(ŷ)) - metric(y, yσ, ŷ, NSE())
        return NSEInv
end
```

:::

---

### NSEσ

Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the performance measure

\$\$
\text{NSE}_\sigma = 1 - \frac{\sum_{i=1}^{n}\left(\frac{y_i - \hat{y}_i}{\sigma_i}\right)^2}{\sum_{i=1}^{n}\left(\frac{y_i - \bar{y}}{\sigma_i}\right)^2}
\$\$



::: details Code

```julia
function metric(::NSEσ, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NSE =
            one(eltype(ŷ)) .-
            sum(abs2.((y .- ŷ) ./ yσ)) /
            sum(abs2.((y .- mean(y)) ./ yσ))
        return NSE
end
```

:::

---

### NSEσInv

Inverse Nash-Sutcliffe Efficiency with uncertainty: Inverse of NSEσ for minimization problems

\$\$
\text{NSE}_\sigma\text{Inv} = 1 - \text{NSE}_\sigma
\$\$



::: details Code

```julia
function metric(::NSEσInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    NSEInv = one(eltype(ŷ)) - metric(y, yσ, ŷ, NSEσ())
        return NSEInv
end
```

:::

---

## Correlation-based Metrics

### NPcor

Normalized Pearson Correlation: Measures linear correlation between predictions and observations, normalized to [0,1] range

\$\$
\text{NPcor} = \frac{1}{1 + (1 - r)} = \frac{1}{2 - r}
\$\$



::: details Code

```julia
function metric(::NPcor, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    r = cor(y, ŷ)
        one_r = one(r)
        n_r = one_r / (one_r + one_r -r)
        return n_r
end
```

:::

---

### NPcorInv

Inverse Normalized Pearson Correlation: Inverse of NPcor for minimization problems

\$\$
\text{NPcorInv} = 1 - \text{NPcor}
\$\$



::: details Code

```julia
function metric(::NPcorInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    n_r = metric(y, yσ, ŷ, NPcor())
        return one(n_r) - n_r
end
```

:::

---

### Pcor

Pearson Correlation: Measures linear correlation between predictions and observations

\$\$
r = \frac{\sum_{i=1}^{n}(y_i - \bar{y})(\hat{y}_i - \bar{\hat{y}})}{\sqrt{\sum_{i=1}^{n}(y_i - \bar{y})^2}\sqrt{\sum_{i=1}^{n}(\hat{y}_i - \bar{\hat{y}})^2}}
\$\$



::: details Code

```julia
function metric(::Pcor, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    return cor(y[:], ŷ[:])
end
```

:::

---

### Pcor2

Squared Pearson Correlation: Measures the strength of linear relationship between predictions and observations

\$\$
r^2 = \left(\frac{\sum_{i=1}^{n}(y_i - \bar{y})(\hat{y}_i - \bar{\hat{y}})}{\sqrt{\sum_{i=1}^{n}(y_i - \bar{y})^2}\sqrt{\sum_{i=1}^{n}(\hat{y}_i - \bar{\hat{y}})^2}}\right)^2
\$\$



::: details Code

```julia
function metric(::Pcor2, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    r = metric(y, yσ, ŷ, Pcor())
        return r * r
end
```

:::

---

### Pcor2Inv

Inverse Squared Pearson Correlation: Inverse of Pcor2 for minimization problems

\$\$
r^2_{\text{Inv}} = 1 - r^2
\$\$



::: details Code

```julia
function metric(::Pcor2Inv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    r2Inv = one(eltype(ŷ)) - metric(y, yσ, ŷ, Pcor2())
        return r2Inv
end
```

:::

---

### PcorInv

Inverse Pearson Correlation: Inverse of Pcor for minimization problems

\$\$
r_{\text{Inv}} = 1 - r
\$\$



::: details Code

```julia
function metric(::PcorInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    rInv = one(eltype(ŷ)) - metric(y, yσ, ŷ, Pcor())
        return rInv
end
```

:::

---

## Rank Correlation Metrics

### NScor

Normalized Spearman Correlation: Measures monotonic relationship between predictions and observations, normalized to [0,1] range

\$\$
\text{NScor} = \frac{1}{1 + (1 - \rho)} = \frac{1}{2 - \rho}
\$\$



::: details Code

```julia
function metric(::NScor, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    ρ = corspearman(y, ŷ)
        one_ρ = one(ρ)
        n_ρ = one_ρ / (one_ρ + one_ρ -ρ)
        return n_ρ
end
```

:::

---

### NScorInv

Inverse Normalized Spearman Correlation: Inverse of NScor for minimization problems

\$\$
\text{NScorInv} = 1 - \text{NScor}
\$\$



::: details Code

```julia
function metric(::NScorInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    n_ρ = metric(y, yσ, ŷ, NScor())
        return one(n_ρ) - n_ρ
end
```

:::

---

### Scor

Spearman Correlation: Measures monotonic relationship between predictions and observations

\$\$
\rho = \text{Spearman}(y, \hat{y})
\$\$



::: details Code

```julia
function metric(::Scor, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    return corspearman(y[:], ŷ[:])
end
```

:::

---

### Scor2

Squared Spearman Correlation: Measures the strength of monotonic relationship between predictions and observations

\$\$
\rho^2 = (\text{Spearman}(y, \hat{y}))^2
\$\$



::: details Code

```julia
function metric(::Scor2, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    ρ = metric(y, yσ, ŷ, Scor())
        return ρ * ρ
end
```

:::

---

### Scor2Inv

Inverse Squared Spearman Correlation: Inverse of Scor2 for minimization problems

\$\$
\rho^2_{\text{Inv}} = 1 - \rho^2
\$\$



::: details Code

```julia
function metric(::Scor2Inv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    ρ2Inv = one(eltype(ŷ)) - metric(y, yσ, ŷ, Scor2())
        return ρ2Inv
end
```

:::

---

### ScorInv

Inverse Spearman Correlation: Inverse of Scor for minimization problems

\$\$
\rho_{\text{Inv}} = 1 - \rho
\$\$



::: details Code

```julia
function metric(::ScorInv, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)
    ρInv = one(eltype(ŷ)) - metric(y, yσ, ŷ, Scor())
        return ρInv
end
```

:::

---

