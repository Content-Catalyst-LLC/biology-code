package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Portable metadata summary helper for synthetic food-system data.
func main() {
	path := filepath.Join("data", "production_systems.csv")

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
		fmt.Println("production_systems=0")
		return
	}

	header := records[0]
	systemTypeIndex := indexOf(header, "system_type")

	counts := map[string]int{}
	for _, record := range records[1:] {
		counts[record[systemTypeIndex]]++
	}

	fmt.Printf("production_systems=%d\n", len(records)-1)
	for systemType, count := range counts {
		fmt.Printf("%s,%d\n", systemType, count)
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
