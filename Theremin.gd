extends Spatial

var volume_areas = []
var pitch_areas = []
export var min_freq = 130.81
export var max_freq = 493.88
var curr_freq = 0

var note_array = []
var count = 0

func _ready():
	
	var f = min_freq
	
	while f < 987.77:
		note_array.append(f)
		f *= pow(2, 1/12.0)
		
func get_note_dist(f):
	
	var dist = max_freq
	
	for n in note_array:
		var d = abs(f - n)
		if d < dist:
			dist = d
	
	return dist


func _process(delta):
	pass
	
func _physics_process(delta):
	
	if count < 2:
		count += 1
		return
	
	count = 0
	
	var osc_sender = get_tree().get_root().get_node("Game").osc_sender
	
	if len(volume_areas) == 0:
		osc_sender.msg("/play/freq")
		osc_sender.add(0)
		osc_sender.send()
	else:
		for area in pitch_areas:
			if area.get_parent().name == "ARVRControllerLeft":
				var point = area.get_parent().get_node("Point").global_transform.origin
				var own_point = get_node("PitchPoint").global_transform.origin
				var diff = abs(point.x - own_point.x)
				diff = clamp(diff, 0, 6)
				diff = 6 - diff
				curr_freq = ((diff / 6.0) * max_freq) + min_freq
				osc_sender.msg("/play/freq")
				osc_sender.add(curr_freq)
				osc_sender.send()
				
				var dist = get_note_dist(curr_freq)
				
				var r = 1 - (clamp(dist, 0, 8) / 8.0)
				
				r *= 0.12
				
				area.get_parent().set_rumble(r)
				
				
		for area in volume_areas:
			if area.get_parent().name == "ARVRControllerRight":
				var point = area.get_parent().get_node("Point").global_transform.origin
				var own_point = get_node("VolumePoint").global_transform.origin
				var diff = abs(point.y - own_point.y)
				diff = clamp(diff, 0, 3.5)
				var volume = diff / 3.5
				osc_sender.msg("/play/volume")
				osc_sender.add(volume)
				osc_sender.send()
	


func _on_PitchArea_area_entered(area):
	if not area in pitch_areas:
		pitch_areas.append(area)


func _on_PitchArea_area_exited(area):
	if area in pitch_areas:
		pitch_areas.erase(area)
	if area.get_parent().name == "ARVRControllerLeft":
		area.get_parent().set_rumble(0)


func _on_VolumeArea_area_entered(area):
	if not area in volume_areas:
		volume_areas.append(area)


func _on_VolumeArea_area_exited(area):
	if area in volume_areas:
		volume_areas.erase(area)
