// Safe command-line validation utility for synthetic life-science ML output.

#[derive(Debug)]
struct Sample {
    id: &'static str,
    observed: i32,
    probability: f64,
}

fn predicted_label(probability: f64, threshold: f64) -> i32 {
    if probability >= threshold { 1 } else { 0 }
}

fn main() {
    let samples = vec![
        Sample { id: "EXT001", observed: 1, probability: 0.91 },
        Sample { id: "EXT002", observed: 1, probability: 0.74 },
        Sample { id: "EXT003", observed: 0, probability: 0.33 },
        Sample { id: "EXT004", observed: 0, probability: 0.22 },
        Sample { id: "EXT005", observed: 1, probability: 0.68 },
        Sample { id: "EXT006", observed: 0, probability: 0.41 },
    ];

    let mut correct = 0;

    for sample in &samples {
        let predicted = predicted_label(sample.probability, 0.5);
        if predicted == sample.observed {
            correct += 1;
        }

        println!(
            "{} observed={} probability={:.3} predicted={}",
            sample.id, sample.observed, sample.probability, predicted
        );
    }

    let accuracy = correct as f64 / samples.len() as f64;
    println!("accuracy={:.5}", accuracy);
}
