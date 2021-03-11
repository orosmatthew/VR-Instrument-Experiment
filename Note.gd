extends Spatial

export var note = 60

func _ready():
	pass



func _on_Area_area_shape_entered(area_id, area, area_shape, self_shape):
	var osc_sender = get_tree().get_root().get_node("Game").osc_sender
	osc_sender.msg("/play/volume")
	osc_sender.add(clamp(area.get_parent().get_parent().get("speed"), 0, 5) / 10.0)
	osc_sender.send()
	osc_sender.msg("/play/voice")
	osc_sender.add(note)
	osc_sender.send()
	
	var new_scale = 1 + (clamp(area.get_parent().get_parent().get("speed"), 0, 5) / 5.0) / 5.0
	
	var tween = get_node("HitTween")
	
	tween.interpolate_property($Mesh, "scale", Vector3(1, 1, 1), Vector3(new_scale, new_scale, new_scale), 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.start()

func _on_HitTween_tween_completed(object, key):
	var tween = get_node("ReturnTween")
	tween.interpolate_property($Mesh, "scale", $Mesh.scale, Vector3(1, 1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
