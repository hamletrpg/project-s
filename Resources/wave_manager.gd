class_name WaveManager
extends Resource

'''
Wave Manager:
	Hold the list of waves for a level
	Is responsible for knowing previous wave, current and next one
'''

@export var list_of_waves: Array[Waves] = []
@export var current_wave_identifier: int
