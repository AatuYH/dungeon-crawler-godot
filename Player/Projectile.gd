extends RigidBody2D



func _on_Projectile_body_entered(body):
	if body.name == "Player":
		body.hitpoints -= 1
		get_tree().call_group("GUI", "update_GUI")
		queue_free()
	else:
		queue_free()
