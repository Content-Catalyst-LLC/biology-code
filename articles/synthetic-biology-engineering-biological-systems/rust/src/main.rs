// Safe command-line design ranking utility for synthetic biology examples.

#[derive(Debug)]
struct Design {
    id: &'static str,
    construct_type: &'static str,
    output_signal: f64,
    host_burden: f64,
    genetic_stability: f64,
    measurement_uncertainty: f64,
}

fn engineering_score(item: &Design) -> f64 {
    item.output_signal * 0.40
        + item.genetic_stability * 0.30
        - item.host_burden * 0.20
        - item.measurement_uncertainty * 0.10
}

fn main() {
    let designs = vec![
        Design { id: "D001", construct_type: "biosensor", output_signal: 0.82, host_burden: 0.18, genetic_stability: 0.72, measurement_uncertainty: 0.12 },
        Design { id: "D002", construct_type: "biosensor", output_signal: 0.68, host_burden: 0.10, genetic_stability: 0.84, measurement_uncertainty: 0.10 },
        Design { id: "D003", construct_type: "metabolic_pathway", output_signal: 0.74, host_burden: 0.35, genetic_stability: 0.55, measurement_uncertainty: 0.18 },
    ];

    for design in &designs {
        println!(
            "{} {} engineering_score={:.5}",
            design.id,
            design.construct_type,
            engineering_score(design)
        );
    }
}
