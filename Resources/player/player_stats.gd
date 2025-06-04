class_name PlayerStats
extends Resource

@export var player_health_stat: HealthComponent
@export var player_main_weapon: Weapon
@export var player_secondary_weapon: Weapon                                                                     
@export var player_special_ability: Weapon
@export var current_score: float
var player_main_weapon_icon: Texture2D
var player_secondary_weapon_icon: Texture2D

func set_player_main_weapon_icon():
	player_main_weapon_icon = player_main_weapon.weapon_icon

func set_player_secondary_weapon_icon():
	player_secondary_weapon_icon = player_secondary_weapon.weapon_icon
