
extends CanvasLayer

# Señal emitida cuando comienza el juego
signal start_game

# Muestra un mensaje en pantalla y oculta después de un tiempo
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

# Muestra mensaje de fin de juego y reinicia la UI
func show_game_over():
	show_message("Fin")
	await $MessageTimer.timeout
	$MessageLabel.text = "Esquiva a\nlos mounstros"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()  # Muestra botón para reiniciar

# Actualiza el marcador de puntos
func update_score(score):
	$ScoreLabel.text = str(score)

# Al presionar el botón de inicio, lo oculta y emite señal
func _on_StartButton_pressed():
	$StartButton.hide()
	start_game.emit()

# Oculta el mensaje cuando el timer termina
func _on_MessageTimer_timeout():
	$MessageLabel.hide()
