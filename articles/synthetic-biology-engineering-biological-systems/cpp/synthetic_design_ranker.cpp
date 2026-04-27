#include <iostream>
#include <string>
#include <vector>

// Scenario ranking example for synthetic biology designs.

struct Design {
    std::string id;
    std::string construct_type;
    double output_signal;
    double host_burden;
    double genetic_stability;
    double measurement_uncertainty;
};

double engineering_score(const Design& item) {
    return item.output_signal * 0.40
        + item.genetic_stability * 0.30
        - item.host_burden * 0.20
        - item.measurement_uncertainty * 0.10;
}

int main() {
    std::vector<Design> designs = {
        {"D001", "biosensor", 0.82, 0.18, 0.72, 0.12},
        {"D002", "biosensor", 0.68, 0.10, 0.84, 0.10},
        {"D003", "metabolic_pathway", 0.74, 0.35, 0.55, 0.18}
    };

    for (const auto& item : designs) {
        std::cout << item.id
                  << " " << item.construct_type
                  << " engineering_score="
                  << engineering_score(item)
                  << std::endl;
    }

    return 0;
}
