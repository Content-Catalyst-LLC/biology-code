// Safe metadata validation utility for computational notebook research.

use std::collections::HashSet;

#[derive(Debug)]
struct Sample {
    sample_id: &'static str,
    species: &'static str,
    treatment: &'static str,
}

fn main() {
    let samples = vec![
        Sample { sample_id: "BIO001", species: "Danio rerio", treatment: "control" },
        Sample { sample_id: "BIO002", species: "Danio rerio", treatment: "control" },
        Sample { sample_id: "BIO003", species: "Danio rerio", treatment: "exposed" },
        Sample { sample_id: "BIO004", species: "Danio rerio", treatment: "exposed" },
    ];

    let mut identifiers = HashSet::new();
    let mut duplicate_count = 0;

    for sample in &samples {
        if !identifiers.insert(sample.sample_id) {
            duplicate_count += 1;
        }

        println!(
            "sample_id={} species={} treatment={}",
            sample.sample_id, sample.species, sample.treatment
        );
    }

    if duplicate_count == 0 {
        println!("sample_id_unique=true");
    } else {
        println!("sample_id_unique=false duplicate_count={}", duplicate_count);
    }
}
