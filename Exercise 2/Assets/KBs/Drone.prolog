:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

/* picks up a box and gives it to the appropriate railbot */
add deliverToRailbot(Box) && (\+ belief need_recharge) => [
    /* Take off and go to pick up the box */
    cr takeoff,
    cr goto(Box),
    cr land,
    act pickUp(Box),
    cr takeoff,

    /*read the box delivery indications and follow them */
    check_artifact_belief(Box, start_area(S)),
    check_artifact_belief(Box, dest_area(D)),
    act (getLandingZone(S,D), Platform),
    cr goto(Platform),
    cr land,
    act dropDown,

    /* Notify the railbot */
    act (getRailBot(S), RailBot),
    add_agent_desire(RailBot, passBox(Box)),

    /* Recharge after each travel */
    add_belief(need_recharge),
    add_desire(recharge),
    del_belief(busy),
    stop
].

/* picks up a box from a railbot and gives it to the appropriate warehose */
add deliverToWHouse(Box) && (\+ belief need_recharge) => [
    /* Take off and go to pick up the box */
    cr takeoff,
    cr goto(Box),
    cr land,
    act pickUp(Box),
    cr takeoff,

    /*read the box delivery indications and follow them */
    check_artifact_belief(Box, destination(D)),
    cr goto(D),
    cr land,
    act dropDown,

    /* Recharge after each travel */
    add_belief(need_recharge),
    add_desire(recharge),
    del_belief(busy),
    stop
].

add recharge && (belief need_recharge) => [
    cr takeoff,
    act (getChargingStation, CStation),
    cr goto(CStation),
    cr land,
    del_belief(need_recharge),
    stop
].