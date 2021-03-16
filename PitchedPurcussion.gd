extends Spatial


var note_colors = {"C4":Color.red, "D4":Color.orange, "E4":Color.yellow,
				   "F4":Color.green, "G4":Color.aqua, "A4":Color.blue,
				   "B4":Color.purple, "C5":Color.pink,}

func _ready():
	for note in get_children():
		var mat = SpatialMaterial.new()
		mat.albedo_color = note_colors[note.name]
		note.get_node("Mesh").set_surface_material(0, mat)
		
