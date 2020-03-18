tool
extends Node2D

# Load png images from a directory.

# Add this script to a scene root, fill in sprite_dir and cell_size,
# then use Scene/Convert to.../Tileset... as usual.
# Tile origin will be set to the bottom right corner.

# scene_grid is an optional setting that spaces grid elemens in the scene
# for easier viewing.

export(String, DIR) var sprite_dir setget __set_sprite_dir
export(Vector2) var scene_grid = Vector2(64, 64) setget __set_scene_grid
export(Vector2) var cell_size = Vector2(64, 64) setget __set_cell_size

func __set_scene_grid(value):
	scene_grid = value
	var offset = Vector2(0, 0)
	var window_size = get_viewport().size
	for node in get_children():
		if node is Sprite:
			node.position = offset
			offset.x += scene_grid.x
			if offset.x > window_size.x:
				offset.x = 0
				offset.y += scene_grid.y

			node.offset.y = -node.get_rect().size.y + 64
			node.offset.x = 0
			node.centered = false

func __set_cell_size(value):
	cell_size = value
	for node in get_children():
		if node is Sprite:
			node.offset.y = -node.get_rect().size.y + cell_size.y
			node.offset.x = 0
			node.centered = false

func __set_sprite_dir(value):
	sprite_dir = value
	__createSprites(sprite_dir)

func __createSprites(sprite_dir):
	for node in get_children():
		node.free()

	for file in list_dir(sprite_dir):
		var parts = file.rsplit(".", true, 1)
		if parts.size() < 2:
			continue
		var ext = parts[1]
		var base = parts[0]
		if ext != "png":
			continue
		var sprite = Sprite.new()
		sprite.name = base
		sprite.texture = load(sprite_dir + "/" + file)
		add_child(sprite)
		sprite.set_owner(self)
	
	__set_scene_grid(scene_grid)
	__set_cell_size(cell_size)

func list_dir(path):
	var files = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			files.append(file_name)
			file_name = dir.get_next()
		files.sort()
		return files
	else:
		print("An error occurred when trying to access the path.")
		return null

func _ready():
	pass

#func _process(delta):
#	pass
