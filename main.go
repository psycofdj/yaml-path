package main

import (
	"flag"
	"fmt"
	yml "gopkg.in/yaml.v2"
	"io/ioutil"
	"os"
)

func main() {
	line := flag.Int("line", 0, "cursor line")
	col := flag.Int("col", 0, "cursor column")
	sep := flag.String("sep", "/", "set path separator")
	attr := flag.String("name", "name", "set attribut name, empty to disable")
	filePath := flag.String("path", "", "set filepath")
	flag.Parse()

	yml.Configure(*sep, *attr)
	var buff []byte
	var err error
	if *filePath != "" {
		buff, err = ioutil.ReadFile(*filePath)
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
	} else {
		buff, _ = ioutil.ReadAll(os.Stdin)
	}
	path, err := yml.PathAtPoint(*line-1, *col, buff)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Println(path)
	os.Exit(0)
}
