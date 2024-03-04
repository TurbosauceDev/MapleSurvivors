extends Node2D

#region --- Variables ---
@export var spawns: Array[Spawn_info] = []
@onready var player = get_tree().get_first_node_in_group("player")

var time = 0
#endregion

#region --- Spawn Mobs ---
#We start our timer and then do the following
func _on_spawn_timer_timeout(): 
	time += 1 #add 1 second of time 
	var enemy_spawns = spawns
	for slimes in enemy_spawns:
		if time >= slimes.time_start and time <= slimes.time_end: #go through mobs, check if it is time to spawn one
			if slimes.spawn_delay_counter < slimes.enemy_spawn_delay: #check if there is a delay to spawn
				slimes.spawn_delay_counter += 1 #increase the counter if there is a delay
			else:
				slimes.spawn_delay_counter = 0 #set counter to 0
				var new_enemy = slimes .enemy #load in mob to new enemy var
				var counter = 0
				while counter < slimes.enemy_num: #spawn number of enemies
					var enemy_spawn = new_enemy.instantiate() #loaded mob is spawned
					enemy_spawn.global_position = get_random_position() #spawn in random spot via math stuff
					add_child(enemy_spawn) #added as a child of the spawner
					counter += 1 #do so until counter is reached, then go back to for slimes until gone through whole array
#endregion

#region --- Random Spawn Math ---
func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.5 , 2.0)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var pos_side = ["up" , "down" , "right" , "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
#endregion 
