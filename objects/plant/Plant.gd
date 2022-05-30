extends Consumable

func _ready():
	generate_collision_shape()
	resize_plant_hitbox()

func _on_PlantHitbox_plant_picked_up():
	collect_plant()
