@tool
## A composite guard that is satisfied when all of its guards are satisfied.
class_name AllOfEGuard
extends EGuard

## The guards that need to be satisified. When empty, returns true.
@export var guards:Array[EGuard] = [] 

func is_satisfied(context_transition: ETransition, context_state: EState) -> bool:
    for guard in guards:
        if not guard.is_satisfied(context_transition, context_state):
            return false

    return true