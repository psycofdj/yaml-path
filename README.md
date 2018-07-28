## What

`yaml-path` reads given yaml on stdin and output a sort of 'path' corresponding to given `line` and
`column` in the file.

Generated path is compilant with [BOSH](https://bosh.io/docs/cli-v2/) `ops-file` syntax.

## Usage

```
Usage of ./yaml-path:
  -col int
        cursor column
  -line int
        cursor line
  -name string
        set attribut name, empty to disable (default "name")
  -sep string
        set path separator (default "/")
```

## Example

Given the following yaml file:
```
top:
  first:
    - name: myname
      attr1: val1
      attr2: val2
      #       ^
    - value2
    - value3
  second:
    child1: value1
    child1: value2
    child3: value3
```


```cat test.yaml | ./yaml-path -line 5 -col 14```

Outputs:
```
/top/first/name=myname/attr2
```

## Why ?

Working with [BOSH](https://bosh.io/docs/cli-v2/) often require to writes so-called `ops-file` which
are kind of patches for yaml files. Writing the path of the object to modify is a real burden in large
yaml files.

This tool is meant to be easily integrated in editor such as emacs.

<!-- Local Variables: -->
<!-- End: -->
