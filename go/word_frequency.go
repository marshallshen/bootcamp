package main

import (
  "fmt"
  "strings"
  "sort"
)

func wordCount(s string) map[string]int {
  wordCount := make(map[string]int)
  fields := strings.Fields(s)
  for i := 0; i < len(fields); i++ {
    wordCount[fields[i]] += 1
  }

  return wordCount
}

func sortWordCount(freq map[string]int) PairList {
  pl := make(PairList, len(freq))
  i := 0
  for k, v := range(freq) {
    pl[i] = Pair{k, v}
    i ++
  }

  sort.Sort(sort.Reverse(pl))
  return pl
}

func (p PairList) Len() int { return len(p) }
func (p PairList) Less(i, j int) bool { return p[i].Value < p[j].Value }
func (p PairList) Swap(i, j int) { p[i], p[j] = p[j], p[i] }

type Pair struct {
  Key string
  Value int
}

type PairList []Pair

func main() {
  sentence := `
    Hello playground. My name is Marshall Shen,
    And I will nail this challenge, 
    Marshall is the real slim shady
  `

  counts := wordCount(sentence)
  pl := sortWordCount(counts)

  fmt.Println(pl)
}
