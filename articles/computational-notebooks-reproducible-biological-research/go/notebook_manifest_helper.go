package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Portable notebook-manifest helper for biological reproducibility scaffolds.
func main() {
	path := filepath.Join("data", "notebook_workflow_manifest.csv")

	file, err := os.Open(path)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	reader := csv.NewReader(file)
	records, err := reader.ReadAll()
	if err != nil {
		panic(err)
	}

	if len(records) <= 1 {
		fmt.Println("workflow_steps=0")
		return
	}

	fmt.Printf("workflow_steps=%d\n", len(records)-1)

	header := records[0]
	stepNameIndex := indexOf(header, "step_name")
	outputArtifactIndex := indexOf(header, "output_artifact")

	for _, record := range records[1:] {
		fmt.Printf("%s -> %s\n", record[stepNameIndex], record[outputArtifactIndex])
	}
}

func indexOf(values []string, target string) int {
	for index, value := range values {
		if value == target {
			return index
		}
	}
	panic("column not found: " + target)
}
