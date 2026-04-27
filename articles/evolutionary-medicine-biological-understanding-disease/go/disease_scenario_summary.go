package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Portable disease-scenario metadata summary helper.
func main() {
	path := filepath.Join("data", "disease_scenarios.csv")

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
		fmt.Println("disease_scenarios=0")
		return
	}

	header := records[0]
	mechanismIndex := indexOf(header, "evolutionary_mechanism")

	counts := map[string]int{}
	for _, record := range records[1:] {
		counts[record[mechanismIndex]]++
	}

	fmt.Printf("disease_scenarios=%d\n", len(records)-1)
	for mechanism, count := range counts {
		fmt.Printf("%s,%d\n", mechanism, count)
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
