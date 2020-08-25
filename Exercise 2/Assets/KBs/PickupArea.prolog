:- consult("UnityLogic/KBs/UnityLogicAgentAPI.prolog").

/* calls a drone to manage a newly spawned box */
add callDrone(Box) && true => [
    act (getDrone, Drone),
    ( /*Mark the drone as busy*/
        not(check_agent_belief(Drone,busy)),
        add_agent_belief(Drone,busy)    
    ),
    add_agent_desire(Drone, deliverToRailbot(Box)),
    del_desire(callDrone(Box)),
    stop
].

