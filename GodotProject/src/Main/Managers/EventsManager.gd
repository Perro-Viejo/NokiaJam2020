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
signal level_started
signal world_advanced

# AudioManager -----------------------------------------------------------------
signal play_requested(source, sound)
