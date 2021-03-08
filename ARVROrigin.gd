extends ARVROrigin

func _ready():
	
	var arvr_interface = ARVRServer.find_interface("OpenVR")
	
	ARVRServer.world_scale = 10
	
	if arvr_interface and arvr_interface.initialize():
		get_viewport().arvr = true
		OS.vsync_enabled = false
		Engine.iterations_per_second = 90
		
