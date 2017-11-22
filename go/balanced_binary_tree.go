// https://leetcode.com/problems/balanced-binary-tree/description/

/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

import "math"

func isBalanced(root *TreeNode) bool {
  if (root == nil) { return true }
  if (math.Abs(height(root.Left) - height(root.Right)) > 1) { return false }

  return isBalanced(root.Left) && isBalanced(root.Right)
}

func height(node *TreeNode) float64 {
  if (node == nil) { return 0 }
  if (node.Left == nil && node.Right == nil) { return 1 }

  leftHeight := height(node.Left)
  rightHeight := height(node.Right)

  return (math.Max(leftHeight, rightHeight) + 1)
}