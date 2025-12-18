# ErrorMetrics Types

This page documents all types defined in ErrorMetrics.jl, generated using `get_type_docstring` from OmniTools.jl.

```@meta
CurrentModule = ErrorMetrics
DocTestSetup = quote
using ErrorMetrics
using OmniTools: get_type_docstring, show_methods_of
end
```

## ErrorMetric


# ErrorMetric

Abstract type for error / performance metrics

## Type Hierarchy

```ErrorMetric <: Any```

-----

# Extended help

## Available methods/subtypes:

 -  `MSE`: Mean Squared Error: Measures the average squared difference between predicted and observed values 
 -  `NAME1R`: Normalized Absolute Mean Error with 1/R scaling: Measures the absolute difference between means normalized by the range of observations 
 -  `NMAE1R`: Normalized Mean Absolute Error with 1/R scaling: Measures the average absolute error normalized by the range of observations 
 -  `NNSE`: Normalized Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations, normalized to [0,1] range 
 -  `NNSEInv`: Inverse Normalized Nash-Sutcliffe Efficiency: Inverse of NNSE for minimization problems, normalized to [0,1] range 
 -  `NNSEσ`: Normalized Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the normalized performance measure 
 -  `NNSEσInv`: Inverse Normalized Nash-Sutcliffe Efficiency with uncertainty: Inverse of NNSEσ for minimization problems 
 -  `NPcor`: Normalized Pearson Correlation: Measures linear correlation between predictions and observations, normalized to [0,1] range 
 -  `NPcorInv`: Inverse Normalized Pearson Correlation: Inverse of NPcor for minimization problems 
 -  `NSE`: Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations 
 -  `NSEInv`: Inverse Nash-Sutcliffe Efficiency: Inverse of NSE for minimization problems 
 -  `NSEσ`: Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the performance measure 
 -  `NSEσInv`: Inverse Nash-Sutcliffe Efficiency with uncertainty: Inverse of NSEσ for minimization problems 
 -  `NScor`: Normalized Spearman Correlation: Measures monotonic relationship between predictions and observations, normalized to [0,1] range 
 -  `NScorInv`: Inverse Normalized Spearman Correlation: Inverse of NScor for minimization problems 
 -  `Pcor`: Pearson Correlation: Measures linear correlation between predictions and observations 
 -  `Pcor2`: Squared Pearson Correlation: Measures the strength of linear relationship between predictions and observations 
 -  `Pcor2Inv`: Inverse Squared Pearson Correlation: Inverse of Pcor2 for minimization problems 
 -  `PcorInv`: Inverse Pearson Correlation: Inverse of Pcor for minimization problems 
 -  `Scor`: Spearman Correlation: Measures monotonic relationship between predictions and observations 
 -  `Scor2`: Squared Spearman Correlation: Measures the strength of monotonic relationship between predictions and observations 
 -  `Scor2Inv`: Inverse Squared Spearman Correlation: Inverse of Scor2 for minimization problems 
 -  `ScorInv`: Inverse Spearman Correlation: Inverse of Scor for minimization problems 




## Error-based Metrics

### MSE


# MSE

Mean Squared Error: Measures the average squared difference between predicted and observed values

## Type Hierarchy

```MSE <: ErrorMetric <: Any```



### NAME1R


# NAME1R

Normalized Absolute Mean Error with 1/R scaling: Measures the absolute difference between means normalized by the range of observations

## Type Hierarchy

```NAME1R <: ErrorMetric <: Any```



### NMAE1R


# NMAE1R

Normalized Mean Absolute Error with 1/R scaling: Measures the average absolute error normalized by the range of observations

## Type Hierarchy

```NMAE1R <: ErrorMetric <: Any```



## Nash-Sutcliffe Efficiency Metrics

### NNSE


# NNSE

Normalized Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations, normalized to [0,1] range

## Type Hierarchy

```NNSE <: ErrorMetric <: Any```



### NNSEInv


# NNSEInv

Inverse Normalized Nash-Sutcliffe Efficiency: Inverse of NNSE for minimization problems, normalized to [0,1] range

## Type Hierarchy

```NNSEInv <: ErrorMetric <: Any```



### NNSEσ


# NNSEσ

Normalized Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the normalized performance measure

## Type Hierarchy

```NNSEσ <: ErrorMetric <: Any```



### NNSEσInv


# NNSEσInv

Inverse Normalized Nash-Sutcliffe Efficiency with uncertainty: Inverse of NNSEσ for minimization problems

## Type Hierarchy

```NNSEσInv <: ErrorMetric <: Any```



### NSE


# NSE

Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations

## Type Hierarchy

```NSE <: ErrorMetric <: Any```



### NSEInv


# NSEInv

Inverse Nash-Sutcliffe Efficiency: Inverse of NSE for minimization problems

## Type Hierarchy

```NSEInv <: ErrorMetric <: Any```



### NSEσ


# NSEσ

Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the performance measure

## Type Hierarchy

```NSEσ <: ErrorMetric <: Any```



### NSEσInv


# NSEσInv

Inverse Nash-Sutcliffe Efficiency with uncertainty: Inverse of NSEσ for minimization problems

## Type Hierarchy

```NSEσInv <: ErrorMetric <: Any```



## Correlation-based Metrics

### NPcor


# NPcor

Normalized Pearson Correlation: Measures linear correlation between predictions and observations, normalized to [0,1] range

## Type Hierarchy

```NPcor <: ErrorMetric <: Any```



### NPcorInv


# NPcorInv

Inverse Normalized Pearson Correlation: Inverse of NPcor for minimization problems

## Type Hierarchy

```NPcorInv <: ErrorMetric <: Any```



### Pcor


# Pcor

Pearson Correlation: Measures linear correlation between predictions and observations

## Type Hierarchy

```Pcor <: ErrorMetric <: Any```



### Pcor2


# Pcor2

Squared Pearson Correlation: Measures the strength of linear relationship between predictions and observations

## Type Hierarchy

```Pcor2 <: ErrorMetric <: Any```



### Pcor2Inv


# Pcor2Inv

Inverse Squared Pearson Correlation: Inverse of Pcor2 for minimization problems

## Type Hierarchy

```Pcor2Inv <: ErrorMetric <: Any```



### PcorInv


# PcorInv

Inverse Pearson Correlation: Inverse of Pcor for minimization problems

## Type Hierarchy

```PcorInv <: ErrorMetric <: Any```



## Rank Correlation Metrics

### NScor


# NScor

Normalized Spearman Correlation: Measures monotonic relationship between predictions and observations, normalized to [0,1] range

## Type Hierarchy

```NScor <: ErrorMetric <: Any```



### NScorInv


# NScorInv

Inverse Normalized Spearman Correlation: Inverse of NScor for minimization problems

## Type Hierarchy

```NScorInv <: ErrorMetric <: Any```



### Scor


# Scor

Spearman Correlation: Measures monotonic relationship between predictions and observations

## Type Hierarchy

```Scor <: ErrorMetric <: Any```



### Scor2


# Scor2

Squared Spearman Correlation: Measures the strength of monotonic relationship between predictions and observations

## Type Hierarchy

```Scor2 <: ErrorMetric <: Any```



### Scor2Inv


# Scor2Inv

Inverse Squared Spearman Correlation: Inverse of Scor2 for minimization problems

## Type Hierarchy

```Scor2Inv <: ErrorMetric <: Any```



### ScorInv


# ScorInv

Inverse Spearman Correlation: Inverse of Scor for minimization problems

## Type Hierarchy

```ScorInv <: ErrorMetric <: Any```



## All ErrorMetric Types

To list all available metric types and their purposes:

```julia
using ErrorMetrics
using OmniTools: show_methods_of

# Display all metric types
show_methods_of(ErrorMetric)
```
