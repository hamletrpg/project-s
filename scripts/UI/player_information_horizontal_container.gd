class_name PlayerInformationHorizontalContainer
extends HBoxContainer

var instance_label_for_score = Label.new()
var score_value = Label.new()
#@onready var label: Label = %Current_Level
#@onready var icon: TextureRect = $TextureRect

#func _ready():
	#add_child(label) 
	#add_child(icon)

func render_player_info(text:String, texture:Texture2D):
	var instance_label = Label.new()
	instance_label.set_text(text)
	add_child(instance_label)
	var instance_texture = TextureRect.new()
	instance_texture.texture = texture
	instance_texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	instance_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	add_child(instance_texture)
	
func render_player_score(text:String):
	instance_label_for_score.set_text(text)
	add_child(instance_label_for_score)
	#var score = Label.new()
	#score.set_text(str(score_value))
	add_child(score_value)

	
func set_score_value(value:float):
	score_value.set_text(str(value))
