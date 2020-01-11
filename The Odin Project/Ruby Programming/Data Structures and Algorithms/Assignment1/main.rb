require_relative 'tree.rb'

rand_arr = Array.new(15) { rand(1..100) }
bst = Tree.new(rand_arr)
p bst.balanced?

bst.level_order {|value| print "#{value} "}
puts ""
bst.preorder {|value| print "#{value} "}
puts ""
bst.postorder {|value| print "#{value} "}
puts ""
bst.inorder {|value| print "#{value} "}
puts ""

bst.insert(105)
bst.insert(120)
bst.insert(150)

p bst.balanced?
bst.rebalance!
p bst.balanced?

bst.level_order {|value| print "#{value} "}
puts ""
bst.preorder {|value| print "#{value} "}
puts ""
bst.postorder {|value| print "#{value} "}
puts ""
bst.inorder {|value| print "#{value} "}
puts ""