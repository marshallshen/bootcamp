// https://leetcode.com/problems/decode-ways/description/
package main

import (
  "strconv"
  "fmt"
)

func main() {
  s := "1787897759966261825913315262377298132516969578441236833255596967132573482281598412163216914566534565"
  c := numDecodings(s)
  fmt.Printf("%s has numDecodings %v.", s, c)
}

func numDecodings(s string) int {
  if len(s) == 0 { return 0 }

  if string(s[0]) == "0" { return 0 }
  if len(s) == 1 { return 1 }
  if len(s) == 2 {
    num, _ := strconv.Atoi(s)
    if num > 26 { 
      if string(s[1]) == "0" { return 0 }
      return 1
    } else { 
      if string(s[1]) == "0" { return 1 }
      return 2
    }
  }

  subOne:= s[1:len(s)]

  numTwo, _:= strconv.Atoi(s[0:2])
  subTwo:= s[2:len(s)]

  if numTwo <= 26 {
    return (numDecodings(subTwo) + numDecodings(subOne))
  } else {
    return numDecodings(subOne)
  }
}