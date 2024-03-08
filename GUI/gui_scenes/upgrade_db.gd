extends Node

const ICON_PATH = "res://Assets/visuals/upgrades/"
const WEAPON_PATH = "res://Assets/visuals/weapons/"
const UPGRADES = {
	#region --- Magic Bolt ---
	"magicbolt_1": {
		"icon" : WEAPON_PATH + "magic-bolt_ball.png",
		"displayname" : "Magic Bolt",
		"details" : "Form mana into a bolt of energy to attack a random enemy",
		"level" : "Level: 1",
		"prereq" : [],
		"type" : "weapon"
		},
	"magicbolt_2": {
		"icon" : WEAPON_PATH + "magic-bolt_ball.png",
		"displayname" : "Magic Bolt",
		"details" : "Form mana into a bolt of energy to attack 2 random enemies",
		"level" : "Level: 2",
		"prereq" : ["magicbolt_1"],
		"type" : "weapon"
		},
	"magicbolt_3": {
		"icon" : WEAPON_PATH + "magic-bolt_ball.png",
		"displayname" : "Magic Bolt",
		"details" : "Form mana into a bolt of energy to attack 3 random enemies",
		"level" : "Level: 3",
		"prereq" : ["magicbolt_2"],
		"type" : "weapon"
		},
	"magicbolt_4": {
		"icon" : WEAPON_PATH + "magic-bolt_ball.png",
		"displayname" : "Magic Bolt",
		"details" : "Form mana into a bolt of energy to attack 4 random enemies",
		"level" : "Level: 4",
		"prereq" : ["magicbolt_3"],
		"type" : "weapon"
		},
	"magicbolt_5": {
		"icon" : WEAPON_PATH + "magic-bolt_ball.png",
		"displayname" : "Magic Bolt",
		"details" : "Form mana into a bolt of energy to attack 5 random enemies",
		"level" : "Level: 5",
		"prereq" : ["magicbolt_4"],
		"type" : "weapon"
		#endregion
		},
		#region --- Green Slime Candy ---
	"slime_candy_green": {
		"icon" : ICON_PATH + "icon.svg",
		"displayname" : "Green Slime Candy",
		"details" : "Delicious Green Slime Candy that reminds you of childhood. Lemon-lime flavor!",
		"level" : "",
		"prereq" : [],
		"type" : "consumable"
		#endregion
		}
	}
