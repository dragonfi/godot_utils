extends "res://addons/gut/test.gd"

#func before_each(): pass
#func after_each(): pass
#func before_all(): pass
#func after_all(): pass

func test_recursive_get_children():
	var n1 = Node.new()
	var n11 = Node.new()
	var n111 = Node.new()
	var n12 = Node.new()
	var n2 = Node.new()
	n1.add_child(n11)
	n11.add_child(n111)
	n1.add_child(n12)

	assert_eq(Utils.recursive_get_children(n1), [n11, n111, n12])
