# Contiene todas las señales del juego
extends Node

# Eventos del mundo ------------------------------------------------------------
signal possum_alerted
signal possum_pretended
signal possum_discovered
signal possum_awake
signal enemy_approached(smell_time)
signal possum_done
signal enemy_left
signal object_left
signal level_started
signal world_advanced
signal world_tick
signal item_picked(count)
signal level_finished(condition)


# AudioManager -----------------------------------------------------------------
signal play_requested(source, sound)

# Constantes -------------------------------------------------------------------
const FINISH_TYPE = {
	'Victory': 'V',
	'DEFEAT': 'D'
}
