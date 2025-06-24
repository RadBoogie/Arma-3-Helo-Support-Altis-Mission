// Extract the thing that landed
params ["_triggeredList", "_trigger"];

diag_log "HeloPad\Medical\helo_medical_pad.sqf";

/*
	Pilot 		- Turret -1
	Co-Pilot	- Turret  0
	Gunner 1	- Turret  1
	Gunner 2	- Turret  2
 */

_rewardScore = 0;
_anyDeadCrew = false;

// Iterate through the list
{
	// Verify it's not null and is actually a helicopter
	if (!isNull _x && _x isKindOf "Helicopter" && alive _x) then {
    	_helo = _x;

		_trigger enableSimulation false;

		cutText ["HEALING", "PLAIN"];

		sleep 2; // Time for helo to settle on ground

		heloDisableTakeoff = true;

		[_helo] execVM "Helicopters\prevent_takeoff.sqf";

		playSound "BOOG_Heal";

		_helo removeEventHandler ["GetOut", 0];

		_helo lock false;

		// Delete dead crew
		{
			if (!alive _x) then {
				_anyDeadCrew = true;

				[_x] allowGetIn false;
				moveOut _x;
				deleteVehicle _x;
			} else {
				_x setDamage 0;
			};
		} forEach crew _helo;


		if (isNull (_helo turretUnit [0])) then {
			_helo lockTurret [[0], false]; 
			[_helo, reserveHeloCommander, 0, false] execVM "HeloPad\Medical\helo_medical_recruit_gunner.sqf";
		};

		if (isNull (_helo turretUnit [1])) then {
			_helo lockTurret [[1], false]; 
			[_helo, reserveHeloCrew1, 1, true] execVM "HeloPad\Medical\helo_medical_recruit_gunner.sqf";	
		};

		if (isNull (_helo turretUnit [2])) then {
			_helo lockTurret [[2], false]; 
			[_helo, reserveHeloCrew2, 2, true] execVM "HeloPad\Medical\helo_medical_recruit_gunner.sqf";	
		};


		/*{
			if (!alive _x || damage _x > 0.25) then 
			{
				_rewardScore = 50;
			};

			if (!alive _x) then {
				diag_log format ["   Dead crew vars: %1", allVariables _x];

				//TODO: What if dead passenger???
				_anyDeadCrew = true;

				_turret = (_helo unitTurret _x) select 0;

				_helo lockTurret [[_turret], false]; 

				_tempGroup = createGroup west;
				[_x] joinSilent _tempGroup;

				sleep 0.5;

				_x setPos [0,0,0]; // Have to force out dead players...
				[_helo, _x] call bis_fnc_deleteVehicleCrew;

				_startTime = time;
				_timeOut = 35;
				// We seem to have to loop here to get the NPCs to get deleted!
				// Timeout as this got stuck once...
				while {!isNull _x || (time < _startTime + _timeOut)  } do {					
					sleep 0.2; // Wait for 1 second before checking again
					_x setPos [0,0,0];
					[_helo, _x] call bis_fnc_deleteVehicleCrew;
				};

				if (time >= _startTime + _timeOut) then {
					diag_log "ERROR: Timed out waiting for dead helo crew to be removed!";
					diag_log format ["   Stuck crew vars: %1", allVariables _x];
				} else {
					if (_turret == 0) then {
						[_helo, reserveHeloCommander, _turret, false] execVM "HeloPad\Medical\helo_medical_recruit_gunner.sqf";	
					};

					if (_turret == 1) then {
						[_helo, reserveHeloCrew1, _turret, true] execVM "HeloPad\Medical\helo_medical_recruit_gunner.sqf";	
					};

					if (_turret == 2) then {
						[_helo, reserveHeloCrew2, _turret, true] execVM "HeloPad\Medical\helo_medical_recruit_gunner.sqf";	
					};
				};

			} else {
				_x setDamage 0;
			}
		} forEach crew _helo; */

	};

} forEach _triggeredList;

if (!_anyDeadCrew) then {
	// If none dead we wait 5 seconds to allow for healing time...
	// If we had dead crew then the player had to wait for replacements
	// to get in.
	sleep 5;
};

_startTime = time;
_timeOut = 15;
_helo = vehicle player;

while {
	((isNull (_helo turretUnit [0])) || 
	(isNull (_helo turretUnit [1])) || 
	(isNull (_helo turretUnit [2]))) &&
	(time < _startTime + _timeOut)} do {
		sleep 0.5;
};

cutText ["GOOD TO GO", "PLAIN"]; //TODO: Maybe build this into one HUD?

sleep 2;

heloDisableTakeoff = false;

rewardScore = rewardScore + _rewardScore;

cutRsc ["BOOG_ScoreHud", "PLAIN"];

[_trigger] spawn {
	// Wait 5 seconds before re-enabling the trigger...
	params ["_trigger"];
	sleep 5;
	_trigger enableSimulation true;
};