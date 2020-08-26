:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

desire sortBox.

/* receives a new box from a drone and passes it to the sortingbot */
add passBox(Box) && (\+ belief need_recharge) => [
    /* picks up box and passes it to the sorting bot */
    cr goto(Box),
    /* check boxes start and dest areas */
    add_desire(checkBox(Box)),
    stop
]. 

/* If the start and destination area are different, bring box to exchange area*/
add checkBox(Box) && (\+ belief need_recharge) => [
    check_artifact_belief(Box, start_area(Start)),
    check_artifact_belief(Box, dest_area(Dest)),
    
    Start \= Dest,

    act pickUp(Box),
    act (getExchangeArea, ExchArea),
    cr goto(ExchArea),
    act dropDown(ExchArea),
    /* notifies the sortingbot */
    act (getSortingBot, SortBot),
    add_agent_belief(SortBot, need_to_sort(Box)),
    /* then goes for a recharge */
    add_desire(recharge),
    add_belief(need_recharge),
    stop
].

/* If start and dest area are the same, railbot immediately calls a drone*/
add checkBox(Box) && (\+ belief need_recharge) => [
    check_artifact_belief(Box, start_area(Start)),
    check_artifact_belief(Box, dest_area(Dest)),
    
    Start = Dest,

    /* notify a drone that it needs to deliver a package */
    add_desire(contactDrone(Box)),
    stop
].

/* picks up box from exchange station and moves it to the respective
   coloured tile */
add sortBox && (\+ belief need_recharge, belief need_to_sort(Box)) => [
    /* pick up box and read its destination, then drop the box the appropriate area */
    add_belief(busy),
    cr goto(Box),
    act pickUp(Box),
    check_artifact_belief(Box, start_area(S)),
    act (getArea(S), Area),
    cr goto(Area),
    act dropDown(Area),

    /* notify a drone that it needs to deliver a package */
    del_belief(need_to_sort(Box)),
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
    add_agent_desire(Drone, deliverToWHouse(Box)),
    add_desire(recharge),
    add_belief(need_recharge),
    stop
]. 

add recharge && (belief need_recharge) => [
    act (getChargingStation, ChargeStation),
    cr goto(ChargeStation),
    del_belief(need_recharge),
    add_desire(sortBox),
    del_belief(busy),
    stop
].