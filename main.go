package main

import (
	"fmt"
	"github.com/prometheus/common/version"
	"gopkg.in/alecthomas/kingpin.v2"
	yml "gopkg.in/yaml.v2"
	"io/ioutil"
	"os"
)

var (
	line     = kingpin.Flag("line", "Cursor line").Default("0").Int()
	col      = kingpin.Flag("col", "Cursor column").Default("0").Int()
	sep      = kingpin.Flag("sep", "Set path separator").Default("0").String()
	attr     = kingpin.Flag("name", "Set attribut name, empty to disable").Default("name").String()
	filePath = kingpin.Flag("path", "Set filepath, empty means stdin").Default("").String()
)

func main() {
	kingpin.Version(version.Print("yaml-path"))
	kingpin.HelpFlag.Short('h')
	kingpin.Parse()

	// line := flag.Int("line", 0, "cursor line")
	// col  := flag.Int("col", 0, "cursor column")
	// sep  := flag.String("sep", "/", "set path separator")
	// attr := flag.String("name", "name", "set attribut name, empty to disable")
	// filePath := flag.String("path", "", "set filepath")
	// flag.Parse()

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
