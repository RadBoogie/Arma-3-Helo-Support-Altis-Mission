_respawnPos = getPos natoVehicleRespawnPoint;
_driverRespawnPos = getPos natoVehicleDriverRespawnPoint;

// Create the vehicle at the defined position
_vehicle = createVehicle[
	"B_LSV_01_unarmed_F",  
	[_respawnPos select 0, (_respawnPos select 1) - 0.4, (_respawnPos select 2) + 6 ], 
	[], 
	0, 
	"NONE"];

_vehicle setDir 245;

_group = createGroup west;

// Optionally, if you'd like to add a crew member:
_driver = _group createUnit ["B_soldier_F", _driverRespawnPos, [], 0, "NONE"]; 

_group setBehaviourStrong "CARELESS";

_driver assignAsDriver _vehicle;
_driver moveInDriver _vehicle;

sleep 3;

natoVehicleSpawnShed animate ["door_1_rot", 1];
natoVehicleSpawnShed animate ["door_2_rot", 1];

sleep 2;

_wp1 = _group addWaypoint [getPosATL natoVehicleRespawnWaypoint1Flag, 0];
_wp1 setWaypointType "GETOUT";

_wp2 = _group addWaypoint [getPos natoVehicleDriverExitPoint1, 0];
_wp2 setWaypointType "MOVE";
_wp2 setWaypointSpeed "FULL";

_wp3 = _group addWaypoint [getPos natoVehicleDriverExitPoint2, 0];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointSpeed "FULL";

waitUntil {
	sleep 0.1;
	vehicle _driver == _driver
};

natoVehicleSpawnShed animate ["door_1_rot", 0];
natoVehicleSpawnShed animate ["door_2_rot", 0];

_vehicle setDamage 0;

waitUntil { 
	sleep 0.1;
	!(alive _driver) || (_driver distance getPos natoVehicleDriverExitPoint2 < 5) 
};

sleep 2;

deleteVehicle _driver;

_vehicle;
