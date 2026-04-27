// Safe genomics sequence summary utility in Rust.

fn gc_content(sequence: &str) -> f64 {
    let mut valid = 0.0;
    let mut gc = 0.0;

    for base in sequence.chars().map(|c| c.to_ascii_uppercase()) {
        match base {
            'A' | 'T' => valid += 1.0,
            'G' | 'C' => {
                valid += 1.0;
                gc += 1.0;
            }
            _ => {}
        }
    }

    if valid == 0.0 {
        f64::NAN
    } else {
        gc / valid
    }
}

fn ambiguous_count(sequence: &str) -> usize {
    sequence
        .chars()
        .map(|c| c.to_ascii_uppercase())
        .filter(|base| !matches!(base, 'A' | 'C' | 'G' | 'T'))
        .count()
}

fn hamming_distance(a: &str, b: &str) -> usize {
    if a.len() != b.len() {
        panic!("Sequences must have equal length.");
    }

    a.chars()
        .zip(b.chars())
        .filter(|(x, y)| x.to_ascii_uppercase() != y.to_ascii_uppercase())
        .count()
}

fn main() {
    let sequence_a = "ATGCGCGTAATTAACCGGTTACCGTAGCTA";
    let sequence_b = "ATGCGCGTAATTAACCGGTTACCGTAACTA";

    println!("sequence_length={}", sequence_a.len());
    println!("gc_content={:.5}", gc_content(sequence_a));
    println!("ambiguous_bases={}", ambiguous_count(sequence_a));
    println!("hamming_distance={}", hamming_distance(sequence_a, sequence_b));
}
