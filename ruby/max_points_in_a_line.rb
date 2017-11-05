# Definition for a point.
# class Point
#     attr_accessor :x, :y
#     def initialize(x=0, y=0)
#         @x = x
#         @y = y
#     end
# end

# @param {Point[]} points
# @return {Integer}
def max_points(points)
  return 0 if points == []
  return points.size if points.size <= 2

  dist_map = {}
  points.each_with_index do |p1, i|
    dist_map[i] ||= {}
    if i < points.size - 1
      points[i+1..-1].each_with_index do |p2, j|
        k = relation(p1, p2) 
        dist_map[i][j+i+1] ||= k
        dist_map[j+i+1] ||= {}
        dist_map[j+i+1][i] ||= k
      end
    else
      (0..i-1).each {|j| dist_map[i][j] ||= dist_map[j][i]}
    end
  end

  dist_map.map do |key, counts|
    overlap = counts.count{|k, v| v == :overlap}
    counts.delete_if{|k, v| v == :overlap}
    max = counts == {} ? 0: counts.group_by{|k, v| v.to_f}.max_by{|k,v| v.count}.last.count
    max + overlap + 1
  end.max
end

def relation(p1, p2)
  # adj param is introduced to set off the floating error
  # it is deficiency on the Float class
  adj = [p1.x, p1.y, p2.x, p2.y].max >= 1024 ? 10.0 : 1.0
  if p1.x == p2.x && p1.y == p2.y
    :overlap
  elsif p1.x == p2.x
    0.to_f
  else
    ((p1.y - p2.y.to_f) / adj) / ((p1.x - p2.x.to_f) / adj)
  end
end