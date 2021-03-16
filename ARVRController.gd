extends ARVRController


var speed: float = 0
var prev_pos: Vector3 = Vector3()

func _physics_process(delta):
	speed = 10 * global_transform.origin.distance_to(prev_pos)
	prev_pos = global_transform.origin

func make_rumble(strength: float, duration: float):
	set_rumble(strength)
	var rumble_timer = Timer.new()
	rumble_timer.set_wait_time(duration)
	rumble_timer.set_one_shot(true)
	add_child(rumble_timer)
	rumble_timer.start()
	yield(rumble_timer, "timeout")
	set_rumble(0)
	
	

