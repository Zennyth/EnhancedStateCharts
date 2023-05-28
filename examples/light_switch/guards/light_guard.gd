extends EGuard

@export var button: Button

func is_satisfied(_context_transition: ETransition, _context_state: EState) -> bool:
	if button == null:
		return false
	
	return button.text == "test"

