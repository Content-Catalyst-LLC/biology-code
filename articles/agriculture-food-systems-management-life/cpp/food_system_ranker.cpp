#include <iostream>
#include <string>
#include <vector>

// Food-system indicator ranking example.

struct FoodSystem {
    std::string name;
    double production_tonnes;
    double area_hectares;
    double water_used_m3;
    double nutrient_input_kg;
    double nutrient_harvested_kg;
};

double yield_t_ha(const FoodSystem& item) {
    return item.production_tonnes / item.area_hectares;
}

double water_productivity(const FoodSystem& item) {
    return item.production_tonnes / item.water_used_m3;
}

double nutrient_use_efficiency(const FoodSystem& item) {
    return item.nutrient_harvested_kg / item.nutrient_input_kg;
}

int main() {
    std::vector<FoodSystem> systems = {
        {"monocrop_grain", 850.0, 100.0, 420000.0, 12000.0, 4800.0},
        {"diversified_crop", 620.0, 80.0, 260000.0, 7600.0, 4100.0},
        {"agroforestry", 480.0, 75.0, 210000.0, 5200.0, 3600.0}
    };

    for (const auto& item : systems) {
        std::cout << item.name
                  << " yield_t_ha=" << yield_t_ha(item)
                  << " water_productivity=" << water_productivity(item)
                  << " nutrient_use_efficiency=" << nutrient_use_efficiency(item)
                  << std::endl;
    }

    return 0;
}
