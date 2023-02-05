extends KinematicBody2D


var rand = RandomNumberGenerator.new()
var speed
var vel = Vector2()
var sprite


func _ready():
	rand.randomize()
	
	sprite = $Sprite
	
	randomize_enemy()


func _physics_process(delta):
	# Enemy drives off the bottom
	if position.y >= get_viewport_rect().size.y + 60 and vel.y > 0: randomize_enemy()
	# Enemy drives off the top
	if position.y <= -60 and vel.y < 0: randomize_enemy()
	
	var col = move_and_collide(vel)
	
	# If there is a collision
	if col != null:
		var collider = col.collider  # The kinematicbody2d that the enemy collides with
		# TODO: Add consquences for collision


func randomize_enemy():
	speed = rand.randi_range(15, 20)
	vel.x = 0
	vel.y = speed  # Fixed speed
	
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
