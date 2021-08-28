extends Node

var currentState

var statesMap : Dictionary

var statesStack: Array

export(String) var initialState



# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in get_children():
		
		statesMap[i.name] = i

		i.connect("finished", self, "changeState")

func initialize():
	statesStack.push_front(statesMap[initialState])
	
	currentState = statesStack[0]
	
	currentState.enter()


func changeState(stateName : String):
	
	currentState.exit()
	
	statesStack[0] = statesMap[stateName]
	
	currentState = statesStack[0]
	
	currentState.enter()
