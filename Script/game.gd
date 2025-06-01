extends Node

const x_max = 10

const max_length = 3

const max_level = 9

@onready var tilemap : TileMapLayer = $TileMapLayer
@onready var timer : Timer = $Timer

@export var cooldown_curve : Curve

var length := max_length

var x_head := 2

var y_head := max_level

var direction := true

var level := 0.0

func get_cooldown() -> float:
	return cooldown_curve.sample(level / max_level)

func _ready() -> void:
	timer.start(get_cooldown())

func _process(delta_: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if y_head < max_level:
			var index := 0
			
			for l in length:
				var lower_tile_atlas_coord = tilemap.get_cell_atlas_coords(Vector2i(x_head + index, y_head + 1))
			
				if lower_tile_atlas_coord == Vector2i(-1, -1):
					tilemap.erase_cell(Vector2i(x_head + index, y_head))
					
					length -= 1
					
					if length == 0:
						get_tree().quit()
						
				if direction:
					index -= 1
				else:
					index +=1
		
		x_head = 2
		
		direction = true
		
		y_head -= 1
		
		level += 1
		
		timer.start(get_cooldown())
		
		tilemap.set_cell(Vector2i(x_head, y_head), 0, Vector2i(2, 0))

func _on_timer_timeout() -> void:
	if direction:
		if x_head == x_max:
			direction = false
			
			x_head -= 2
	else:
		if x_head == 0:
			direction = true
			
			x_head += 2
			
	if direction:
		x_head += 1
			
		var idel := x_head - length
		if idel >= 0:
			tilemap.set_cell(Vector2i(idel, y_head), -1)
	else:
		x_head -= 1
		
		var idel := x_head + length
		if idel >= 0:
			tilemap.set_cell(Vector2i(idel, y_head), -1)
	
	tilemap.set_cell(Vector2i(x_head, y_head), 0, Vector2i(2, 0))
	
