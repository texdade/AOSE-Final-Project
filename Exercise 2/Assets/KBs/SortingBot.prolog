:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

desire sortBox.

/* Receives a new box from a railbot and passes it to the appropriate
   exchange area */
add sortBox && (\+ belief need_recharge, belief need_to_sort(Box)) => [
    /* pick up the box, read its destination and go to respective exch area */
    cr goto(Box),
    act pickUp(Box),
    check_artifact_belief(Box, dest_area(D)),
    act (getExchangeArea(D), ExchArea),
    cr goto(ExchArea),
    act dropDown(ExchArea),

    /* contact the railbot */
    act (getRailBot(D), RailBot),
    add_agent_belief(RailBot, need_to_sort(Box)),
    del_belief(need_to_sort(Box)),
    
    /* go to recharge station */
    add_desire(recharge),
    add_belief(need_recharge),
    stop
].

add recharge && (belief need_recharge) => [
    act (getChargingStation, ChargeStation),
    cr goto(ChargeStation),
    del_belief(need_recharge),
    add_desire(sortBox),
    stop
].