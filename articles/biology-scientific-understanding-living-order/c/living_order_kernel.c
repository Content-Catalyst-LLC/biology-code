/*
 * Compact living-order kernel in C.
 */

#include <math.h>
#include <stdio.h>

double homeostatic_state(double time, double initial_value, double setpoint, double correction_rate) {
    return setpoint + (initial_value - setpoint) * exp(-correction_rate * time);
}

double recovery_index(double initial_value, double final_value, double setpoint) {
    double initial_deviation = fabs(initial_value - setpoint);
    if (initial_deviation == 0.0) {
        return 1.0;
    }
    return 1.0 - fabs(final_value - setpoint) / initial_deviation;
}

double exponential_growth(double time, double n0, double growth_rate) {
    return n0 * exp(growth_rate * time);
}

double logistic_growth(double time, double n0, double growth_rate, double carrying_capacity) {
    return carrying_capacity / (1.0 + ((carrying_capacity - n0) / n0) * exp(-growth_rate * time));
}

double feedback_response(double state, double setpoint, double gain) {
    return gain * (setpoint - state);
}

int main(void) {
    double final_state = homeostatic_state(5.0, 10.0, 2.0, 0.4);
    double r = log(735.0 / 100.0) / 10.0;

    printf("homeostatic_state_t5=%.6f\n", final_state);
    printf("recovery_index=%.6f\n", recovery_index(10.0, final_state, 2.0));
    printf("growth_rate=%.6f\n", r);
    printf("doubling_time=%.6f\n", log(2.0) / r);
    printf("exponential_growth_t10=%.6f\n", exponential_growth(10.0, 100.0, r));
    printf("logistic_growth_t40=%.6f\n", logistic_growth(40.0, 100.0, 0.35, 1200.0));
    printf("feedback_response=%.6f\n", feedback_response(10.0, 2.0, 0.5));

    return 0;
}
