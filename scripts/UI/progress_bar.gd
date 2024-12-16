extends ProgressBar

@onready var player = PlayerReference.player

func _ready():
	player.connect("health_changed", Callable(self, "_on_player_health_changed"))
	value = player.player_stats.player_health_stat.get_current_health() * 100 / player.player_stats.player_health_stat.MAX_VALUE

func _on_player_health_changed():
	print("from health_changed")
	value = player.player_stats.player_health_stat.get_current_health() * 100 / player.player_stats.player_health_stat.MAX_VALUE
