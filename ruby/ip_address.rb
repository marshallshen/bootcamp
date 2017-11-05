# https://leetcode.com/problems/restore-ip-addresses/description/
# @param {String} s
# @return {String[]}
def restore_ip_addresses(s)
  size = s.size
  return [] if size < 4 || size > 12
  raw_orders = parse(orders(size, 4, []))

  all_ips = raw_orders.map do |raw_order|
    fetch(raw_order, s)
  end.flatten

  all_ips.select{|ip| valid_ip?(ip)}
end

def fetch(raw_order, s)
  res = []
  arr = s.split("")
  while(raw_order != [])
    res << arr.shift(raw_order.shift)
    res << "."
  end
    res.pop # drop the last dot
    res.join("")
  end

  def parse(raw_orders)
    raw_orders.flatten!.compact!.each_slice(4).to_a
  end

  def orders(val, opt, temp)
    return temp if opt == 0 && val == 0
    return if val < opt || (opt == 0 && val != 0)
    
    return [
      orders(val -1, opt -1, temp+[1]),
      orders(val -2, opt -1, temp+[2]),
      orders(val -3, opt -1, temp+[3]),     
    ]
  end

  def valid_ip?(ip)
   begin
     sections = ip.split(".")
     return false unless sections.size == 4
     return false unless sections.all? do |s| 
      s.to_i >= 0 && s.to_i <= 255 && s.to_i.to_s.size == s.size
    end

    return true
  rescue
   return false
 end
end