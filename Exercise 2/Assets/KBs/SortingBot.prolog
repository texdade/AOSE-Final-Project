:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

/* Receives a new box from a railbot and passes it to the appropriate
   exchange area */
add sortBox(Box) && (\+ belief need_recharge) => [
    /* pick up the box, read its destination and go to respective exch area */
    cr goto(Box),
    act pickUp(Box),
    check_artifact_belief(Box, dest_area(D)),
    act (getExchangeArea(D), ExchArea),
    cr goto(ExchArea),
    act dropDown(ExchArea),

    /* notify the railbot of the area that it needs to sort the box */
    act (getRailBot(D), RailBot),
    add_agent_desire(RailBot, sortBox(Box)),

    /* go to recharge station */
    add_desire(recharge),
    add_belief(need_recharge),
    stop
].

add recharge && (belief need_recharge) => [
    act (getChargingStation, ChargeStation),
    cr goto(ChargeStation),
    del_belief(need_recharge),
    stop
].