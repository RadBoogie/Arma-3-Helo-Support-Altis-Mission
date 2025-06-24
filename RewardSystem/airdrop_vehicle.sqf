
// _drop_point_pos = _this select 0;
params["_drop_point_pos"];

"SmokeShellGreen" createVehicle _drop_point_pos;

_drop_point_pos = [_drop_point_pos select 0, _drop_point_pos select 1, 100];

_start_point_pos = [(_drop_point_pos select 0) + 3500, _drop_point_pos select 1, _drop_point_pos select 2];
_end_point_pos = [(_drop_point_pos select 0) - 3500, _drop_point_pos select 1, _drop_point_pos select 2];

_plane = createVehicle ["B_T_VTOL_01_vehicle_F", _start_point_pos, [], 0, "FLY"]; 

_plane setVehicleAmmo 1; 

createVehicleCrew _plane;

// Assume object1 and object2 are your two objects
_direction1 = getDir _plane; // Get the orientation of object1

// Calculate direction from object1 to object2
_directionToTarget = [_start_point_pos, _drop_point_pos] call BIS_fnc_dirTo;

// Calculate relative direction
_relativeDirection = _directionToTarget - _direction1;

// Normalize the relative direction to between 0 and 360
if (_relativeDirection < 0) then {
    _relativeDirection = _relativeDirection + 360;
};
if (_relativeDirection >= 360) then {
    _relativeDirection = _relativeDirection - 360;
};

_plane setDir _relativeDirection;

// Create a waypoint at the target location
//_waypoint1 = group _plane addWaypoint [_start_point_pos, 0];
_waypoint1 setWaypointType "MOVE";
_waypoint1 setWaypointSpeed "NORMAL";
_waypoint1 setWaypointBehaviour "SAFE";

_waypoint2 = group _plane addWaypoint [_drop_point_pos, 0];
_waypoint2 setWaypointType "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "CARELESS"; // Set careless otherwise plane will react to threats and not follow waypoints...

_waypoint3 = group _plane addWaypoint [_end_point_pos, 0];
_waypoint3 setWaypointType "MOVE";
_waypoint3 setWaypointSpeed "FULL";
_waypoint3 setWaypointBehaviour "CARELESS";


// Handle plane doesn't make it this far!
private _startTime = time;
private _timeout = 90;  // Timeout in seconds
private _planeDied = false;
private _timedOut = false;
private _conditionsMet = false;

waitUntil { 
    sleep 0.1;
    _conditionsMet = (_plane distance2D _drop_point_pos < 10);
    _timedOut = (((time - _startTime) > _timeout));
    _planeDied = !alive _plane;

	(_conditionsMet || _timedOut || _planeDied)
 };

// Something stopped the plane getting to the drop point
if (!_conditionsMet) exitWith { 
    if (_timedOut) then {
        diag_log "   Timed out waiting for plane to get to drop point..";
    };
    
    if (_planeDied) then {
        diag_log "   Plane died before getting to drop point..";
    };

    {
        deleteVehicle _x;
    } forEach crew _plane;

    deleteVehicle _plane;

    nil     
};

_plane animateDoor ["Door_1_source", 1]; 
 
_vehicle = createVehicle ["B_LSV_01_armed_F", _start_point_pos, [], 0, "NONE"]; 

_vehicle setPos [(getPos _plane select 0) + 22, getPos _plane select 1, getPos _plane select 2]; 
 
_chute = createVehicle ["B_Parachute_02_F", getPos _vehicle, [], 0, "NONE"]; 

_vehicle attachTo [_chute, [0,0,0]]; 

[_plane, _end_point_pos] spawn{
    params["_plane", "_end_point_pos"];

    playSound "BOOG_PackageDelivered";    

    [_plane] spawn {
        params["_plane"];

        for "_j" from 1 to 5 do {       
            // Fire 5 sets of flares, with a 0.5-second delay between each
            for "_i" from 1 to 5 do {
                [_plane, "CMFlareLauncher_Triples"] call BIS_fnc_fire; // fires chaff
                sleep 0.1;
            };

            sleep 0.5;
        };
    };

    sleep 2;

    _plane animateDoor ["Door_1_source", 0]; 

    sleep 2;

    playSound "BOOG_CopyNovemberRTB";

    // Handle plane doesn't make it this far!
    private _startTime = time;
    private _timeout = 90;  // Timeout in seconds
    private _planeDied = false;
    private _timedOut = false;
    private _conditionsMet = false;    

    waitUntil { 
        sleep 0.1;
        _conditionsMet = (_plane distance2D _end_point_pos < 50);
        _timedOut = (((time - _startTime) > _timeout));
        _planeDied = !alive _plane;

        (_conditionsMet || _timedOut || _planeDied)
    };

    {
        deleteVehicle _x;
    } forEach crew _plane;

    deleteVehicle _plane;
};

// This is a function so as soon as we have the vehicle created, we return it...
_vehicle