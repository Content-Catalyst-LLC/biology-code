# Compact reproducibility kernel in Julia.
# This dependency-free example calculates workflow completeness.

required_steps = 6
documented_steps = 6
failed_cells = 0
executed_cells = 4

workflow_completeness = documented_steps / required_steps
failure_rate = failed_cells / executed_cells

println("workflow_completeness=", round(workflow_completeness, digits=5))
println("failure_rate=", round(failure_rate, digits=5))

if workflow_completeness == 1.0 && failure_rate == 0.0
    println("status=pass")
else
    println("status=review")
end
