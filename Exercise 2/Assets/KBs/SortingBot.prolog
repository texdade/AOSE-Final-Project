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

    /* try to get the railbot attention */
    add_desire(getRailbot(Box, D)),
    stop
].

add getRailbot(Box, D) && (\+ belief need_recharge) => [
    /* notify the railbot of the area that it needs to sort the box */
    act (getRailBot(D), RailBot),
    ( /*Mark the drone as busy*/
        not(check_agent_belief(RailBot,busy)),
        add_agent_belief(RailBot,busy)    
    ),
    add_agent_desire(RailBot, sortBox(Box)),
    del_belief(busy),
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