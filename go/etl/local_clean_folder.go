package main

import (
	"log"
	"os"
	"path/filepath"
)

func main() {
	targetPath := "/path/to/target/directory"

	err := filepath.Walk(targetPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			log.Println(err)
			return err
		}
		if !info.IsDir() {
			err = os.Remove(path)
			if err != nil {
				log.Println(err)
				return err
			}
		} else {
			err = os.RemoveAll(path)
			if err != nil {
				log.Println(err)
				return err
			}
		}
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}
}
