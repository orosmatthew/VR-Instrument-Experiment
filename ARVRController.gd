extends ARVRController


var speed: float = 0
var prev_pos: Vector3 = Vector3()
var rumble_strength: float = 0

func _physics_process(delta):
	speed = 10 * global_transform.origin.distance_to(prev_pos)
	prev_pos = global_transform.origin
	rumble_strength = get_rumble()

func make_rumble(strength: float, duration: float):
	set_rumble(strength)
	var rumble_timer = Timer.new()
	rumble_timer.set_wait_time(duration)
	rumble_timer.set_one_shot(true)
	add_child(rumble_timer)
	rumble_timer.start()
	yield(rumble_timer, "timeout")
	set_rumble(0)
	
func _process(delta):
	$VibrationVisual.scale = Vector3(get_rumble() * 6, get_rumble() * 6, get_rumble() * 6)
	$VibrationVisual.global_transform.origin = global_transform.origin + Vector3(0, 0.8, 0)

