extends NinePatchRect

func update_GUI(current_health, max_health, strength, stamina):
	$HBoxContainer/Health.text = "Health " + str(current_health) + "/" + str(max_health)
	$HBoxContainer/Strength.text = "Strength: " + str(strength)
	$HBoxContainer/Stamina.text = "Stamina: " + str(stamina)
