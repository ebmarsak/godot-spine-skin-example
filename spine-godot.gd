extends Node2D

onready var spine_sprite: SpineSprite = $girlB

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	test2()
	pass


func test2() -> void:
	
	## Here you get the skeleton of SpineSprite and set the "default" skin from Spine project as it's skin.
	## This "default" skin is just like the skin named "skin-base" in "Mix and Match" example project in Spine2D.
	## We set its skin as "default" just to be able to add other skins on top of it later.
	spine_sprite.get_skeleton().set_skin_by_name("default")
	var custom_skin: SpineSkin = spine_sprite.get_skeleton().get_skin()
	
	
	## List of all skins avaliable for the SpineSprite. Location to skins are the same as your folder structure in Spine2D.
	## There's probably a better way of doing this other than hard-coding all the skins but runtime is not documented that well to be honest. Feel free to enlighten me.
	var hair_skins = ["equipment/hair/hair-pixie-blue", "equipment/hair/hair-green", "equipment/hair/hair-purple", "equipment/hair/hair-pixie-pink"]
	var ear_skins = ["equipment/ear/ear-elf", "equipment/ear/ear-human"]
	var mouth_skins = ["equipment/mouth/mouth-default", "equipment/mouth/mouth-sad", "equipment/mouth/mouth-smile"]
	var piercing_skins = ["equipment/piercing/pierce-1", "equipment/piercing/pierce-2", "equipment/piercing/pierce-3"]
	var shirt_skins = ["equipment/shirt/shirt-black", "equipment/shirt/shirt-pink", "equipment/shirt/shirt-red"]
	
	
	## Set random skins from the arrays to custom_skin.
	custom_skin.add_skin(pickRandomSkin(hair_skins, spine_sprite))
	custom_skin.add_skin(pickRandomSkin(ear_skins, spine_sprite))
	custom_skin.add_skin(pickRandomSkin(mouth_skins, spine_sprite))
	custom_skin.add_skin(pickRandomSkin(piercing_skins, spine_sprite))
	custom_skin.add_skin(pickRandomSkin(shirt_skins, spine_sprite))
	
	
	## Setup pose for SkinSprite to basically refresh it.
	spine_sprite.get_skeleton().set_to_setup_pose()



## This is a very basic way of implementing randomness in Godot.
## If you need more depth on randomness and how to implement: https://docs.godotengine.org/en/stable/tutorials/math/random_number_generation.html
## Returns a random SpriteSkin from an array containing paths to skins.
func pickRandomSkin(array: Array, sprite: SpineSprite) -> SpineSkin:
	
	rng.randomize() # Randomize the seed on our RandomNumberGenerator instance based on current time.
	array.shuffle() # Shuffle the array because why not.
	
	var random_skin = array[rng.randi() % array.size()]
	var skin: SpineSkin = sprite.get_skeleton().get_data().find_skin(random_skin)
	
	return skin
