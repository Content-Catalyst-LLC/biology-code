package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"path/filepath"
)

// Portable construct metadata summary helper.
func main() {
	path := filepath.Join("data", "construct_parts.csv")

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
		fmt.Println("construct_parts=0")
		return
	}

	header := records[0]
	partTypeIndex := indexOf(header, "part_type")

	counts := map[string]int{}
	for _, record := range records[1:] {
		counts[record[partTypeIndex]]++
	}

	fmt.Printf("construct_parts=%d\n", len(records)-1)
	for partType, count := range counts {
		fmt.Printf("%s,%d\n", partType, count)
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
