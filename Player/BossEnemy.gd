extends KinematicBody2D

var hitpoints = 100

func check_health():
	$AudioStreamPlayer2D.play()
	if hitpoints <= 0:
		$AnimationPlayer.play("Death")


func die():
	queue_free()
	get_tree().change_scene("res://Interface/WinScreen.tscn")


func _on_BossWeapon_body_entered(body):
	if body.name == "Player":
		body.hitpoints -= 2
		body.check_health()

