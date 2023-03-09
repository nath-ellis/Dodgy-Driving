extends CharacterBody2D


var rand = RandomNumberGenerator.new()
var vel = Vector2()
var time = Time.get_unix_time_from_system()


func _ready() -> void:
	rand.randomize()
	randomize_coin(false)


func randomize_coin(collected) -> void:
	vel.y = rand.randi_range(Manager.speed+2, Manager.enemy_speed)
	
	match rand.randi_range(1, 4):
		1:
			position = Vector2(
				120, 
				-rand.randi_range(72, 300)
			)  # First lane
		2:
			position = Vector2(
				239, 
				-rand.randi_range(72, 300)
			)  # Second lane
		3:
			position = Vector2(
				361, 
				-rand.randi_range(72, 300)
			)  # Third lane
		4:
			position = Vector2(
				480, 
				-rand.randi_range(72, 300)
			)  # Fourth lane
	
	# So that two coins are not added if the collision is detected by both the coin and the player
	if collected and Time.get_unix_time_from_system() - time >= 1:
		Manager.add_coin()
		time = Time.get_unix_time_from_system()


func _physics_process(_delta) -> void:
	# Coin goes off the bottom
	if position.y >= get_viewport_rect().size.y + 60: 
		randomize_coin(false)
	
	var col = move_and_collide(vel)
	
	if col != null:
		var collider = col.get_collider()
		
		if collider.has_meta("lives"):
			randomize_coin(true)
		else:
			randomize_coin(false)
