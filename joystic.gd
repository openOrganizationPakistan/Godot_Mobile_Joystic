extends Sprite

var joy_pos = -1

func _ready():
	scale = Vector2(1,1) * ((get_viewport_rect().size.x / 480) *3)
	z_index = 1

func _input(event):
	if joy_pos != -1 and event is InputEventScreenTouch and event.is_pressed():
		position = event.position
	if joy_pos == -1 :
		position = get_viewport_rect().size / Vector2(2,1.2)
	if joy_pos != -1 and event is InputEventScreenTouch and !event.is_pressed():
		position = get_viewport_rect().size / Vector2(2,1.2)
func _on_HUD_toggle_joy_pos_true():
	joy_pos += 1


func _on_HUD_toggle_joy_pos_false():
	joy_pos = -1
