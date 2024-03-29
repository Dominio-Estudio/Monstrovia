# Creado por Juan Velandia <juankz@protonmail.com>
# Para Dominio Estudio <www.dominioestudio.com>. Todos los derechos reservados

extends Spatial

var VehiclesFabric = preload("res://autos/VehiclesFabric.gd").new()

var WorldChunks = [
	preload("res://world/WorldChunk.tscn"),
	preload("res://world/WorldChunk2.tscn"),
	preload("res://world/WorldChunk3.tscn"),
	preload("res://world/WorldChunkCicloRuta.tscn"),
	preload("res://world/WorldChunkObstacle2.tscn"),
	preload("res://world/WorldChunkObstacle3.tscn"),
	preload("res://world/WorldChunkSemaphore.tscn"),
]
var university = preload("res://world/UniversityChunk.tscn")
var world_chunks = []
var last_chunk = 0
var last_chunk_count = 0

var world_chunks_pool = [] #TODO: Add pool generation
const world_chunk_size = 60

const SPEED_STEP = 0.5
export(float,0.0,1.0) var P_appear_behind_player = 0.4

var vehicle_spawn_time = 0
var last_vehicle_spawn_time = 0
export var vehicle_spawn_interval = 1.5 #s
var vehicles = []

# TODO this times can vary depending on the level
var emul_time: int = 1800
var real_time = 120
var time_scale = emul_time / real_time

var distance_to_goal = 20 * real_time
var traveled_distance = 0
var close_to_goal = false
var game_over = false

export(Color) var normal_fog

export var traffic_density = 5 # How many vehicles are there in the world

signal game_over_by_time

func _ready():
	randomize()
	globals.tutorial = true
	for i in range(7):
		var new_chunk = WorldChunks[randi()%3].instance()
		new_chunk.translation = Vector3(0,0,i*world_chunk_size)
		world_chunks.push_front(new_chunk)
		add_child(new_chunk)

func _process(delta):
	if globals.tutorial:
		return
	var all_vehicles: Array = get_tree().get_nodes_in_group("vehicles")
	if all_vehicles.size() < traffic_density:
		if vehicle_spawn_time - last_vehicle_spawn_time >= vehicle_spawn_interval  && traveled_distance < distance_to_goal - world_chunk_size*world_chunks.size():
			last_vehicle_spawn_time = vehicle_spawn_time
			generate_vehicle()
		else:
			vehicle_spawn_time += delta
	if traveled_distance >= distance_to_goal - world_chunk_size*0.2:
		if !game_over:
			game_over = true
			end_level()
	update_ui()

func _physics_process(delta):
	update_time(delta)
	update_ui()
	traveled_distance += $Jugador.speed*delta
	$Label.text = str(traveled_distance," - ",distance_to_goal)
	
	var offset = 10
	for chunk in world_chunks:
		#TODO This is goung to change when street turning gets implemented
		#move chunk
		chunk.global_translate(Vector3(0,0,-$Jugador.speed*delta))
		#Remove chunks that are no longer visible to the player
		var distance_to_player = chunk.global_transform.origin - $Jugador.global_transform.origin
		if  distance_to_player.z < 0 and distance_to_player.length() > world_chunk_size + offset:
			var old_chunk = world_chunks.pop_back()
			#TODO: Add pool generation
			old_chunk.queue_free()
			remove_child(old_chunk)
			# Create a new chunk
			if traveled_distance < distance_to_goal - world_chunk_size*world_chunks.size():
				var new_chunk = generate_world_chunk(Vector3(0,0,world_chunk_size + world_chunks[0].global_transform.origin.z))
				add_child(new_chunk)
			elif(!close_to_goal):
				close_to_goal = true
				var new_chunk = preload("res://world/UniversityChunk.tscn").instance()
				var pos = Vector3(0,0,world_chunk_size + world_chunks[0].global_transform.origin.z)
				new_chunk.translation = pos
				world_chunks.push_front(new_chunk)
				add_child(new_chunk)
	for vehicle in vehicles:
		vehicle.global_translate(Vector3(0,0,-$Jugador.speed*delta))
#		var distance_to_player = vehicle.global_transform.origin.distance_to($Jugador.global_transform.origin)
		var distance_to_player = vehicle.global_transform.origin.z - $Jugador.global_transform.origin.z
		if  distance_to_player > world_chunk_size*6 or distance_to_player <  - world_chunk_size*2:
			vehicles.erase(vehicle)
			remove_child(vehicle)
			vehicle.queue_free()

func update_time(delta):
	real_time -= delta
	emul_time = floor(real_time * time_scale)
	emul_time = max(emul_time,0)
	var s = int(emul_time)%60 #mandatory casting for web
	
	if s < 10:
		$UI/HUD/TextureRect/Label.text = str(int(emul_time)/60,':0',s)
	else:
		$UI/HUD/TextureRect/Label.text = str(int(emul_time)/60,':',s)
	if(emul_time <= 0):
		emit_signal("game_over_by_time")
#	$UI/Time/Label.text = str(emul_time)
#TODO: Add pool generation
func generate_world_chunk(pos: Vector3):
	var r = randf()
	var new_chunk
	if last_chunk == 3 || (r > 0.8 && last_chunk_count < 20):
		last_chunk_count += 1
		new_chunk = WorldChunks[3].instance()
	elif r > 0.7: #0.7
		new_chunk = WorldChunks[4 + randi()%2].instance()
	elif r > 0.55: #0.65
		new_chunk = WorldChunks[6].instance()
	else:
		new_chunk = WorldChunks[randi()%3].instance()

	new_chunk.translation = pos
	world_chunks.push_front(new_chunk)
	return new_chunk

func generate_vehicle():
	var auto = VehiclesFabric.generate_vehicle()
	auto.player = $Jugador
	var mode = auto.get_random_mode()
	auto.random_speed(mode)

	var spawn_points

	if mode == auto.MODES.SLOW && $Jugador.speed > 10:
		spawn_points = $SpawnPointsFront
	else:
		spawn_points = $SpawnPointsFront

	var player_slot = get_player_slot(spawn_points)
	# If there isn't another car at the spawn point, add the car to the scene.
	var slot_is_colliding = (player_slot as Area).get_overlapping_areas().size()
	if slot_is_colliding <= 0:
		if randf() < P_appear_behind_player:
			auto.translation = player_slot.global_transform.origin
		else:
			var rand_slot = randi()%2 + 1
			auto.translation = spawn_points.get_node(str("Slot",rand_slot)).global_transform.origin
	
		vehicles.push_front(auto)
		add_child(auto)
	else:
		#Don't add the car. TODO: Use a pool to improve memory handling
		auto.free()

func get_player_slot(spawn_points):
	if $Jugador.global_transform.origin.x > spawn_points.get_node("Linea1").global_transform.origin.x:
		return spawn_points.get_node("Slot1")
	if $Jugador.global_transform.origin.x > spawn_points.get_node("Linea2").global_transform.origin.x:
		return spawn_points.get_node("Slot2")
	else:
		return spawn_points.get_node("Slot3")

func increase_speed():
	globals.tutorial = false
#	$UI/Tutorial/Accel.visible = false
	$Jugador.modify_speed(SPEED_STEP)
	update_ui()

func decrease_speed():
	$Jugador.modify_speed(-SPEED_STEP)
	update_ui()

func _unhandled_input(event):
#	if event.is_action_pressed("ui_up"):		
#		increase_speed()
#	if event.is_action_pressed("ui_down"):
#		decrease_speed()
	if(Input.is_action_pressed("ui_up")):
		increase_speed()
	if(Input.is_action_pressed("ui_down")):
		decrease_speed()

func _on_InputManager_swiped(gesture):
	if globals.is_mobile:
		var dir = gesture.get_direction()
		if dir == 'up':
			increase_speed()
		if dir == 'down':
			decrease_speed()
		update_ui()

func update_ui():
	var fake_speed = floor($Jugador.speed / $Jugador.offset_speed_change)
	$UI/HUD/Speed/Label.text = str(fake_speed," KM")
	if(fake_speed > 20):
		$UI/HUD/Speed/Label.add_color_override("font_color", Color.red)
		if(!$UI/HUD/Speed/Label/AnimationPlayer.is_playing()): $UI/HUD/Speed/Label/AnimationPlayer.play("SpeedWarning")
	else: $UI/HUD/Speed/Label.add_color_override("font_color", Color.white)
	var remaining_distance = distance_to_goal - traveled_distance
	var i = floor(remaining_distance/1000)
	var d = floor((remaining_distance - i*1000)/100)
	$UI/HUD/TextureRect/DistanceLabel.text = str(i,',',d, ' Km')
	
	
func monstrify():
	$Camera.environment.fog_color = Color.red
	$MonstrificationSound.play()

func normalize():
	$Camera.environment.fog_color = normal_fog
	$MonstrificationSound.stop()

func end_level():
	$Jugador.speed = 0
	$AudioStreamPlayer.stop()
	var end_scene = preload("res://bicycle_level/end_scene/EndScene.tscn").instance()
	add_child(end_scene)
	end_scene.get_node("AnimationPlayer").play("default")
