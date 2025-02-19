extends CharacterBody2D

var bullet_speed = 10

var bullet_vector = Vector2()
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var bullets_gone_ref = null
var universe_ref = null

var laser_power = 50

func _physics_process(delta: float) -> void:
	
	velocity = bullet_vector * bullet_speed
	move_and_slide()

func disable_bullet():
	global_position = Vector2(-1000, 1000)
	bullet_vector = Vector2()
	laser_power = 0
	#gpu_particles_2d.emitting = false
	gpu_particles_2d.one_shot = true
	collision_shape_2d.disabled = true
	#sprite_2d.visible = false
	
	bullets_gone_ref.append(self)
	universe_ref.remove_child(self)
	

func set_bullet_vector(new_direction, bullets_gone, universe):
	bullet_vector = new_direction
	laser_power = 50
	if collision_shape_2d != null:
		collision_shape_2d.disabled = false
		sprite_2d.visible = true
		gpu_particles_2d.emitting = true
		gpu_particles_2d.one_shot = false
	bullets_gone_ref = bullets_gone
	universe_ref = universe

func _on_timer_timeout() -> void:
	disable_bullet()

func _on_gpu_particles_2d_finished() -> void:
	gpu_particles_2d.emitting = false
