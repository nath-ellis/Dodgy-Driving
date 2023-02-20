extends KinematicBody2D


var rand = RandomNumberGenerator.new()
var vel = Vector2()

onready var sprite = $Sprite
onready var explosion = $Explosion
onready var hitbox = $CollisionShape2D


func _ready() -> void:
	rand.randomize()
	
	set_meta("border", false)
	
	randomize_enemy()


func _physics_process(_delta) -> void:
	# Enemy drives off the bottom
	if position.y >= get_viewport_rect().size.y + 60 and vel.y > 0: randomize_enemy()
	# Enemy drives off the top
	if position.y <= -60 and vel.y < 0: randomize_enemy()
	
	var col = move_and_collide(vel)
	
	# If there is a collision
	if col != null:
		var collider = col.collider  # The kinematicbody2d that the enemy collides with
		
		# Player collision
		if collider.has_method("enemy_collision"):
			collider.call("enemy_collision")
			
		# Other enemy collision
		if collider.has_method("collision"):
			collider.call("collision")
			
		if collider.name != "LeftBorder" or collider.name != "RightBorder":
			collision()


func change_type() -> void:
	# Randomize the enemies sprite
	match rand.randi_range(1, 8):
		1:
			match rand.randi_range(1, 9):
				1: sprite.set_texture(load("res://assets/cars/estate/black.png"))
				2: sprite.set_texture(load("res://assets/cars/estate/blue.png"))
				3: sprite.set_texture(load("res://assets/cars/estate/green.png"))
				4: sprite.set_texture(load("res://assets/cars/estate/pink.png"))
				5: sprite.set_texture(load("res://assets/cars/estate/purple.png"))
				6: sprite.set_texture(load("res://assets/cars/estate/red.png"))
				7: sprite.set_texture(load("res://assets/cars/estate/white.png"))
				8: sprite.set_texture(load("res://assets/cars/estate/yellow.png"))
		2:
			match rand.randi_range(1, 9):
				1: sprite.set_texture(load("res://assets/cars/jeep/black.png"))
				2: sprite.set_texture(load("res://assets/cars/jeep/blue.png"))
				3: sprite.set_texture(load("res://assets/cars/jeep/green.png"))
				4: sprite.set_texture(load("res://assets/cars/jeep/pink.png"))
				5: sprite.set_texture(load("res://assets/cars/jeep/purple.png"))
				6: sprite.set_texture(load("res://assets/cars/jeep/red.png"))
				7: sprite.set_texture(load("res://assets/cars/jeep/white.png"))
				8: sprite.set_texture(load("res://assets/cars/jeep/yellow.png"))
		3:
			match rand.randi_range(1, 9):
				1: sprite.set_texture(load("res://assets/cars/racing/black.png"))
				2: sprite.set_texture(load("res://assets/cars/racing/blue.png"))
				3: sprite.set_texture(load("res://assets/cars/racing/green.png"))
				4: sprite.set_texture(load("res://assets/cars/racing/pink.png"))
				5: sprite.set_texture(load("res://assets/cars/racing/purple.png"))
				6: sprite.set_texture(load("res://assets/cars/racing/red.png"))
				7: sprite.set_texture(load("res://assets/cars/racing/white.png"))
				8: sprite.set_texture(load("res://assets/cars/racing/yellow.png"))
		4:
			match rand.randi_range(1, 9):
				1: sprite.set_texture(load("res://assets/cars/retro/black.png"))
				2: sprite.set_texture(load("res://assets/cars/retro/blue.png"))
				3: sprite.set_texture(load("res://assets/cars/retro/green.png"))
				4: sprite.set_texture(load("res://assets/cars/retro/pink.png"))
				5: sprite.set_texture(load("res://assets/cars/retro/purple.png"))
				6: sprite.set_texture(load("res://assets/cars/retro/red.png"))
				7: sprite.set_texture(load("res://assets/cars/retro/white.png"))
				8: sprite.set_texture(load("res://assets/cars/retro/yellow.png"))
		5:
			match rand.randi_range(1, 9):
				1: sprite.set_texture(load("res://assets/cars/sport/black.png"))
				2: sprite.set_texture(load("res://assets/cars/sport/blue.png"))
				3: sprite.set_texture(load("res://assets/cars/sport/green.png"))
				4: sprite.set_texture(load("res://assets/cars/sport/pink.png"))
				5: sprite.set_texture(load("res://assets/cars/sport/purple.png"))
				6: sprite.set_texture(load("res://assets/cars/sport/red.png"))
				7: sprite.set_texture(load("res://assets/cars/sport/white.png"))
				8: sprite.set_texture(load("res://assets/cars/sport/yellow.png"))
		6:
			match rand.randi_range(1, 9):
				1: sprite.set_texture(load("res://assets/cars/vintage/black.png"))
				2: sprite.set_texture(load("res://assets/cars/vintage/blue.png"))
				3: sprite.set_texture(load("res://assets/cars/vintage/green.png"))
				4: sprite.set_texture(load("res://assets/cars/vintage/pink.png"))
				5: sprite.set_texture(load("res://assets/cars/vintage/purple.png"))
				6: sprite.set_texture(load("res://assets/cars/vintage/red.png"))
				7: sprite.set_texture(load("res://assets/cars/vintage/white.png"))
				8: sprite.set_texture(load("res://assets/cars/vintage/yellow.png"))
		7: sprite.set_texture(load("res://assets/cars/police.png"))


func randomize_enemy() -> void:
	vel.x = 0
	vel.y = rand.randi_range(15, 20) # Fixed speed
	
	change_type()
	
	var choice = rand.randi_range(1, 2)
	
	match choice:
		1:
			choice = rand.randi_range(1, 2)
			
			match choice:
				1:
					position = Vector2(
						361, 
						-rand.randi_range(72, 300)
					)  # Third lane
				2:
					position = Vector2(
						480, 
						-rand.randi_range(72, 300)
					)  # Fourth lane
			
			sprite.rotation_degrees = 180  # Flip sprite upside down
			
			if vel.y < 0:  # If it is moving in the wrong direction
				vel.y *= -1
			# TODO: Add a random chance that an enemy will be travelling the wrong way
		2:
			choice = rand.randi_range(1, 2)
			
			match choice:
				1:
					position = Vector2(
						120, 
						rand.randi_range(get_viewport_rect().size.y, get_viewport_rect().size.y + 300)
					)  # First lane
				2:
					position = Vector2(
						239, 
						rand.randi_range(get_viewport_rect().size.y, get_viewport_rect().size.y + 300)
					)  # Second lane
					
			sprite.rotation_degrees = 0
			
			if vel.y > 0:  # If it is moving in the wrong direction
				vel.y *= -1


func collision() -> void:
	vel.y = 0
	
	hitbox.disabled = true
	
	explosion.show()
	explosion.play()
	
	sprite.hide()


func _on_Explosion_animation_finished() -> void:
	randomize_enemy()
	
	sprite.show()
	
	explosion.hide()
	explosion.stop()
	
	hitbox.disabled = false
