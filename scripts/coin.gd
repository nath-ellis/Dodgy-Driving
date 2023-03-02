extends KinematicBody2D


var rand = RandomNumberGenerator.new()
var vel = Vector2()


func _ready() -> void:
	rand.randomize()
	
	set_meta("border", false)
	set_meta("is_coin", true)
	
	randomize_coin()


func randomize_coin() -> void:
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


func _physics_process(_delta) -> void:
	# Coin goes off the bottom
	if position.y >= get_viewport_rect().size.y + 60: 
		randomize_coin()
	
	var col = move_and_collide(vel)
	
	if col != null:
		var collider = col.collider
		
		if collider.has_meta("lives"):
			Manager.add_coin()
			randomize_coin()
		else:
			randomize_coin()
