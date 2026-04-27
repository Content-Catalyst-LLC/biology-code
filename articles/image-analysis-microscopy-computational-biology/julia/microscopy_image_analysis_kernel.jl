# Microscopy image-analysis kernel in Julia.

function gaussian_intensity(x, y, cx, cy, sigma, amplitude)
    distance_squared = (x - cx)^2 + (y - cy)^2
    return amplitude * exp(-distance_squared / (2.0 * sigma^2))
end

function synthetic_pixel_intensity(x, y)
    return 18.0 +
        gaussian_intensity(x, y, 18.0, 20.0, 4.0, 140.0) +
        gaussian_intensity(x, y, 42.0, 25.0, 5.0, 170.0) +
        gaussian_intensity(x, y, 30.0, 45.0, 4.5, 155.0)
end

threshold = 65.0
foreground_pixels = 0
integrated_intensity = 0.0

for y in 0:63
    for x in 0:63
        intensity = synthetic_pixel_intensity(x, y)
        if intensity >= threshold
            global foreground_pixels += 1
            global integrated_intensity += intensity
        end
    end
end

println("foreground_pixels=", foreground_pixels)
println("integrated_intensity=", round(integrated_intensity, digits=5))
