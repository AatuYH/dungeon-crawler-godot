extends "res://Objects/PotionTemplate.gd"

var can_be_picked_up = true

func _on_Area2D_body_entered(body):
	if can_be_picked_up:
		body.update_stats("health")
		$AnimationPlayer.play("Disappear")
		$AudioStreamPlayer2D.play()
		can_be_picked_up = false
