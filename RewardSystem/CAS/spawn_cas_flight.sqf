[] spawn {
	sleep 12;
	playSound "BOOG_JET_CHECKIN";
};

_startPoint1Pos = getMarkerPos "casSupportSpawnPoint1";
_startPoint2Pos = getMarkerPos "casSupportSpawnPoint1";
_startPoint3Pos = getMarkerPos "casSupportSpawnPoint1";

_loiterPos = getMarkerPos "casSupportLoiterPoint";
_loiterPos = [_loiterPos select 0, _loiterPos select 1, 100];

_enemyVehicles = vehicles select { side _x == east && alive _x }; 
_enemyVehicles = _enemyVehicles apply { [_loiterPos distance _x, _x] };
_enemyVehicles sort true;

if (count _enemyVehicles > 0) then { 
	diag_log "   Got enemy vehicle closest to loiter point...";
 	_loiterPos = getPos ((_enemyVehicles select 0) select 1); 
 	_loiterPos = [_loiterPos select 0, _loiterPos select 1, 100];
};


_egressPos = getMarkerPos "casSupportEgressPoint";
_egressPos = [_egressPos select 0, _egressPos select 1, 800];

_startPoints = [
	[_startPoint1Pos select 0, _startPoint1Pos select 1, 600],
	[_startPoint2Pos select 0, _startPoint2Pos select 1, 600],
	[_startPoint3Pos select 0, _startPoint3Pos select 1, 600]	
];

_randomStartPos = _startPoints call BIS_fnc_selectRandom; 
_randomStartPos = AGLToASL _randomStartPos;

_plane = createVehicle ["B_Plane_CAS_01_dynamicLoadout_F", _randomStartPos, [], 0, "FLY"]; 
_plane setVehicleAmmo 1; 

//TODO: DeleteEventHandler
_eventIndex = _plane addEventHandler["Fired", {
    params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner", "_turret"];

    if (_weapon == "Missile_AGM_02_Plane_CAS_01_F") then {
		playSound "BOOG_JET_RIFLE";
    };
}];

_plane2 = createVehicle [
	"B_Plane_CAS_01_dynamicLoadout_F", 
	[_randomStartPos select 0, (_randomStartPos select 1) - 50, _randomStartPos select 2], 
	[], 0, "FLY"]; 

_plane2 setVehicleAmmo 1; 

_group = group _plane;

createVehicleCrew _plane;
_crew = crew _plane;

 _group createVehicleCrew _plane2;

[_plane, _plane2, driver _plane, driver _plane2] join _group;

_group selectLeader driver _plane;

driver _plane setSkill 1;
driver _plane2 setSkill 1;

_crew2 = crew _plane2;

_group setCombatMode "RED";

driver _plane doMove _loiterPos;
driver _plane2 doMove _loiterPos;

_group setSpeedMode "FULL";

_markerName = groupId (group _plane);
_marker = createMarker [_markerName, _loiterPos];
_marker setMarkerShape "ICON";
_marker setMarkerType "b_plane";
_marker setMarkerColor "colorBLUFOR";
_marker setMarkerText "CAS Strike";


private _startTime = time;
private _timeout = 120;  
private _planeDied = false;
private _timedOut = false;
private _conditionsMet = false;

playSound "BOOG_CASInbound";

diag_log "*** spawn_cas_flight - waiting to arrive at loiter...";

// Wait for plane to reach loiter point...
waitUntil { 
    sleep 1;
    _conditionsMet = (_plane distance2D _loiterPos < 1500);
    _timedOut = (((time - _startTime) > _timeout));
    _planeDied = !alive _plane;

	(_conditionsMet || _timedOut || _planeDied);
 };

// Wait for plane to leave loiter point...

diag_log "*** spawn_cas_flight - loitering...";

_startTime = time;
_timeout = 120;  // Timeout in seconds

waitUntil { 
    sleep 5;
    _timedOut = (((time - _startTime) > _timeout));
    _planeDied = !alive _plane;

	(_timedOut || _planeDied);
 };

// End of loiter

diag_log "*** spawn_cas_flight - End loiter.";

if (alive _plane || alive _plane2 ) then {
	playSound "BOOG_JET_WINCHESTER_RTB";
};

_plane setVehicleAmmo 0;
_plane2 setVehicleAmmo 0;

driver _plane disableAI "AUTOCOMBAT";
driver _plane disableAI "TARGET";
driver _plane disableAI "FSM";
driver _plane disableAI "SUPPRESSION";
driver _plane disableAI "AUTOTARGET";


driver _plane2 disableAI "AUTOCOMBAT";
driver _plane2 disableAI "TARGET";
driver _plane2 disableAI "FSM";
driver _plane2 disableAI "SUPPRESSION";
driver _plane2 disableAI "AUTOTARGET";

// Ensure the AI doesn't register enemies
/*_group enableAttack false;  // Disables the ability to engage in combat
_group reveal [[], 0];
_group setCombatMode "GREEN";
_group setBehaviourStrong "CARELESS";
_group setCombatBehaviour "CARELESS";*/

//sleep 1;

_carelessGroup = createGroup west;
_carelessGroup setCombatMode "BLUE";
_carelessGroup setCombatBehaviour "CARELESS";

[_plane, _plane2, driver _plane, driver _plane2] join _carelessGroup;

_carelessGroup setCombatBehaviour "CARELESS";
_carelessGroup setSpeedMode "FULL";

[_plane, _plane2, _egressPos] spawn {
	params ["_plane", "_plane2", "_egressPos"];
	sleep 2;

	driver _plane doMove _egressPos;
	driver _plane2 doMove _egressPos;

	sleep 2;

	driver _plane doMove _egressPos;
	driver _plane2 doMove _egressPos;

	sleep 2;

	driver _plane doMove _egressPos;
	driver _plane2 doMove _egressPos;

	sleep 2;

	driver _plane doMove _egressPos;
	driver _plane2 doMove _egressPos;

	sleep 2;

	driver _plane doMove _egressPos;
	driver _plane2 doMove _egressPos;
};




deleteMarker _markerName;

if (alive _plane) then {
	sleep 120;
};

diag_log "*** spawn_cas_flight - deleting crew and plane.";

{
	deleteVehicle _x;
} forEach _crew;

{
	deleteVehicle _x;
} forEach _crew2;

deleteVehicle _plane;
deleteVehicle _plane2;


