extends Node

class_name Utils

static func recursive_get_children(node: Node) -> Array:
	var all_children := []
	for child in node.get_children():
		all_children.append(child)
		all_children += recursive_get_children(child)
	return all_children

func _ready():
	pass
