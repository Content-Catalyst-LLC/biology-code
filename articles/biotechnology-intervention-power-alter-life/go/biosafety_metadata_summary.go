package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Portable biosafety metadata summary helper.
func main() {
	path := filepath.Join("data", "containment_layers.csv")

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
		fmt.Println("containment_layers=0")
		return
	}

	header := records[0]
	categoryIndex := indexOf(header, "category")

	counts := map[string]int{}
	for _, record := range records[1:] {
		counts[record[categoryIndex]]++
	}

	fmt.Printf("containment_layers=%d\n", len(records)-1)
	for category, count := range counts {
		fmt.Printf("%s,%d\n", category, count)
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
