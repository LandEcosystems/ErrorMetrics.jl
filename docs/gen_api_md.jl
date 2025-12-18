using Pkg
cd(@__DIR__)
Pkg.activate(".")
# Ensure OmniTools is available (for CI/CD where it's not registered)
try
    using OmniTools
catch
    @info "OmniTools not available, adding from git..."
    Pkg.develop(url = "https://github.com/LandEcosystems/OmniTools.jl.git", rev = "main")
    using OmniTools
end
Pkg.resolve()
Pkg.instantiate()

using ErrorMetrics
using OmniTools: purpose
using InteractiveUtils: subtypes

# Read the metric.jl file to extract function implementations
metric_file = joinpath(@__DIR__, "..", "src", "metric.jl")
metric_code = read(metric_file, String)

# Function to convert Julia code to LaTeX equation
function julia_to_latex(code::String, metric_name::String)
    # Remove comments and clean up
    code = strip(code)
    
    # Dictionary of metric equations
    equations = Dict(
        "MSE" => raw"\text{MSE} = \frac{1}{n}\sum_{i=1}^{n}(y_i - \hat{y}_i)^2",
        "NAME1R" => raw"\text{NAME1R} = \frac{|\bar{\hat{y}} - \bar{y}|}{1 + \bar{y}}",
        "NMAE1R" => raw"\text{NMAE1R} = \frac{1}{n}\sum_{i=1}^{n}\frac{|y_i - \hat{y}_i|}{1 + \bar{y}}",
        "NSE" => raw"\text{NSE} = 1 - \frac{\sum_{i=1}^{n}(y_i - \hat{y}_i)^2}{\sum_{i=1}^{n}(y_i - \bar{y})^2}",
        "NSEInv" => raw"\text{NSEInv} = 1 - \text{NSE}",
        "NSEσ" => raw"\text{NSE}_\sigma = 1 - \frac{\sum_{i=1}^{n}\left(\frac{y_i - \hat{y}_i}{\sigma_i}\right)^2}{\sum_{i=1}^{n}\left(\frac{y_i - \bar{y}}{\sigma_i}\right)^2}",
        "NSEσInv" => raw"\text{NSE}_\sigma\text{Inv} = 1 - \text{NSE}_\sigma",
        "NNSE" => raw"\text{NNSE} = \frac{1}{1 + (1 - \text{NSE})} = \frac{1}{2 - \text{NSE}}",
        "NNSEInv" => raw"\text{NNSEInv} = 1 - \text{NNSE}",
        "NNSEσ" => raw"\text{NNSE}_\sigma = \frac{1}{1 + (1 - \text{NSE}_\sigma)} = \frac{1}{2 - \text{NSE}_\sigma}",
        "NNSEσInv" => raw"\text{NNSE}_\sigma\text{Inv} = 1 - \text{NNSE}_\sigma",
        "Pcor" => raw"r = \frac{\sum_{i=1}^{n}(y_i - \bar{y})(\hat{y}_i - \bar{\hat{y}})}{\sqrt{\sum_{i=1}^{n}(y_i - \bar{y})^2}\sqrt{\sum_{i=1}^{n}(\hat{y}_i - \bar{\hat{y}})^2}}",
        "PcorInv" => raw"r_{\text{Inv}} = 1 - r",
        "Pcor2" => raw"r^2 = \left(\frac{\sum_{i=1}^{n}(y_i - \bar{y})(\hat{y}_i - \bar{\hat{y}})}{\sqrt{\sum_{i=1}^{n}(y_i - \bar{y})^2}\sqrt{\sum_{i=1}^{n}(\hat{y}_i - \bar{\hat{y}})^2}}\right)^2",
        "Pcor2Inv" => raw"r^2_{\text{Inv}} = 1 - r^2",
        "NPcor" => raw"\text{NPcor} = \frac{1}{1 + (1 - r)} = \frac{1}{2 - r}",
        "NPcorInv" => raw"\text{NPcorInv} = 1 - \text{NPcor}",
        "Scor" => raw"\rho = \text{Spearman}(y, \hat{y})",
        "ScorInv" => raw"\rho_{\text{Inv}} = 1 - \rho",
        "Scor2" => raw"\rho^2 = (\text{Spearman}(y, \hat{y}))^2",
        "Scor2Inv" => raw"\rho^2_{\text{Inv}} = 1 - \rho^2",
        "NScor" => raw"\text{NScor} = \frac{1}{1 + (1 - \rho)} = \frac{1}{2 - \rho}",
        "NScorInv" => raw"\text{NScorInv} = 1 - \text{NScor}",
    )
    
    return get(equations, metric_name, "Equation not available")
end

# Extract function code from metric.jl
function extract_function_code(code::String, metric_name::String)
    # Find the function definition
    pattern = Regex("function metric\\(::$metric_name[^\\n]*\\n(.*?)end", "s")
    m = match(pattern, code)
    if m !== nothing
        body = strip(m.captures[1])
        # Create a clean function signature
        func_code = "function metric(::$metric_name, ŷ::AbstractArray, y::AbstractArray, yσ::AbstractArray)\n"
        func_code *= "    " * replace(body, "\n" => "\n    ")
        func_code *= "\nend"
        return func_code
    end
    return nothing
end

# Generate API documentation
api_path = joinpath(@__DIR__, "src", "api.md")
open(api_path, "w") do io
    write(io, "```@meta\n")
    write(io, "CurrentModule = ErrorMetrics\n")
    write(io, "```\n\n")
    write(io, "# API\n\n")
    write(io, "## Complete API Reference\n\n")
    write(io, "```@autodocs\n")
    write(io, "Modules = [ErrorMetrics]\n")
    write(io, "Order = [:module, :type, :function]\n")
    write(io, "```\n\n")
    write(io, "## Metrics\n\n")
    
    # Get all metric types
    error_metric_types = subtypes(ErrorMetric)
    sort!(error_metric_types, by=nameof)
    
    # Group by category
    error_based = filter(t -> nameof(t) in [:MSE, :NAME1R, :NMAE1R], error_metric_types)
    nse_based = filter(t -> occursin("NSE", string(nameof(t))), error_metric_types)
    correlation_pearson = filter(t -> occursin("Pcor", string(nameof(t))) && !occursin("Scor", string(nameof(t))), error_metric_types)
    rank_correlation = filter(t -> occursin("Scor", string(nameof(t))), error_metric_types)
    
    # Helper function to write metric documentation
    function write_metric(io, typ, category_name)
        type_name = string(nameof(typ))
        metric_purpose = ErrorMetrics.purpose(typ)
        
        write(io, "### $type_name\n\n")
        write(io, "$metric_purpose")
        
        # Mathematical equation - placed directly after purpose
        equation = julia_to_latex("", type_name)
        if equation != "Equation not available"
            write(io, "\n\n")
            # Use $$ syntax - escape $ for Documenter (\\$ writes \$ to file, which Documenter treats as literal $)
            write(io, "\\\$\\\$\n")
            write(io, equation)
            write(io, "\n\\\$\\\$\n\n")
        else
            write(io, "\n\n")
        end
        
        # Function definition - collapsible section using VitePress custom container
        func_code = extract_function_code(metric_code, type_name)
        if func_code !== nothing
            # Use VitePress custom container syntax for collapsible sections
            write(io, "\n\n")
            write(io, "::: details Code\n\n")
            write(io, "```julia\n")
            write(io, func_code)
            write(io, "\n```\n\n")
            write(io, ":::\n\n")
        end
        
        write(io, "---\n\n")
    end
    
    # Error-based Metrics
    if !isempty(error_based)
        write(io, "## Error-based Metrics\n\n")
        for typ in error_based
            write_metric(io, typ, "Error-based")
        end
    end
    
    # Nash-Sutcliffe Efficiency Metrics
    if !isempty(nse_based)
        write(io, "## Nash-Sutcliffe Efficiency Metrics\n\n")
        for typ in nse_based
            write_metric(io, typ, "NSE")
        end
    end
    
    # Correlation-based Metrics
    if !isempty(correlation_pearson)
        write(io, "## Correlation-based Metrics\n\n")
        for typ in correlation_pearson
            write_metric(io, typ, "Correlation")
        end
    end
    
    # Rank Correlation Metrics
    if !isempty(rank_correlation)
        write(io, "## Rank Correlation Metrics\n\n")
        for typ in rank_correlation
            write_metric(io, typ, "Rank Correlation")
        end
    end
end

println("Generated API documentation at: $api_path")
