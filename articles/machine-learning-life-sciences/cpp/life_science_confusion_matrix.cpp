#include <iostream>
#include <string>
#include <vector>

// Performance-oriented confusion-matrix example for synthetic life-science ML.

struct Prediction {
    std::string sample_id;
    int observed;
    double probability;
};

int main() {
    std::vector<Prediction> predictions = {
        {"EXT001", 1, 0.91},
        {"EXT002", 1, 0.74},
        {"EXT003", 0, 0.33},
        {"EXT004", 0, 0.22},
        {"EXT005", 1, 0.68},
        {"EXT006", 0, 0.41}
    };

    int tp = 0;
    int tn = 0;
    int fp = 0;
    int fn = 0;

    for (const auto& row : predictions) {
        int predicted = row.probability >= 0.5 ? 1 : 0;

        if (row.observed == 1 && predicted == 1) tp++;
        if (row.observed == 0 && predicted == 0) tn++;
        if (row.observed == 0 && predicted == 1) fp++;
        if (row.observed == 1 && predicted == 0) fn++;

        std::cout << row.sample_id
                  << " observed=" << row.observed
                  << " probability=" << row.probability
                  << " predicted=" << predicted
                  << std::endl;
    }

    double accuracy = static_cast<double>(tp + tn) / static_cast<double>(predictions.size());

    std::cout << "tp=" << tp << std::endl;
    std::cout << "tn=" << tn << std::endl;
    std::cout << "fp=" << fp << std::endl;
    std::cout << "fn=" << fn << std::endl;
    std::cout << "accuracy=" << accuracy << std::endl;

    return 0;
}
