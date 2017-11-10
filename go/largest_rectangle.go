func largestRectangleArea(heights []int) int {
  if len(heights) == 0 {
    return 0
  }

  if len(heights) == 1 {
    return heights[0]
  }

  var rects []int

  iter := 0
  for iter < len(heights) {
    height := heights[iter]

    forward, backward := 0, 0
    for iter + forward < len(heights) {
      if heights[iter + forward] < height { break } 
      forward ++
    }

    for iter - backward >= 0 {
      if heights[iter - backward] < height { break }
      backward ++
    }
      
    iter ++

    value := height * (forward + backward - 1)
    rects = append(rects, value)
  }

  max := rects[0]
  for _ , value := range(rects) {
    if value > max {
      max = value
    }
  }

  return max
}