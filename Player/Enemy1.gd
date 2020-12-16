extends KinematicBody2D


const SPEED = 30

var hitpoints = 10

var direction = Vector2(0, 0)


func _process(delta):
	move()
	animate()


func check_health():
	$AudioStreamPlayer2D.play()
	if hitpoints <= 0:
		$AnimationPlayer.play("Death")


func die():
	queue_free()


func random():
	randomize()
	return randi() % 21 - 10


func move():
	move_and_slide(direction)


func animate():
	if direction.x == 0 and direction.y == 0:
		$AnimatedSprite.play("idle")
	elif (direction.x != 0 or direction.y != 0) and direction.x < 0:
		$EnemyWeapon.rotation_degrees = -90
		$EnemyWeapon.position = Vector2(-9, 0)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif (direction.x != 0 or direction.y != 0) and direction.x > 0:
		$EnemyWeapon.rotation_degrees = 90
		$EnemyWeapon.position = Vector2(9, 0)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")


func _on_MoveTimer_timeout():
	direction = Vector2(random(), random()).normalized() * SPEED


func _on_EnemyWeapon_body_entered(body):
	if body.name == "Player":
		body.hitpoints -= 1
		body.check_health()
