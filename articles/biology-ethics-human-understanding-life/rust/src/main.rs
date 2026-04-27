// Safe command-line ethical scenario ranking utility.

#[derive(Debug)]
struct Project {
    name: &'static str,
    benefit: f64,
    harm: f64,
    uncertainty: f64,
    consent: f64,
    justice: f64,
    reversibility: f64,
}

fn ethical_review_score(project: &Project) -> f64 {
    project.benefit * 0.25
        - project.harm * 0.20
        - project.uncertainty * 0.15
        + project.consent * 0.15
        + project.justice * 0.15
        + project.reversibility * 0.10
}

fn main() {
    let projects = vec![
        Project { name: "clinical_genomics_study", benefit: 0.80, harm: 0.25, uncertainty: 0.30, consent: 0.75, justice: 0.60, reversibility: 0.70 },
        Project { name: "animal_model_experiment", benefit: 0.60, harm: 0.45, uncertainty: 0.35, consent: 0.00, justice: 0.45, reversibility: 0.30 },
        Project { name: "environmental_biosensor_release", benefit: 0.70, harm: 0.40, uncertainty: 0.55, consent: 0.40, justice: 0.50, reversibility: 0.35 },
    ];

    for project in &projects {
        println!(
            "{} ethical_review_score={:.5}",
            project.name,
            ethical_review_score(project)
        );
    }
}
