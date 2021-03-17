extends Spatial

var volume_areas = []
var pitch_areas = []
var min_freq = 65.41
var max_freq = 987.77

func _ready():
	pass


func _process(delta):
	pass
	
func _physics_process(delta):
	
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
				var freq = ((diff / 6.0) * max_freq) + min_freq
				osc_sender.msg("/play/freq")
				osc_sender.add(freq)
				osc_sender.send()
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


func _on_VolumeArea_area_entered(area):
	if not area in volume_areas:
		volume_areas.append(area)


func _on_VolumeArea_area_exited(area):
	if area in volume_areas:
		volume_areas.erase(area)
