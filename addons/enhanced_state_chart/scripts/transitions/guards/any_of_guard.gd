@tool
## A composite guard, that is satisfied if any of the guards are satisfied.
class_name AnyOfEGuard
extends EGuard

## The guards  of which at least one must be satisfied. If empty, this guard is not satisfied.
@export var guards: Array[EGuard] = []

func is_satisfied(context_transition: ETransition, context_state: EState) -> bool:
    for guard in guards:
        if guard.is_satisfied(context_transition, context_state):
            return true

    return false