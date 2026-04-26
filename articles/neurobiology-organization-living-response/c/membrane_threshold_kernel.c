/*
 * Compact membrane integration and threshold kernel in C.
 *
 * This example simulates a membrane-like state variable moving toward rest
 * under repeated input pulses.
 */

#include <stdio.h>

double input_at_time(double time) {
    if (time >= 5.0 && time < 8.0) {
        return 8.0;
    }

    if (time >= 15.0 && time < 17.0) {
        return 5.0;
    }

    if (time >= 28.0 && time < 31.0) {
        return 10.0;
    }

    return 0.0;
}

int main(void) {
    const double dt = 0.1;
    const double time_end = 40.0;
    const double tau = 3.0;
    const double v_rest = -65.0;
    const double resistance_scale = 1.0;
    const double threshold = -60.0;

    double voltage = v_rest;
    double max_voltage = voltage;
    int event_count = 0;

    for (double time = 0.0; time <= time_end; time += dt) {
        double input = input_at_time(time);
        double d_voltage = (-(voltage - v_rest) + resistance_scale * input) / tau;

        voltage += d_voltage * dt;

        if (voltage > max_voltage) {
            max_voltage = voltage;
        }

        if (voltage >= threshold) {
            event_count += 1;
        }
    }

    printf("max_voltage=%.3f\n", max_voltage);
    printf("event_count=%d\n", event_count);
    printf("final_voltage=%.3f\n", voltage);

    return 0;
}
