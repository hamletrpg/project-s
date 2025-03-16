extends ProgressBar

@onready var player = PlayerReference.player

func _ready():
	player.connect("green_bullet_burst", Callable(self, "_on_player_green_bullet_burst"))
	value = player.hit_count

func _on_player_green_bullet_burst():
	print("from green_bullet_burst")
	value = player.hit_count
