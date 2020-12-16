extends "res://Player/PlayerTemplate.gd"

var motion = Vector2()
var can_move = true
var has_key = false

var strength = 3
var stamina = 3

var damage = strength * 2
var max_hitpoints = stamina * 2
var hitpoints = max_hitpoints


func _ready():
	get_tree().call_group("GUI", "update_GUI", hitpoints, max_hitpoints, strength, stamina)


func _physics_process(delta):
	update_movement()
	animate()
	move_and_slide(motion)


func update_movement():
	if can_move:
		if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
			motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
		elif Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
			motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
		else:
			motion.y = lerp(motion.y, 0 , FRICTION)
		
		if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
			motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
		elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
			motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
		else:
			motion.x = lerp(motion.x, 0, FRICTION)


func animate():
	if motion.x == 0 and motion.y == 0:
		$AnimatedSprite.play("idle")
	elif (motion.x != 0 or motion.y != 0) and motion.x < 0:
		$AnimatedSprite/Sword.rotation_degrees = -90
		$AnimatedSprite/Sword.position = Vector2(1,7)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif (motion.x != 0 or motion.y != 0) and motion.x > 0:
		$AnimatedSprite/Sword.rotation_degrees = 90
		$AnimatedSprite/Sword.position = Vector2(0,2)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")


func _on_Sword_body_entered(body):
		body.hitpoints -= damage
		body.check_health()


func check_health():
	$AudioStreamPlayer2D.play()
	get_tree().call_group("GUI", "update_GUI", hitpoints, max_hitpoints, strength, stamina)
	if hitpoints <= 0:
		motion.x = 0
		motion.y = 0
		can_move = false
		$AnimationPlayer.play("Death")


func update_stats(type):
	if type == "health":
		hitpoints = clamp(hitpoints+2, 0, max_hitpoints)
	elif type == "strength":
		strength += 1
		damage += 2
	elif type == "stamina":
		stamina += 1
		max_hitpoints += 2
		hitpoints += 2
	get_tree().call_group("GUI", "update_GUI", hitpoints, max_hitpoints, strength, stamina)

func die():
	get_tree().change_scene("res://Interface/DeathScreen.tscn")
