extends StaticBody2D

var is_locked = true

func _on_KeyDetector_body_entered(body):
	if body.has_key and is_locked:
		collision_layer = 0
		collision_mask = 0
		$Sprite.texture = load("res://Assets/GFX/frames/doors_leaf_open.png")
		$AudioStreamPlayer2D.play()
		is_locked = false
