#https://leetcode.com/problems/scramble-string/description/

#is_scramble("great", "rgeat")
#is_scramble("great","eatgr")
#is_scramble("abc", "bca")
def is_scramble(s1, s2) 
  return false unless s1.size == s2.size
  return true if s1 == s2

  s1_chars, s2_chars = s1.split(""), s2.split("")
  iter = 0
  while(iter < s1_chars.size)
    s1_sub_1, s1_sub_2 = s1_chars[0..iter], s1_chars[iter+1..-1]
    s2_sub_1, s2_sub_2 = s2_chars[0..iter], s2_chars[iter+1..-1]

    p "s1_1: #{s1_sub_1}"
    p "s1_2: #{s1_sub_2}"
    p "s2_1: #{s2_sub_1}"
    p "s2_2: #{s2_sub_2}"

    return true if match(s1_sub_1, s2_sub_1) && match(s1_sub_2, s2_sub_2)
    iter += 1
  end

  return false
end

def match(arr1, arr2)
  arr1.join("") == arr2.join("") ||
  arr1.join("").reverse == arr2.join("")
end


