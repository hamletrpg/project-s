extends HBoxContainer

@onready var player = PlayerReference.player
@onready var player_info_child_container_main_bullet: PlayerInformationHorizontalContainer = PlayerInformationHorizontalContainer.new()
@onready var player_info_child_container_secondary_bullet: PlayerInformationHorizontalContainer = PlayerInformationHorizontalContainer.new()
@onready var player_info_child_container_score: PlayerInformationHorizontalContainer = PlayerInformationHorizontalContainer.new()
var update_value: bool = false

func _ready():
	player.connect("point_changed", Callable(self, "_on_player_score_changed"))
	player_info_child_container_main_bullet.render_player_info("Main", player.player_stats.player_main_weapon_icon)
	player_info_child_container_secondary_bullet.render_player_info("Second", player.player_stats.player_secondary_weapon_icon)
	player_info_child_container_score.render_player_score("Score")
	player_info_child_container_score.set_score_value(player.player_stats.current_score)
	
	add_child(player_info_child_container_main_bullet)
	add_child(player_info_child_container_secondary_bullet)
	add_child(player_info_child_container_score)

func _on_player_score_changed():
	player_info_child_container_score.set_score_value(player.player_stats.current_score)
	
