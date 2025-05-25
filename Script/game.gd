extends Node

const x_max = 10

const length = 3

@onready var tilemap : TileMapLayer = $TileMapLayer

var x_head := 2

var y_head := 3

var direction := true

func _process(delta_: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		x_head = 2
		
		direction = true
		
		y_head -= 1

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
	
