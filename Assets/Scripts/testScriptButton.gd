extends Button

func _on_pressed():
	var formattedMoney = "$%.2d"
	var _output = formattedMoney % PlayerGlobals.playerMoney
	print("$%.2d" % PlayerGlobals.playerMoney)
	PlayerGlobals.playerMoney += 20
	print("$%.2d" % PlayerGlobals.playerMoney)
	PlayerGlobals.playerMoney += 37.52
	print("$%.2d" % PlayerGlobals.playerMoney)
	PlayerGlobals.playerMoney += 5.76
	print("$%.2d" % PlayerGlobals.playerMoney)
