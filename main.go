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
	flag.Parse()

	yml.Configure("/", "name")
	buff, _ := ioutil.ReadAll(os.Stdin)
	path, err := yml.PathAtPoint(*line-1, *col, buff)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Println(path)
	os.Exit(0)
}
