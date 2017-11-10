# https://leetcode.com/problems/largest-rectangle-in-histogram/description/

# @param {Integer[]} heights
# @return {Integer}
def largest_rectangle_area(heights)
  return 0 if heights.size == 0
  rects = []
  heights.each_with_index do |height, index|
    forward, backward = 0, 0
    while(index + forward < heights.size)
      break if heights[index + forward] < height
      forward += 1
    end

    while(index - backward >= 0)
      break if heights[index - backward] < height
      backward += 1
    end
      
    rects << height * (forward + backward - 1)
  end

  rects.max
end

