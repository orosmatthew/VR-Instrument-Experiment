extends Spatial

var osc_sender

func _ready():
	osc_sender = load("res://addons/gdosc/gdoscsender.gdns").new()
	osc_sender.setup("127.0.0.1", 9001)
	osc_sender.start()
	osc_sender.msg("/play/volume")
	osc_sender.add(0.25)
	osc_sender.send()
	osc_sender.msg("/play/midi")
	osc_sender.add(60)
	osc_sender.send()

func _physics_process(delta):
	pass
