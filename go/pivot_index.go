package main

import (
 "fmt"
)

func pivotIndex(nums []int) int {
  pivot := -1

  for i:= 0; i < len(nums); i++ {
    left, right := 0, 0

    for _, v := range nums[0:i] { left += v }
    for _, v := range nums[i+1:len(nums)] { right += v }

    if (left == right) { return i }
  }

  return pivot
}

func main() {
  nums := []int{-1,-1,-1,-1,-1,0}
  fmt.Println("Piviot index: ", pivotIndex(nums))
}