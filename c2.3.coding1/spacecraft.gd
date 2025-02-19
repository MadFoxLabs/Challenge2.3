extends CharacterBody2D

const SPEED_X = 300.0
const SPEED_Y = 600.0
@export var return_y_speed = 100.0

@onready var laser1 : Node2D = $Laser
@onready var health_bar: TextureProgressBar = $HealthBar

var health : float = 100
var max_health : float = 100

func _physics_process(delta):
	
	var my_movement = Vector2()
	if Input.is_action_pressed("ui_left"):
		my_movement.x = -1
	elif Input.is_action_pressed("ui_right"):
		my_movement.x = 1
	else:
		my_movement.x = 0
	
	if Input.is_action_pressed("ui_up"):
		my_movement.y = -SPEED_Y
		#$GPUParticles2D.emitting = true
	elif Input.is_action_pressed("ui_down"):
		pass
		#my_movement.y = 1
		#$GPUParticles2D.emitting = false
	else:
		if self.position.y < 520:
			my_movement.y = return_y_speed
		else:
			self.position.y = 520
			
	if Input.is_action_just_pressed("ui_accept"):
		laser1.fire_laser()
	
	handle_health()
	velocity.x = my_movement.x * SPEED_X
	velocity.y = my_movement.y
	
	move_and_slide()
func handle_health():
	if health < 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	handle_health_bar()
func handle_health_bar():
	health_bar.value = health

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Asteroid"):
		body.queue_free()
		health -= 30
