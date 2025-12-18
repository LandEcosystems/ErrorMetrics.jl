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

```@docs
ErrorMetric
```


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

MSE


Mean Squared Error: Measures the average squared difference between predicted and observed values

MSE <: ErrorMetric <: Any



---

NAME1R


Normalized Absolute Mean Error with 1/R scaling: Measures the absolute difference between means normalized by the range of observations

NAME1R <: ErrorMetric <: Any



---

NMAE1R


Normalized Mean Absolute Error with 1/R scaling: Measures the average absolute error normalized by the range of observations

NMAE1R <: ErrorMetric <: Any



## Nash-Sutcliffe Efficiency Metrics

NNSE


Normalized Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations, normalized to [0,1] range

NNSE <: ErrorMetric <: Any



---

NNSEInv


Inverse Normalized Nash-Sutcliffe Efficiency: Inverse of NNSE for minimization problems, normalized to [0,1] range

NNSEInv <: ErrorMetric <: Any



---

NNSEσ


Normalized Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the normalized performance measure

NNSEσ <: ErrorMetric <: Any



---

NNSEσInv


Inverse Normalized Nash-Sutcliffe Efficiency with uncertainty: Inverse of NNSEσ for minimization problems

NNSEσInv <: ErrorMetric <: Any



---

NSE


Nash-Sutcliffe Efficiency: Measures model performance relative to the mean of observations

NSE <: ErrorMetric <: Any



---

NSEInv


Inverse Nash-Sutcliffe Efficiency: Inverse of NSE for minimization problems

NSEInv <: ErrorMetric <: Any



---

NSEσ


Nash-Sutcliffe Efficiency with uncertainty: Incorporates observation uncertainty in the performance measure

NSEσ <: ErrorMetric <: Any



---

NSEσInv


Inverse Nash-Sutcliffe Efficiency with uncertainty: Inverse of NSEσ for minimization problems

NSEσInv <: ErrorMetric <: Any



## Correlation-based Metrics

NPcor


Normalized Pearson Correlation: Measures linear correlation between predictions and observations, normalized to [0,1] range

NPcor <: ErrorMetric <: Any



---

NPcorInv


Inverse Normalized Pearson Correlation: Inverse of NPcor for minimization problems

NPcorInv <: ErrorMetric <: Any



---

Pcor


Pearson Correlation: Measures linear correlation between predictions and observations

Pcor <: ErrorMetric <: Any



---

Pcor2


Squared Pearson Correlation: Measures the strength of linear relationship between predictions and observations

Pcor2 <: ErrorMetric <: Any



---

Pcor2Inv


Inverse Squared Pearson Correlation: Inverse of Pcor2 for minimization problems

Pcor2Inv <: ErrorMetric <: Any



---

PcorInv


Inverse Pearson Correlation: Inverse of Pcor for minimization problems

PcorInv <: ErrorMetric <: Any



## Rank Correlation Metrics

NScor


Normalized Spearman Correlation: Measures monotonic relationship between predictions and observations, normalized to [0,1] range

NScor <: ErrorMetric <: Any



---

NScorInv


Inverse Normalized Spearman Correlation: Inverse of NScor for minimization problems

NScorInv <: ErrorMetric <: Any



---

Scor


Spearman Correlation: Measures monotonic relationship between predictions and observations

Scor <: ErrorMetric <: Any



---

Scor2


Squared Spearman Correlation: Measures the strength of monotonic relationship between predictions and observations

Scor2 <: ErrorMetric <: Any



---

Scor2Inv


Inverse Squared Spearman Correlation: Inverse of Scor2 for minimization problems

Scor2Inv <: ErrorMetric <: Any



---

ScorInv


Inverse Spearman Correlation: Inverse of Scor for minimization problems

ScorInv <: ErrorMetric <: Any



## All ErrorMetric Types

To list all available metric types and their purposes:

```julia
using ErrorMetrics
using OmniTools: show_methods_of

# Display all metric types
show_methods_of(ErrorMetric)
```
