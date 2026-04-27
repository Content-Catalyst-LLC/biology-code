#include <iostream>
#include <string>
#include <vector>

// Notebook execution-status example for reproducible biological research.

struct NotebookRun {
    std::string notebook_name;
    bool clean_run;
    int failed_cells;
    int executed_cells;
};

int main() {
    std::vector<NotebookRun> runs = {
        {"computational_notebooks_biological_research_workflow.ipynb", true, 0, 4}
    };

    for (const auto& run : runs) {
        double failure_rate = static_cast<double>(run.failed_cells) / static_cast<double>(run.executed_cells);
        std::string status = (run.clean_run && run.failed_cells == 0) ? "pass" : "review";

        std::cout << "notebook=" << run.notebook_name << std::endl;
        std::cout << "clean_run=" << (run.clean_run ? "true" : "false") << std::endl;
        std::cout << "failed_cells=" << run.failed_cells << std::endl;
        std::cout << "executed_cells=" << run.executed_cells << std::endl;
        std::cout << "failure_rate=" << failure_rate << std::endl;
        std::cout << "status=" << status << std::endl;
    }

    return 0;
}
