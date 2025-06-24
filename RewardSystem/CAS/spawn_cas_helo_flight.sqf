[] spawn {
	sleep 12;
	playSound "BOOG_HELO_CHECKIN";
};

_startPoint1Pos = getMarkerPos "casSupportSpawnPoint1";
_startPoint2Pos = getMarkerPos "casSupportSpawnPoint2";
_startPoint3Pos = getMarkerPos "casSupportSpawnPoint3";

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
_egressPos = [_egressPos select 0, _egressPos select 1, 200];

_startPoints = [
	[_startPoint1Pos select 0, _startPoint1Pos select 1, 600],
	[_startPoint2Pos select 0, _startPoint2Pos select 1, 600],
	[_startPoint3Pos select 0, _startPoint3Pos select 1, 600]	
];

_randomStartPos = _startPoints call BIS_fnc_selectRandom; 
_randomStartPos = AGLToASL _randomStartPos;

_plane = createVehicle ["B_Heli_Attack_01_dynamicLoadout_F", _randomStartPos, [], 0, "FLY"]; 
_plane setVehicleAmmo 1; 

//TODO: DeleteEventHandler
_eventIndex = _plane addEventHandler["Fired", {
    params ["_vehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner", "_turret"];

    if (_weapon == "missiles_DAGR") then {
		playSound "BOOG_HELO_RIFLE";
    };
}];

_group = group _plane;

createVehicleCrew _plane;
_crew = crew _plane;

driver _plane setSkill 1;

_group setCombatMode "RED";

driver _plane doMove _loiterPos;

_markerName = groupId (group _plane);
_marker = createMarker [_markerName, _loiterPos];
_marker setMarkerShape "ICON";
_marker setMarkerType "b_plane";
_marker setMarkerColor "colorBLUFOR";
_marker setMarkerText "CAS Strike";

private _startTime = time;
private _timeout = 240;  // Timeout in seconds
private _planeDied = false;
private _timedOut = false;
private _conditionsMet = false;

playSound "BOOG_CASInbound";

diag_log "*** spawn_cas_helo_flight - waiting to arrive at loiter...";

// Wait for plane to reach loiter point...
waitUntil { 
    sleep 1;
    _conditionsMet = (_plane distance2D _loiterPos < 1500);
    _timedOut = (((time - _startTime) > _timeout));
    _planeDied = !alive _plane;

	(_conditionsMet || _timedOut || _planeDied);
 };

// Wait for plane to leave loiter point...

diag_log "*** spawn_cas_helo_flight - loitering...";

_startTime = time;
_timeout = 60;  // Timeout in seconds

waitUntil { 
    sleep 5;
    _timedOut = (((time - _startTime) > _timeout));
    _planeDied = !alive _plane;

	(_timedOut || _planeDied);
 };

// End of loiter

diag_log "*** spawn_cas_helo_flight - End loiter.";

if (alive _plane ) then {
	playSound "BOOG_HELO_BINGO_RTB";
};


_plane setVehicleAmmo 0;

// Ensure the AI doesn't register enemies
_group reveal [[], 0];
_group setCombatMode "BLUE";
_group setBehaviourStrong "CARELESS";
_group setCombatBehaviour "CARELESS";
_group enableAttack false;  // Disables the ability to engage in combat

sleep 1;

driver _plane doMove _egressPos;

deleteMarker _markerName;

diag_log "*** spawn_cas_helo_flight - Waiting for egress.";

if (alive _plane) then {
	sleep 120;
};

diag_log "*** spawn_cas_helo_flight - deleting crew and plane.";

{
	deleteVehicle _x;
} forEach _crew;


deleteVehicle _plane;



