# @param {String} n
# @return {String}
# https://leetcode.com/problems/find-the-closest-palindrome/description/
def nearest_palindromic(n)
    nums = n.split("")

    if nums.size == 1
      return (n.to_i - 1).to_s
    end

    cand1 = palindrom_by_mirror(nums)
    cand2 = palindrom_by_increment(nums)
    cand3 = palindrom_by_decrement(nums)
    cand4 = palindrom_for_palindrom_decrement(nums)
    cand5 = palindrom_for_palindrom_increment(nums)

    puts "cands: #{[cand1, cand2, cand3, cand4, cand5]}, n: #{n}"

    cands = [cand1, cand2, cand3, cand4, cand5].compact.group_by{|c| (c.to_i - n.to_i).abs }.min.last
    cands.map(&:to_i).min.to_s
end

def palindrom_for_palindrom_decrement(nums)
  first_half, second_half = nums.each_slice((nums.size / 2.0).round).to_a
  first_half = (first_half.join("").to_i - 1).to_s.split("")
  second_half = first_half[0, second_half.size].reverse

  return (first_half + second_half).join("")
end

def palindrom_for_palindrom_increment(nums)
  first_half, second_half = nums.each_slice((nums.size / 2.0).round).to_a
  first_half = (first_half.join("").to_i + 1).to_s.split("")
  second_half = first_half[0, second_half.size].reverse

  return (first_half + second_half).join("")
end

def palindrom_by_mirror(nums)
  local_nums = nums.clone
  iter, mid = 0, local_nums.size / 2
  while(iter < mid)
    local_nums[local_nums.size - 1 - iter] = local_nums[iter]
    iter += 1
  end

  return nil if local_nums == nums

  return local_nums.join("")
end

def palindrom_by_increment(nums)
  local_nums = nums.clone
  mid = local_nums.size / 2
  if local_nums[mid].to_i == 9
    first_half, second_half = nums.each_slice((nums.size / 2.0).round).to_a
    first_half = (first_half.join("").to_i + 1).to_s.split("")
    second_half = first_half[0, second_half.size].reverse
    local_nums = first_half + second_half
    return  local_nums.join("")
  end

  return nil
end

def palindrom_by_decrement(nums)
  local_nums = nums.clone
  mid = local_nums.size / 2

  first_half, second_half = nums.each_slice((nums.size / 2.0).round).to_a
  return "9" if first_half == ["1"]

  if local_nums[mid].to_i == 0
    first_half = (first_half.join("").to_i - 1).to_s.split("")

    second_half = first_half[0, second_half.size].reverse
    if nums.size % 2 == 0
      local_nums = first_half + ["9"] + second_half
    else
      local_nums = first_half + second_half
    end

    return local_nums.join("")
  end

  return nil
end