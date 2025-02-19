extends Node2D

const ASTEROID = preload("res://scenes/asteroid.tscn")
@export var universe:Node2D = null
@onready var timer: Timer = $Timer


func _on_timer_timeout() -> void:
	if universe != null:
		var new_asteroid = ASTEROID.instantiate()
		
		var dice = randf_range(-0.3, 0.3)
		var speed_vector = Vector2(dice, 1)
		
		dice = randi_range(300, 500)
		new_asteroid.set_speed(speed_vector, dice, randf_range(-0.1, 0.1))
		new_asteroid.position = position
		new_asteroid.modulate = select_color()
		universe.get_node("Asteroids").add_child(new_asteroid)
		
		timer.wait_time = randf_range(1, 3)


func select_color():
	
	var dice = randf()
	if 0.98 < dice:
		return Color(randf_range(0.95, 1.0), randf_range(0.85, 1.0),randf_range(0.48, 0.58))
	elif 0.8 < dice and dice <= 0.98:
		return Color(randf_range(0.8, 1.0), randf_range(0.85, 1.0),randf_range(0.95, 1.0),randf_range(0.85, 1.0))
	else:
		return Color(randf_range(0.8, 1.0), randf_range(0.85, 1.0),randf_range(0.95, 1.0))
		
		
