extends RigidBody2D



@export var type: String = ''
@onready var Water = $Types/Water
@onready var Food = $Types/Food
@onready var Metal = $Types/Metal
@onready var Solar = $Types/Solar
@onready var Neutronium = $Types/Neutronium
@onready var Ammo = $Types/Ammo

func display():
	Food.hide()
	Water.hide()
	Ammo.hide()
	Neutronium.hide()
	Metal.hide()
	Solar.hide()
	match type:
		"food":
			Food.show()
		"water":
			Water.show()
		"ammo":
			Ammo.show()
		"neutronium":
			Neutronium.show()
		"metal":
			Metal.show()
		"solar":
			Solar.show()

func _process(delta):
	pass
