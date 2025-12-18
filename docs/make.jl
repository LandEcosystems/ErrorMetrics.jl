using Documenter
using ErrorMetrics
using OmniTools: get_type_docstring, show_methods_of, purpose
using InteractiveUtils: subtypes

# Generate types.md before building docs
function generate_types_doc()
    types_path = joinpath(@__DIR__, "src/types.md")
    open(types_path, "w") do io
        write(io, "# ErrorMetrics Types\n\n")
        write(io, "This page documents all types defined in ErrorMetrics.jl, generated using `get_type_docstring` from OmniTools.jl.\n\n")
        write(io, "```@meta\n")
        write(io, "CurrentModule = ErrorMetrics\n")
        write(io, "DocTestSetup = quote\n")
        write(io, "using ErrorMetrics\n")
        write(io, "using OmniTools: get_type_docstring, show_methods_of\n")
        write(io, "end\n")
        write(io, "```\n\n")
        
        # ErrorMetric abstract type
        write(io, "## ErrorMetric\n\n")
        # Use purpose from ErrorMetrics (which extends OmniTools.purpose)
        error_metric_purpose = (typ) -> ErrorMetrics.purpose(typ)
        write(io, get_type_docstring(ErrorMetric, purpose_function=error_metric_purpose))
        write(io, "\n\n")
        
        # Get all ErrorMetric subtypes
        error_metric_types = subtypes(ErrorMetric)
        sort!(error_metric_types, by=nameof)
        
        # Group by category
        error_based = filter(t -> nameof(t) in [:MSE, :NAME1R, :NMAE1R], error_metric_types)
        nse_based = filter(t -> occursin("NSE", string(nameof(t))), error_metric_types)
        correlation_based = filter(t -> occursin("cor", lowercase(string(nameof(t)))), error_metric_types)
        rank_correlation = filter(t -> occursin("Scor", string(nameof(t))), error_metric_types)
        
        # Error-based Metrics
        if !isempty(error_based)
            write(io, "## Error-based Metrics\n\n")
            for typ in error_based
                write(io, "### $(nameof(typ))\n\n")
                write(io, get_type_docstring(typ, purpose_function=error_metric_purpose))
                write(io, "\n\n")
            end
        end
        
        # Nash-Sutcliffe Efficiency Metrics
        if !isempty(nse_based)
            write(io, "## Nash-Sutcliffe Efficiency Metrics\n\n")
            for typ in nse_based
                write(io, "### $(nameof(typ))\n\n")
                write(io, get_type_docstring(typ, purpose_function=error_metric_purpose))
                write(io, "\n\n")
            end
        end
        
        # Correlation-based Metrics
        correlation_pearson = filter(t -> occursin("Pcor", string(nameof(t))) && !occursin("Scor", string(nameof(t))), error_metric_types)
        if !isempty(correlation_pearson)
            write(io, "## Correlation-based Metrics\n\n")
            for typ in correlation_pearson
                write(io, "### $(nameof(typ))\n\n")
                write(io, get_type_docstring(typ, purpose_function=error_metric_purpose))
                write(io, "\n\n")
            end
        end
        
        # Rank Correlation Metrics
        if !isempty(rank_correlation)
            write(io, "## Rank Correlation Metrics\n\n")
            for typ in rank_correlation
                write(io, "### $(nameof(typ))\n\n")
                write(io, get_type_docstring(typ, purpose_function=error_metric_purpose))
                write(io, "\n\n")
            end
        end
        
        write(io, "## All ErrorMetric Types\n\n")
        write(io, "To list all available metric types and their purposes:\n\n")
        write(io, "```julia\n")
        write(io, "using ErrorMetrics\n")
        write(io, "using OmniTools: show_methods_of\n\n")
        write(io, "# Display all metric types\n")
        write(io, "show_methods_of(ErrorMetric)\n")
        write(io, "```\n")
    end
    @info "Generated types documentation at: $types_path"
end

# Generate types documentation before building
generate_types_doc()

makedocs(
    modules = [ErrorMetrics],
    sitename = "ErrorMetrics.jl",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", "") == "true"),
    pages = [
        "Home" => "index.md",
        "Types" => "types.md",
        "API" => "api.md",
    ],
)

if get(ENV, "GITHUB_ACTIONS", "") == "true"
    deploydocs(
        repo = "github.com/LandEcosystems/ErrorMetrics.jl",
        devbranch = "main",
        push_preview = true,
    )
end
