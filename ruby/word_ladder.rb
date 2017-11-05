# @param {String} begin_word
# @param {String} end_word
# @param {String[]} word_list
# @return {String[][]}

class Node
    attr_accessor :val, :parent, :children
    def initialize(val, parent=nil)
        @val = val
        @parent = parent
        @children = []
    end
end

def find_ladders(begin_word, end_word, word_list)
    node, nodes = Node.new(begin_word), []
    travel(node, end_word, word_list, nodes)
    parse(nodes, end_word)    
end

def parse(nodes, end_word)
    seqs = nodes.map do |n|
        seq = []
        while(n != nil)
            seq = [n.val] + seq
            n = n.parent
        end
        seq
    end
    
    return seqs if seqs == []
    seqs.group_by{|s| s.size}.min.last
end

def travel(node, end_word, word_list, nodes)
    return if word_list == []
    words = next_words(node.val, word_list) 
    words.each do |w| 
        child_node = Node.new(w, node)
        node.children << child_node
        if w == end_word
            nodes << child_node
            return
        end
        travel(child_node, end_word, word_list - [w], nodes)
    end 
end

def next_words(word, word_list)
    word_list.select do |w|
        diff, la, lb = 0, w.split(""), word.split("")
        la.each_with_index do |a, i|
            diff += 1 if la[i] != lb[i]
        end
        
        diff == 1
    end
end