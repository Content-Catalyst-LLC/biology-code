/*
 * Compact biological network numerical kernel in C.
 */

#include <math.h>
#include <stdio.h>

#define N 6

void degree(double adjacency[N][N], int degrees[N]) {
    for (int i = 0; i < N; i++) {
        degrees[i] = 0;

        for (int j = 0; j < N; j++) {
            if (adjacency[i][j] > 0.0) {
                degrees[i]++;
            }
        }
    }
}

double density(double adjacency[N][N]) {
    int edges = 0;

    for (int i = 0; i < N; i++) {
        for (int j = i + 1; j < N; j++) {
            if (adjacency[i][j] > 0.0) {
                edges++;
            }
        }
    }

    return (double)edges / ((double)N * (double)(N - 1) / 2.0);
}

void diffuse(double adjacency[N][N], double state[N], double alpha, double decay, int steps) {
    double next[N];

    for (int step = 0; step < steps; step++) {
        for (int i = 0; i < N; i++) {
            next[i] = state[i] - decay * state[i];

            for (int j = 0; j < N; j++) {
                next[i] += alpha * adjacency[i][j] * state[j];
            }

            if (next[i] < 0.0) {
                next[i] = 0.0;
            }
        }

        for (int i = 0; i < N; i++) {
            state[i] = next[i];
        }
    }
}

int main(void) {
    double adjacency[N][N] = {
        {0.0, 1.0, 0.8, 0.0, 0.0, 0.0},
        {1.0, 0.0, 0.7, 1.2, 0.0, 0.0},
        {0.8, 0.7, 0.0, 0.0, 0.9, 0.0},
        {0.0, 1.2, 0.0, 0.0, 1.1, 0.6},
        {0.0, 0.0, 0.9, 1.1, 0.0, 0.5},
        {0.0, 0.0, 0.0, 0.6, 0.5, 0.0}
    };

    int degrees[N];
    double state[N] = {1.0, 0.0, 0.0, 0.0, 0.0, 0.0};

    degree(adjacency, degrees);
    diffuse(adjacency, state, 0.08, 0.04, 20);

    int total_degree = 0;
    int max_degree = 0;

    for (int i = 0; i < N; i++) {
        total_degree += degrees[i];

        if (degrees[i] > max_degree) {
            max_degree = degrees[i];
        }
    }

    printf("density=%.6f\n", density(adjacency));
    printf("mean_degree=%.6f\n", (double)total_degree / N);
    printf("max_degree=%d\n", max_degree);

    printf("final_state=");
    for (int i = 0; i < N; i++) {
        printf("%.6f ", state[i]);
    }
    printf("\n");

    return 0;
}
