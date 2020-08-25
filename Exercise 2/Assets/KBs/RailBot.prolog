:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

/* receives a new box from a drone and passes it to the sortingbot */
add passBox(Box) && (\+ belief need_recharge) => [
    /* picks up box and passes it to the sorting bot */
    cr goto(Box),
    act pickUp(Box),
    act (getExchangeArea, ExchArea),
    cr goto(ExchArea),
    act dropDown(ExchArea),
    act (getSortingBot, SortBot),
    add_agent_desire(SortBot, sortBox(Box)),

    /* then goes for a recharge */
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