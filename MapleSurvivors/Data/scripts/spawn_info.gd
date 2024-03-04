extends Resource

class_name Spawn_info

@export var time_start : int #when enemy should start spawning (in seconds)
@export var time_end : int #when enemy should stop spawning (in seconds)
@export var enemy : PackedScene #Type of enemy spawned
@export var enemy_num : int #the number of enemies that spawn
@export var  enemy_spawn_delay : int #seconds of delay between spawns
@export var spawn_delay_counter : int = 0 #tracks delayed seconds
