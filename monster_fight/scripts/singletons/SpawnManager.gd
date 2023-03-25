extends Node

func spawnCharacter(building: StaticBody3D, character: PackedScene):
	match (building.name):
		"HeroTower":
			spawnHero(building, character)
			pass

func spawnHero(building: StaticBody3D, character: PackedScene):
	print("Should spawn Hero")
	pass
