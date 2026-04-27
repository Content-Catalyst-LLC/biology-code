// Safe microscopy image-analysis summary utility in Rust.

fn gaussian_intensity(x: f64, y: f64, cx: f64, cy: f64, sigma: f64, amplitude: f64) -> f64 {
    let distance_squared = (x - cx).powi(2) + (y - cy).powi(2);
    amplitude * (-distance_squared / (2.0 * sigma.powi(2))).exp()
}

fn synthetic_intensity(x: f64, y: f64) -> f64 {
    18.0
        + gaussian_intensity(x, y, 18.0, 20.0, 4.0, 140.0)
        + gaussian_intensity(x, y, 42.0, 25.0, 5.0, 170.0)
        + gaussian_intensity(x, y, 30.0, 45.0, 4.5, 155.0)
}

fn main() {
    let threshold = 65.0;
    let mut foreground_pixels = 0usize;
    let mut integrated_intensity = 0.0;

    for y in 0..64 {
        for x in 0..64 {
            let intensity = synthetic_intensity(x as f64, y as f64);
            if intensity >= threshold {
                foreground_pixels += 1;
                integrated_intensity += intensity;
            }
        }
    }

    println!("foreground_pixels={}", foreground_pixels);
    println!("integrated_intensity={:.5}", integrated_intensity);
}
