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

/* picks up box from exchange station and moves it to the respective
   coloured tile */
add sortBox(Box) && (\+ belief need_recharge) => [
    /* pick up box and read its destination, then drop the box the appropriate area */
    cr goto(Box),
    act pickUp(Box),
    check_artifact_belief(start_area(S)),
    act (getArea(S), Area),
    cr goto(Area),
    act dropDown(Area),

    /* notify a drone that it needs to deliver a package */
    add_desire(contactDrone(Box)),
    stop
].

/* tries to find a free drone to deliver the package */
add contactDrone(Box) && (\+ belief need_recharge) => [
    act (getDrone, Drone),
    ( /*Mark the drone as busy*/
        not(check_agent_belief(Drone,busy)),
        add_agent_belief(Drone,busy)    
    ),
    add_agent_desire(deliverToWHouse(Box)),
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