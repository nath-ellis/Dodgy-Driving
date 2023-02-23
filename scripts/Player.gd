extends KinematicBody2D


export var speed = 15
var vel = Vector2()

onready var explosion = $Explosion
onready var hitbox = $CollisionShape2D
onready var timer = $Timer


func _ready() -> void:
	set_meta("lives", 3)
	set_meta("is_coin", false)


func _input(event) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var range_x = event.position.x - global_position.x
		var range_y = event.position.y - global_position.y
		
		# If negative
		if range_x < 0: range_x *= -1
		if range_y < 0: range_y *= -1
		
		# So that the player cannot teleport across the screen
		if range_x < 300 and range_y < 300:
			vel.x = event.position.x - global_position.x
			vel.y = event.position.y - global_position.y
			
			var col = move_and_collide(vel)
			
			if col != null:
				var collider = col.collider
				
				if collider.has_method("collision") and !collider.get_meta("is_coin"):
					collider.call("collision")
				
				# Prevents collision with borders counting
				if !collider.get_meta("border") and !collider.get_meta("is_coin"):
					enemy_collision()


func enemy_collision() -> void:
	if timer.is_stopped():
		vel.x = 0
		vel.y = 0
		
		explosion.show()
		explosion.play()
		
		timer.start()


func _on_Explosion_animation_finished() -> void:
	explosion.hide()
	explosion.stop()
	
	set_meta("lives", get_meta("lives") - 1)  # Decrease lives
	
	get_parent().call("restart")
