class Trie

  attr_accessor :val, :children, :level, :list
  def initialize(val=nil)
    @val, @children, @list = val, [], Set.new
  end

  def insert(word)
    return if search(word)
    
    @list.add(word)
    iter, trie = 0, self
    while(iter < word.size)
      prefix = word[0..iter]

      child_trie = trie.children.find{|t| t.val == prefix}
      if child_trie == nil
        child_trie = Trie.new(prefix)
        trie.children << child_trie
      end
      trie = child_trie
      iter += 1
    end
  end  

  def search(word)
    @list.include?(word)
  end

  def starts_with(prefix)
    return true if search(prefix)

    iter, trie = 0, self
    while(iter < prefix.size)
      pre = prefix[0..iter]

      child_trie = trie.children.find{|t| t.val == pre }
      return false if child_trie == nil

      trie = child_trie
      iter += 1
    end

    return true
  end
end