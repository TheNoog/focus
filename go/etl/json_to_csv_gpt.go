package main

import (
	"encoding/csv"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"
)

func main() {
	// Open the input JSON file
	jsonFile, err := os.Open("data.json")
	if err != nil {
		log.Fatal(err)
	}
	defer jsonFile.Close()

	// Read the JSON file content into a byte slice
	jsonBytes, err := ioutil.ReadAll(jsonFile)
	if err != nil {
		log.Fatal(err)
	}

	// Unmarshal the JSON data into a map[string]interface{}
	var data map[string]interface{}
	err = json.Unmarshal(jsonBytes, &data)
	if err != nil {
		log.Fatal(err)
	}

	// Open the output CSV file
	csvFile, err := os.Create("output.csv")
	if err != nil {
		log.Fatal(err)
	}
	defer csvFile.Close()

	// Create a CSV writer
	csvWriter := csv.NewWriter(csvFile)

	// Write the header row
	header := make([]string, 0)
	flatten("", data, &header)
	err = csvWriter.Write(header)
	if err != nil {
		log.Fatal(err)
	}

	// Write the data rows
	for _, row := range flattenRows(data) {
		err = csvWriter.Write(row)
		if err != nil {
			log.Fatal(err)
		}
	}

	// Flush the CSV writer to write any buffered data
	csvWriter.Flush()

	if err = csvWriter.Error(); err != nil {
		log.Fatal(err)
	}
}

func flatten(prefix string, data interface{}, header *[]string) {
	switch value := data.(type) {
	case map[string]interface{}:
		for key, val := range value {
			newPrefix := fmt.Sprintf("%s%s.", prefix, key)
			flatten(newPrefix, val, header)
		}
	case []interface{}:
		for _, val := range value {
			flatten(prefix, val, header)
		}
	default:
		*header = append(*header, strings.TrimSuffix(prefix, "."))
	}
}

func flattenRows(data map[string]interface{}) [][]string {
	var rows [][]string
	for _, item := range data {
		row := make([]string, 0)
		flattenRow(item, &row)
		rows = append(rows, row)
	}
	return rows
}

func flattenRow(data interface{}, row *[]string) {
	switch value := data.(type) {
	case map[string]interface{}:
		for _, val := range value {
			flattenRow(val, row)
		}
	case []interface{}:
		for _, val := range value {
			flattenRow(val, row)
		}
	default:
		*row = append(*row, fmt.Sprintf("%v", value))
	}
}
