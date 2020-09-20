extends WAT.Test

func title():
	return "TerrainController"

func test_get_map_position_from_coordinates():
	var terrain = TerrainController.new()
	var tiles = TileMap.new()
	tiles.cell_size = Vector2(70,70)
	terrain.tiles = tiles
	
	describe("Get position")
	asserts.is_equal(terrain.get_map_position_from_coordinates(0, 0), Vector2(0,0), "Zero")
	asserts.is_equal(terrain.get_map_position_from_coordinates(71, 71), Vector2(1,1), "One")
	asserts.is_equal(terrain.get_map_position_from_coordinates(-35, -35), Vector2(-1,-1), "Negative one")
	asserts.is_equal(terrain.get_map_position_from_coordinates(250, 520), Vector2(3,7), "Far positive")

func test_get_coordinates_from_map_position():
	var terrain = TerrainController.new()
	var tiles = TileMap.new()
	tiles.cell_size = Vector2(70,70)
	terrain.tiles = tiles
	
	describe("Get coordinates")
	asserts.is_equal(terrain.get_coordinates_from_map_position(0,0), Vector2(35,35), "Zero")
	asserts.is_equal(terrain.get_coordinates_from_map_position(1,1), Vector2(105,105), "One")
	asserts.is_equal(terrain.get_coordinates_from_map_position(-1,-1), Vector2(-35,-35), "Negative one")
	asserts.is_equal(terrain.get_coordinates_from_map_position(3,7), Vector2(245,525), "Far positive")