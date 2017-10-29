# https://leetcode.com/problems/serialize-and-deserialize-binary-tree/description/
# Definition for a binary tree node.
class TreeNode
  attr_accessor :val, :left, :right
  def initialize(val)
    @val = val
    @left, @right = nil, nil
  end
end

# @param {TreeNode} root
# @return {string}

require "json"

def serialize(root)
  return nil if root == nil
  # leaf node
  result = {}
  result[root.val] = { 
    left: serialize(root.left),
    right: serialize(root.right),
  }

  return result.to_json
end

# Decodes your encoded data to tree.
#
# @param {string} data
# @return {TreeNode}

def deserialize(data)
  return nil if data == nil

  parsed = JSON.parse(data)
  if parsed.is_a?(Hash)
    key = parsed.keys.first
    node = TreeNode.new(key.to_i)
    left_data = parsed[key]["left"]
    right_data = parsed[key]["right"]

    node.left = deserialize(left_data)
    node.right = deserialize(right_data)
  else
    node = TreeNode.new(parsed.to_i)
  end

  node
end


