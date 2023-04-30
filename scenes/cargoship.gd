extends RigidBody2D

enum types {none, food, water, ammo, neutronium, metal, solar}

@export var type: types = types.none
@onready var Water = $Types/Water
@onready var Food = $Types/Food
@onready var Metal = $Types/Metal
@onready var Solar = $Types/Solar
@onready var Neutronium = $Types/Neutronium
@onready var Ammo = $Types/Ammo


func _ready():
	match type:
		types.food:
			Food.show()
		types.water:
			Water.show()
		types.ammo:
			Ammo.show()
		types.neutronium:
			Neutronium.show()
		types.metal:
			Metal.show()
		types.solar:
			Solar.show()


func _process(delta):
	pass
