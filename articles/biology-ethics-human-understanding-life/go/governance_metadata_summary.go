package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Portable governance metadata summary helper.
func main() {
	path := filepath.Join("data", "governance_requirements.csv")

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
		fmt.Println("projects=0")
		return
	}

	header := records[0]
	requirementColumns := header[1:]

	fmt.Printf("projects=%d\n", len(records)-1)
	fmt.Printf("governance_requirement_types=%d\n", len(requirementColumns))

	for _, record := range records[1:] {
		project := record[0]
		count := 0
		for _, value := range record[1:] {
			if value == "true" {
				count++
			}
		}
		fmt.Printf("%s,%d\n", project, count)
	}
}
