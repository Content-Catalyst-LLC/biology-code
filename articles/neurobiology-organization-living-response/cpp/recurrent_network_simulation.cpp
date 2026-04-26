/*
 * Recurrent neural network response simulation in C++.
 *
 * This compact example simulates three interacting units with recurrent
 * connectivity, nonlinear activation, and time-varying external inputs.
 */

#include <array>
#include <cmath>
#include <iostream>

double sigmoid(double value) {
    return 1.0 / (1.0 + std::exp(-value));
}

int main() {
    const int time_steps = 30;
    const int units = 3;

    double weights[units][units] = {
        {0.0,  0.8, -0.4},
        {0.6,  0.0,  0.5},
        {-0.3, 0.7,  0.0}
    };

    double activity[time_steps][units] = {};
    double inputs[time_steps][units] = {};

    for (int t = 5; t < 12; ++t) {
        inputs[t][0] = 1.5;
    }

    for (int t = 10; t < 18; ++t) {
        inputs[t][1] = 1.0;
    }

    for (int t = 20; t < 26; ++t) {
        inputs[t][2] = 1.8;
    }

    for (int t = 1; t < time_steps; ++t) {
        for (int i = 0; i < units; ++i) {
            double recurrent_drive = 0.0;

            for (int j = 0; j < units; ++j) {
                recurrent_drive += weights[i][j] * activity[t - 1][j];
            }

            activity[t][i] =
                0.85 * activity[t - 1][i] +
                sigmoid(recurrent_drive + inputs[t - 1][i]);
        }
    }

    std::cout << "final_unit_1=" << activity[time_steps - 1][0] << std::endl;
    std::cout << "final_unit_2=" << activity[time_steps - 1][1] << std::endl;
    std::cout << "final_unit_3=" << activity[time_steps - 1][2] << std::endl;

    return 0;
}
