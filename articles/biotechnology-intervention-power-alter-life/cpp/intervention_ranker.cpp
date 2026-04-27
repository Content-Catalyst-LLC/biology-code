#include <iostream>
#include <string>
#include <vector>

// Scenario ranking example for synthetic biotechnology interventions.

struct Intervention {
    std::string name;
    double benefit;
    double harm;
    double uncertainty;
    double reversibility;
    double access_equity;
    double governance;
};

double responsibility_score(const Intervention& item) {
    return item.benefit * 0.30
        + item.access_equity * 0.20
        + item.reversibility * 0.20
        + item.governance * 0.15
        - item.harm * 0.10
        - item.uncertainty * 0.05;
}

int main() {
    std::vector<Intervention> interventions = {
        {"somatic_gene_therapy", 0.85, 0.20, 0.30, 0.60, 0.35, 0.70},
        {"gene_drive_vector_control", 0.80, 0.55, 0.70, 0.15, 0.50, 0.35},
        {"drought_tolerant_crop", 0.65, 0.25, 0.35, 0.55, 0.45, 0.65}
    };

    for (const auto& item : interventions) {
        std::cout << item.name
                  << " responsibility_score="
                  << responsibility_score(item)
                  << std::endl;
    }

    return 0;
}
