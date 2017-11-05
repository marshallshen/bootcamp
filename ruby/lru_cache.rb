# https://leetcode.com/problems/lru-cache/description/
class LRUCache

=begin
    :type capacity: Integer
=end
    attr_accessor :keys, :store, :size
    def initialize(capacity)
        raise "invalid size of cache: #{capacity}" if capacity < 1
        @keys = []
        @store = {}
        @size = capacity
    end


=begin
    :type key: Integer
    :rtype: Integer
=end
    def get(key)
        if @keys.include?(key)
            @keys.delete_if{|k| k == key}
            @keys.push(key)
        end
        @store[key] || -1
    end


=begin
    :type key: Integer
    :type value: Integer
    :rtype: Void
=end
    def put(key, value)
        if @keys.include?(key)
            @store[key] = value
            @keys.delete_if{|k| k == key}
            @keys.push(key)
        else
            if @keys.size == @size
                key_to_delete = @keys.shift
                @store.delete(key_to_delete)
            end
            
            @store[key] = value
            @keys.push(key)
        end

    end


end