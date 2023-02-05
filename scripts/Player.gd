extends KinematicBody2D


export var speed = 15
var vel = Vector2()


func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var range_x = event.position.x - global_position.x
		var range_y = event.position.y - global_position.y
		
		# If negative
		if range_x < 0: range_x *= -1
		if range_y < 0: range_y *= -1
		
		# So that the player cannot teleport across the screen
		if range_x < 300 and range_y < 300:
			vel.x = (event.position.x - global_position.x) * speed
			vel.y = (event.position.y - global_position.y) * speed
			vel = move_and_slide(vel)
