publicVariable "reserveHeloCommander";
publicVariable "reserveHeloCrew1";
publicVariable "reserveHeloCrew2";

// Make sure you turn off "EnableSimulation" for chair!

sleep 4;

_building = nearestBuilding chair1;
_building animate ["Door_3_rot", 1];

sleep 2;

// Initialise crew for first time...
reserveHeloCrew1 = ["B_HeliCrew_F", getPos reserveGunner1Spawn, getPos chair1, "SIT_U1"] 
call BOOG_fnc_spawn_reserve_helo_crew;

reserveHeloCrew2 = ["B_HeliCrew_F", getPos reserveGunner2Spawn, getPos chair2, "SIT_U2"]
call BOOG_fnc_spawn_reserve_helo_crew;

reserveHeloCommander = ["B_HeliPilot_F", getPos reserveCommanderSpawn, getPos reserveHeloCommanderWaitPoint, "BRIEFING"]
call BOOG_fnc_spawn_reserve_helo_crew;


// Check to see if any of the reserves are in a helo, if so respawn them...
while {true} do {

	sleep 5;

	if (vehicle reserveHeloCrew1 != reserveHeloCrew1) then {
		reserveHeloCrew1 = ["B_HeliCrew_F", getPos reserveGunner1Spawn, getPos chair1, "SIT_U1"] 
			call BOOG_fnc_spawn_reserve_helo_crew;    
	};

	if (vehicle reserveHeloCrew2 != reserveHeloCrew2) then {
		reserveHeloCrew2 = ["B_HeliCrew_F", getPos reserveGunner2Spawn, getPos chair2, "SIT_U2"]
			call BOOG_fnc_spawn_reserve_helo_crew; 
	};

	if (vehicle reserveHeloCommander != reserveHeloCommander) then {
		reserveHeloCommander = ["B_HeliPilot_F", getPos reserveCommanderSpawn, getPos reserveHeloCommanderWaitPoint, "BRIEFING"]
			call BOOG_fnc_spawn_reserve_helo_crew;		
	};

}
