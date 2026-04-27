#include <math.h>
#include <stdio.h>

// Low-level sigmoid scoring kernel for synthetic life-science ML.

double sigmoid(double z) {
    return 1.0 / (1.0 + exp(-z));
}

double predict_probability(double immune, double metabolic, double morphology, double stress) {
    double linear_score = 3.0 * immune - 2.0 * metabolic + 2.2 * morphology + 1.2 * stress - 2.0;
    return sigmoid(linear_score);
}

int main(void) {
    double immune[] = {0.82, 0.74, 0.38, 0.27, 0.63, 0.43};
    double metabolic[] = {0.22, 0.29, 0.64, 0.71, 0.36, 0.57};
    double morphology[] = {0.76, 0.70, 0.39, 0.33, 0.60, 0.45};
    double stress[] = {0.71, 0.67, 0.41, 0.36, 0.59, 0.43};
    int observed[] = {1, 1, 0, 0, 1, 0};

    int correct = 0;
    int n = 6;

    for (int i = 0; i < n; i++) {
        double probability = predict_probability(immune[i], metabolic[i], morphology[i], stress[i]);
        int predicted = probability >= 0.5 ? 1 : 0;

        if (predicted == observed[i]) {
            correct++;
        }

        printf("sample=%d probability=%.5f predicted=%d observed=%d\n", i + 1, probability, predicted, observed[i]);
    }

    printf("accuracy=%.5f\n", (double) correct / n);
    return 0;
}
