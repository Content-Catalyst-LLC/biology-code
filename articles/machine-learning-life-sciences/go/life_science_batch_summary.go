package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Portable batch summary helper for synthetic life-science ML metadata.
func main() {
	path := filepath.Join("data", "biological_samples.csv")

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

	batchCounts := map[string]int{}
	conditionCounts := map[string]int{}

	header := records[0]
	batchIndex := indexOf(header, "batch_id")
	conditionIndex := indexOf(header, "condition")

	for _, record := range records[1:] {
		batchCounts[record[batchIndex]]++
		conditionCounts[record[conditionIndex]]++
	}

	fmt.Println("Batch counts:")
	for batch, count := range batchCounts {
		fmt.Printf("%s,%d\n", batch, count)
	}

	fmt.Println("Condition counts:")
	for condition, count := range conditionCounts {
		fmt.Printf("%s,%d\n", condition, count)
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
