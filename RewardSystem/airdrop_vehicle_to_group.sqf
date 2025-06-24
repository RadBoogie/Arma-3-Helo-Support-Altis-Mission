params ["_group"];

_group setVariable ["airdrop_in_progress", true];

[] spawn {
	playSound "BOOG_ArmouredSupportInbound";

	sleep 5;

	playSound "BOOG_GroundStaffDeployGreenSmoke";
};

// Get group current waypoint
_originalWaypointIndex = currentWaypoint _group;
_originalWaypoint = waypoints _group select _originalWaypointIndex;

diag_log "   Stopping group";

_leader = leader _group;

_marker = createMarker [groupId _group, getPos _leader]; 
_marker setMarkerShape "ICON";
_marker setMarkerType "b_support";
_marker setMarkerColor "colorBLUFOR";
_marker setMarkerText "Vehicle Airdrop";

// Order group to halt

// Count how many waypoints the group has
_numWaypoints = count waypoints _group;

// Delete each waypoint, starting from the last one and moving backwards
{ deleteWaypoint _x } forEachReversed waypoints _group;

// We get the squad to halt by wetting a move waypoint on its leader position.
_waypointVehicle = _group addWaypoint [getPos _leader, 0];
_waypointVehicle setWaypointType "MOVE";

// Request Vehicle Drop
diag_log "   Doing airdrop...";

_vehicle = [getPos _leader] call BOOG_fnc_airdrop_vehicle;

if (isNil "_vehicle") exitWith {
	// No vehicle dropped - resume waypoint...
	diag_log "   Vehicle not spawned, resuming group.";

	deleteMarker groupId _group;

	{ deleteWaypoint _x } forEachReversed waypoints _group;

	sleep 1;

	if (!isNil "_originalWaypoint") then {
		_waypointPosition = waypointPosition  _originalWaypoint;
		_waypoint = _group addWaypoint [_waypointPosition, 0];
		_waypoint setWaypointType "MOVE";
	};
	_group setVariable ["airdrop_in_progress", false];
};


waitUntil { 
	sleep 0.1;
	((getPosATL _vehicle) select 2) < 1;
};

detach _vehicle;
_vehicle SetVelocity [0,0,-5];           
sleep 0.3;
_vehicle setPos [(position _vehicle) select 0, (position _vehicle) select 1, 0.5];
_vehicle SetVelocity [0,0,0]; 
_vehicle setDamage 0;

// Resume waypoint...
diag_log "   Resuming group";

deleteMarker groupId _group;

{ deleteWaypoint _x } forEachReversed waypoints _group;

sleep 1;

if (!isNil "_originalWaypoint") then {
	_waypointPosition = waypointPosition _originalWaypoint;
	_waypoint = _group addWaypoint [_waypointPosition, 0];
	_waypoint setWaypointType "MOVE";	
};

_group setVariable ["airdrop_in_progress", false];