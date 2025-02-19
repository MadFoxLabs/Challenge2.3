extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var angular_velocity = 0.0

var health = 30

func set_speed(speed_vector, speed, ang_velocity):
	angular_velocity = ang_velocity
	velocity = speed_vector * speed 

func _physics_process(delta: float) -> void:
	rotation += angular_velocity 
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Laser"):
		health -= body.laser_power
		body.disable_bullet()
		if health < 0:
			self.queue_free()
	elif body.is_in_group("AsteroidKiller"):
		self.queue_free()
