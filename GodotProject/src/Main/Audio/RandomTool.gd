extends Node2D

var index_sound = -1
var select_sound
var canplay

export (float) var Volume = 0
export (float) var Pitch = 0

export (bool) var RandomVolume
export (float) var minVolume
export (float) var maxVolume

export (bool) var RandomPitch
export (float) var minPitch
export (float) var maxPitch

var avVolume
var avPitch
var dflt_values: Dictionary

func _ready():
	Pitch = Pitch/24
	
	# Crear el diccionario de valores por defecto para los efectos de sonido
	# hijos
	for sfx in get_children():
		dflt_values[sfx.name] = {
			'pitch': sfx.get_pitch_scale(),
			'volume': sfx.get_volume_db()
		}

func play():
	randomize()
	
	index_sound = randi()%get_child_count()
	select_sound = get_child(index_sound)
#
#	if RandomVolume == true:
#		select_sound.randomizeVol(avVolume, minVolume, maxVolume)
#	else:
#	select_sound.set_volume_db(avVolume)
#
#
#	if RandomPitch == true:
#		select_sound.randomizePitch(avPitch, minPitch, maxPitch)
#	#	select_sound.set_pitch_scale((Pitch) + ranPitch)
#	else:
	select_sound.play()
	select_sound.set_pitch_scale(dflt_values[select_sound.name].pitch + Pitch)
	
	
func randomizeVol(Volume, minVolume, maxVolume):
	var ranVol = (rand_range( minVolume, (maxVolume+1)))
	select_sound.set_volume_db(Volume + ranVol)

func randomizePitch(_Pitch, minPitch, maxPitch):
		var ranPitch = (rand_range( minPitch + 1, (maxPitch+1)))
		if (_Pitch + ranPitch > 0):
			select_sound.set_pitch_scale(_Pitch + ranPitch)

