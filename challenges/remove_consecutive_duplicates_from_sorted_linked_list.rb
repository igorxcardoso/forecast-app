#  LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/remove-consecutive-duplicates-sorted-list/problem?isFullScreen=true

class ListNode
  attr_accessor :val, :next
  def initialize(val)
    @val = val
    @next = nil
  end
end

def deleteDuplicates(head)
  current = head
  while current && current.next
    if current.val == current.next.val
      # pula o nó duplicado
      current.next = current.next.next
    else
      # avança para o próximo nó
      current = current.next
    end
  end
  head
end


nodes = [1, 2, 2, 2, 3, 4, 4, 5].map { |v| ListNode.new(v) }
nodes.each_with_index { |node, i| node.next = nodes[i+1] if i+1 < nodes.length }
head = nodes[0]
new_head = deleteDuplicates(head)

puts new_head

current = new_head
while current
  print current.val
  print " -> " if current.next
  current = current.next
end