using Pkg
# Ensure OmniTools is available (for CI/CD where it's not registered)
# Add it before any other operations to avoid dependency resolution issues
try
    using OmniTools
catch
    @info "OmniTools not available, adding from git..."
    Pkg.develop(PackageSpec(url = "https://github.com/LandEcosystems/OmniTools.jl.git", rev = "main"))
    using OmniTools
end

using DocumenterVitepress
using Documenter
using ErrorMetrics
using OmniTools: get_type_docstring, show_methods_of, purpose
using InteractiveUtils: subtypes

# Generate types.md and api.md before building docs by including the generation scripts
include(joinpath(@__DIR__, "gen_types_md.jl"))
include(joinpath(@__DIR__, "gen_api_md.jl"))

makedocs(;
    sitename = "ErrorMetrics.jl",
    authors = "ErrorMetrics.jl Contributors",
    clean = true,
    format = DocumenterVitepress.MarkdownVitepress(
        repo = "github.com/LandEcosystems/ErrorMetrics.jl",
    ),
    remotes = nothing,
    draft = false,
    warnonly = true,
    source = "src",
    build = "build",
)

DocumenterVitepress.deploydocs(;
    repo = "github.com/LandEcosystems/ErrorMetrics.jl",
    target = joinpath(@__DIR__, "build"),
    branch = "gh-pages",
    devbranch = "main",
    push_preview = true
)
