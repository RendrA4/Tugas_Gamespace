class_name ItemData
extends Resource

enum TYPE{
	CURRENCY,
	KEY,
	CONSUMABLES,
	EQUIPABLE,
}

@export var name: String = ""
@export var desc: String = ""
@export var value: int = 0
@export var amount: int = 1
@export var type: TYPE = TYPE.CURRENCY
