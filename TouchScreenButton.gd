extends TouchScreenButton

# Gonkee's joystick script for Godot 3 - full tutorial https://youtu.be/uGyEP2LUFPg
# If you use this script, I would prefer if you gave credit to me and my channel

# Change these based on the size of your button and outer sprite
var radius = Vector2(32, 32)
var boundary = 32

var ongoing_drag = -1
var fix_joy_pos = -1

var return_accel = 30

var threshold = 15

#func _ready():
#	var joypos = get_tree().get_root().find_node("HUD" ,true, false)
# warning-ignore:function_used_as_property
#	joypos.connect("toggle_joy_pos",self,_on_toggle_joy_pos())

func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0, 0) - radius) - position
		position += pos_difference * return_accel * delta

func get_button_pos():
	return position + radius

func _input(event):

	if (
		event is InputEventScreenTouch
#		and fix_joy_pos !=-1
	):
		get_parent().position = event.position

	if (event is InputEventScreenDrag 
	or (event is InputEventScreenTouch 
	and event.is_pressed())
	):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()

		if event_dist_from_centre <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - radius * global_scale)

			if get_button_pos().length() > boundary:
				set_position( get_button_pos().normalized() * boundary - radius)

			ongoing_drag = event.get_index()

	if (event is InputEventScreenTouch and 
	!event.is_pressed() and 
	event.get_index() == ongoing_drag
	):
		ongoing_drag = -1
		get_parent().position = get_viewport_rect().size / Vector2(2,1.2)

func get_value():
	if get_button_pos().length() > threshold:
		return get_button_pos()
	
	return Vector2(0, 0)

#func _on_toggle_joy_pos():
#	fix_joy_pos = 1
	

