https://leetcode.com/problems/two-sum/description/
import "fmt"

func twoSum(nums []int, target int) []int {
  for i:= 0; i < len(nums); i++ {
    for j:= i+1; j < len(nums); j++ {
      if nums[i] + nums[j] == target {
        return []int{i, j}
      }
    }
  }
  
  panic("no pair is found")
}