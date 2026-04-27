#include <iostream>
#include <string>
#include <vector>

// Biological ethics scenario ranking example.

struct Project {
    std::string name;
    double benefit;
    double harm;
    double uncertainty;
    double consent;
    double justice;
    double reversibility;
};

double ethical_review_score(const Project& project) {
    return project.benefit * 0.25
        - project.harm * 0.20
        - project.uncertainty * 0.15
        + project.consent * 0.15
        + project.justice * 0.15
        + project.reversibility * 0.10;
}

int main() {
    std::vector<Project> projects = {
        {"clinical_genomics_study", 0.80, 0.25, 0.30, 0.75, 0.60, 0.70},
        {"animal_model_experiment", 0.60, 0.45, 0.35, 0.00, 0.45, 0.30},
        {"environmental_biosensor_release", 0.70, 0.40, 0.55, 0.40, 0.50, 0.35}
    };

    for (const auto& project : projects) {
        std::cout << project.name
                  << " ethical_review_score="
                  << ethical_review_score(project)
                  << std::endl;
    }

    return 0;
}
