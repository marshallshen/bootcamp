// https://leetcode.com/contest/weekly-contest-58/problems/split-linked-list-in-parts/
package main

import (
 "fmt"
)

/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */

func splitListToParts(root *ListNode, k int) []*ListNode {
  length := 0
  for n := root; n != nil; n = n.Next {
    length += 1
  }

  counts:= make([k]int, 0)
  for j:= 0; j <= length; j++ {
    for i:= 0; i 
    counts[i] += 1
  }
}

func main() {

}