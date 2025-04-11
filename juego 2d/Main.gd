
extends Node

@export var mob_scene: PackedScene  # Escena del enemigo (mob) a generar
var score  # Puntuación actual

# Termina el juego: detiene timers, muestra Game Over y reproduce sonido
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

# Inicia un nuevo juego: reinicia puntuación, jugador y timers
func new_game():
	get_tree().call_group(&"mobs", &"queue_free")  # Elimina mobs existentes
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Preparate")
	$Music.play()

# Genera un nuevo mob en una posición y dirección aleatoria
func _on_MobTimer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node(^"MobPath/MobSpawnLocation")
	mob_spawn_location.progress = randi()  # Posición aleatoria en el camino
	
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	
	# Aleatoriza dirección y velocidad
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)  # Añade el mob a la escena

# Incrementa la puntuación cada segundo
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

# Inicia los timers principales al terminar el timer de inicio
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
