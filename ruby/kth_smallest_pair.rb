# https://leetcode.com/problems/find-k-th-smallest-pair-distance/description/

def smallest_distance_pair(nums, k)
  n = nums.sort!.size
  (0..nums[-1]-nums[0]).bsearch { |x|
    nums.map { |y|
      (0...n).bsearch { |j| y - nums[~j] > x } || n
    }.sum >= k + n*(n+1)/2
  }
end
