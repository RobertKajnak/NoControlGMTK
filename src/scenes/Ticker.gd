extends Timer

func _on_Ticker_timeout():
	Global.gather_calories()
