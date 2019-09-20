extends Node

var vehicles = [
	preload("res://autos/auto1.tscn"),
	preload("res://autos/auto2.tscn"),
	preload("res://autos/auto3.tscn"),
	preload("res://autos/auto4.tscn"),
	preload("res://autos/bus1.tscn"),
]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate_vehicle():
	var r = randi() % vehicles.size()
	return vehicles[r].instance()
