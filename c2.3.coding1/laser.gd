extends Node2D

var temperature : float  = 0
@onready var turret: Sprite2D = $Main/Turret

var temp_decrease_coef = 10
const LASER_BULLET = preload("res://scenes/laser_bullet.tscn")
@export var universe:Node2D = null 

var bullets_gone = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(bullets_gone.size())
	pass

func fire_laser():
	if temperature > 500:
		return
	temperature += 10
	if universe != null:
		var new_bullet = bullets_gone.pop_back()
		if new_bullet == null:
			new_bullet = LASER_BULLET.instantiate()
		new_bullet.position = self.global_position
		new_bullet.set_bullet_vector(Vector2(0, -1), bullets_gone, universe)
		universe.add_child(new_bullet)
		

func _physics_process(delta: float) -> void:
	if temperature > 0:
		temperature -= delta * temp_decrease_coef
	set_turret_temperature()
	
	
func set_turret_temperature():
	if temperature < 20:
		return
	var r = temperature / 510
	var g = 0
	var b = temperature * 0.1/ 510
	var a = temperature / 510
	turret.modulate = Color(r, g, b, a)
