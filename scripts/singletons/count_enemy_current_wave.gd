extends Node

var number_of_enemies_on_this_wave: int = 0

func increment_enemy_count():
	number_of_enemies_on_this_wave += 1
	print("the enemy count is ", number_of_enemies_on_this_wave)

func decrement_enemy_count():
	number_of_enemies_on_this_wave -= 1
	print("the enemy count is ", number_of_enemies_on_this_wave)
	
