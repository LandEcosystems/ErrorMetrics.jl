using Pkg
cd(@__DIR__)
Pkg.activate(".")
Pkg.develop(path="../../OmniTools.jl")
Pkg.resolve()
Pkg.instantiate()

using ErrorMetrics
using OmniTools: get_type_docstring, show_methods_of, get_definitions, purpose
using InteractiveUtils: subtypes

# Generate types.md
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
    write(io, "```@docs\n")
    write(io, "ErrorMetric\n")
    write(io, "```\n\n")
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
    
    # Helper function to format type docstring without redundant headings
    function format_type_docstring(typ, purpose_function)
        docstr = get_type_docstring(typ, purpose_function=purpose_function)
        type_name = string(nameof(typ))
        
        # Remove the # TypeName heading and ## Type Hierarchy heading
        lines = split(docstr, '\n')
        result_lines = String[]
        skip_next_empty = false
        in_type_hierarchy = false
        
        for line in lines
            # Skip the # TypeName heading
            if startswith(line, "# $(type_name)")
                skip_next_empty = true
                continue
            end
            
            # Skip empty lines after removed heading
            if skip_next_empty && isempty(strip(line))
                skip_next_empty = false
                continue
            end
            skip_next_empty = false
            
            # Skip the ## Type Hierarchy heading
            if startswith(line, "## Type Hierarchy")
                in_type_hierarchy = true
                continue
            end
            
            # Process the type hierarchy line (the ```TypeName <: ...``` line)
            if in_type_hierarchy
                if startswith(line, "```")
                    # Remove code block markers and keep just the content
                    hierarchy_line = replace(line, r"```+" => "")
                    hierarchy_line = strip(hierarchy_line)
                    if !isempty(hierarchy_line)
                        push!(result_lines, hierarchy_line)
                    end
                    in_type_hierarchy = false
                    continue
                elseif isempty(strip(line))
                    continue
                end
            end
            
            push!(result_lines, line)
        end
        
        return join(result_lines, '\n')
    end
    
    # Error-based Metrics
    if !isempty(error_based)
        write(io, "## Error-based Metrics\n\n")
        for (idx, typ) in enumerate(error_based)
            type_name = string(nameof(typ))
            write(io, "$(type_name)\n\n")
            formatted = format_type_docstring(typ, error_metric_purpose)
            write(io, formatted)
            write(io, "\n\n")
            # Add separator between metrics, but not after the last one
            if idx < length(error_based)
                write(io, "---\n\n")
            end
        end
    end
    
    # Nash-Sutcliffe Efficiency Metrics
    if !isempty(nse_based)
        write(io, "## Nash-Sutcliffe Efficiency Metrics\n\n")
        for (idx, typ) in enumerate(nse_based)
            type_name = string(nameof(typ))
            write(io, "$(type_name)\n\n")
            formatted = format_type_docstring(typ, error_metric_purpose)
            write(io, formatted)
            write(io, "\n\n")
            # Add separator between metrics, but not after the last one
            if idx < length(nse_based)
                write(io, "---\n\n")
            end
        end
    end
    
    # Correlation-based Metrics
    correlation_pearson = filter(t -> occursin("Pcor", string(nameof(t))) && !occursin("Scor", string(nameof(t))), error_metric_types)
    if !isempty(correlation_pearson)
        write(io, "## Correlation-based Metrics\n\n")
        for (idx, typ) in enumerate(correlation_pearson)
            type_name = string(nameof(typ))
            write(io, "$(type_name)\n\n")
            formatted = format_type_docstring(typ, error_metric_purpose)
            write(io, formatted)
            write(io, "\n\n")
            # Add separator between metrics, but not after the last one
            if idx < length(correlation_pearson)
                write(io, "---\n\n")
            end
        end
    end
    
    # Rank Correlation Metrics
    if !isempty(rank_correlation)
        write(io, "## Rank Correlation Metrics\n\n")
        for (idx, typ) in enumerate(rank_correlation)
            type_name = string(nameof(typ))
            write(io, "$(type_name)\n\n")
            formatted = format_type_docstring(typ, error_metric_purpose)
            write(io, formatted)
            write(io, "\n\n")
            # Add separator between metrics, but not after the last one
            if idx < length(rank_correlation)
                write(io, "---\n\n")
            end
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

println("Generated types documentation at: $types_path")
