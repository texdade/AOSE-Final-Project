:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

add deliverToRailbot(Box) && (\+ belief need_recharge) => [
    cr takeoff,
    cr goto(Box),
    cr land,
    act pickUp(Box),
    cr takeoff,
    check_artifact_belief(Box, start(S)),
    check_artifact_belief(Box, destination(D)),
    act (getLandingZone(S,D), Platform),
    cr goto(Platform),
    cr land,
    act dropDown,
    add_belief(nedd_recharge),
    add_desire(recharge),
    remove_belief(busy),
    stop
].