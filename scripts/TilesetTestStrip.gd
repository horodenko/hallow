## TilesetTestStrip.gd — paints a small dirt-path test strip through the
## terrain system so the atlas peering bits can be visually verified.
## One straight run, one corner, one T-junction, on a grass fill.
## Throwaway verification scene — not part of the game.
extends TileMapLayer

const TERRAIN_SET: int = 0
const TERRAIN_DIRT: int = 0
const TERRAIN_GRASS: int = 1

## Grass backdrop, in cell coordinates.
const GRASS_RECT: Rect2i = Rect2i(0, 0, 20, 12)

## Every tile in this atlas has all 8 peering bits set to a real terrain
## (dirt or grass — no "empty" bits). With ignore_empty_terrains=true
## (the default), Godot's solver leaves cells that border empty map
## unresolved; passing false makes it best-match against the map edge.
const IGNORE_EMPTY_TERRAINS: bool = false


func _ready() -> void:
	_paint_grass_fill()
	_paint_path_shapes()


func _paint_grass_fill() -> void:
	var cells: Array[Vector2i] = []
	for y: int in range(GRASS_RECT.position.y, GRASS_RECT.end.y):
		for x: int in range(GRASS_RECT.position.x, GRASS_RECT.end.x):
			cells.append(Vector2i(x, y))
	set_cells_terrain_connect(cells, TERRAIN_SET, TERRAIN_GRASS, IGNORE_EMPTY_TERRAINS)


func _paint_path_shapes() -> void:
	var cells: Array[Vector2i] = []
	# Straight east-west run.
	for x: int in range(2, 10):
		cells.append(Vector2i(x, 2))
	# L-corner: east run that bends south.
	for x: int in range(12, 18):
		cells.append(Vector2i(x, 2))
	for y: int in range(3, 7):
		cells.append(Vector2i(17, y))
	# T-junction: east-west run with a branch heading south.
	for x: int in range(2, 13):
		cells.append(Vector2i(x, 8))
	for y: int in range(9, 12):
		cells.append(Vector2i(7, y))
	set_cells_terrain_connect(cells, TERRAIN_SET, TERRAIN_DIRT, IGNORE_EMPTY_TERRAINS)
