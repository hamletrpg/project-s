class_name Waves
extends Resource
'''
Wave:
	Holds an array of type of enemies this wave have
	Hold timer offset of when to wait for next enemies
	Should hold some sort of identifier
'''
# can be done to control a variaty of enemies
@export var list_of_enemies_type:Array = [PackedScene]
# Number of enemies can be declared somewhere else lol
@export var number_of_enemies: int
# Every time a enemy is spawned wait a few seconds before the next one
@export var time_offset_per_enemy: int

@export var identifier: int
