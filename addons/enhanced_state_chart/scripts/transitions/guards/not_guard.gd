@tool
## A guard which is satisfied when the given guard is not satisfied.
class_name NotEGuard
extends EGuard

## The guard that should not be satisfied. When null, this guard is always satisfied.
@export var guard: EGuard

func is_satisfied(context_transition: ETransition, context_state: EState) -> bool:
    if guard == null:
        return true

    return not guard.is_satisfied(context_transition, context_state)