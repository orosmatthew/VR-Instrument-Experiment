extends Spatial


var speed: float = 0
var prev_pos: Vector3 = Vector3()


func _ready():
	pass
	
func _physics_process(delta):
	speed = 10 * global_transform.origin.distance_to(prev_pos)
	prev_pos = global_transform.origin


