using Documenter
using ErrorMetrics

makedocs(
    modules = [ErrorMetrics],
    sitename = "ErrorMetrics.jl",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", "") == "true"),
    pages = [
        "Home" => "index.md",
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
