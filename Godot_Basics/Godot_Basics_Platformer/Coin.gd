extends Area2D

func _on_Coin_body_entered(body):
	if body.has_method("collect_coin"):
		body.collect_coin()
		queue_free()
