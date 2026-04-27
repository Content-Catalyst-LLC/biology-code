// Safe command-line intervention ranking utility for synthetic biotechnology examples.

#[derive(Debug)]
struct Intervention {
    name: &'static str,
    benefit: f64,
    harm: f64,
    uncertainty: f64,
    reversibility: f64,
    access_equity: f64,
    governance: f64,
}

fn responsibility_score(item: &Intervention) -> f64 {
    item.benefit * 0.30
        + item.access_equity * 0.20
        + item.reversibility * 0.20
        + item.governance * 0.15
        - item.harm * 0.10
        - item.uncertainty * 0.05
}

fn main() {
    let interventions = vec![
        Intervention { name: "somatic_gene_therapy", benefit: 0.85, harm: 0.20, uncertainty: 0.30, reversibility: 0.60, access_equity: 0.35, governance: 0.70 },
        Intervention { name: "gene_drive_vector_control", benefit: 0.80, harm: 0.55, uncertainty: 0.70, reversibility: 0.15, access_equity: 0.50, governance: 0.35 },
        Intervention { name: "drought_tolerant_crop", benefit: 0.65, harm: 0.25, uncertainty: 0.35, reversibility: 0.55, access_equity: 0.45, governance: 0.65 },
    ];

    for intervention in &interventions {
        println!("{} responsibility_score={:.5}", intervention.name, responsibility_score(intervention));
    }
}
