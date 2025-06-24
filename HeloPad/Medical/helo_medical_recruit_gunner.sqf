params ["_helo", "_crew", "_turret", "_isGunner"];

diag_log "HeloPad\Medical\helo_medical_recruit_gunner.sqf";

// Recruit new gunner

_crew call BIS_fnc_ambientAnim__terminate;

sleep  2 + (random 3);

// TODO: deleteVehicle reserveGunner1Headgear;
_crew addHeadgear "H_CrewHelmetHeli_B";

// We get the crew emmber to get in the back of the helo and later zap
// them instantly into the gunner position. If we assignAsGunner here
// and there is already a gunner in position 1, the crew emmber will just 
// run off and not get in the helo.
_crew assignAsCargo _helo;

[_crew] orderGetIn true;

waitUntil {
	sleep 0.1;
	_crew in _helo
};

_helo lockTurret [[_turret], false]; 

if (_isGunner) then {
	_crew assignAsGunner _helo;
} else {
	_crew assignAsCommander _helo;
};

// Have to moveOut of vehicle before moveInTurret will work.
// moveInTurret is instant so the crew emmber won't visibly leave the vehicle.
moveOut _crew;

// This moves unit directly to door gun with no animation			
_crew moveInTurret [_helo, [_turret]]; 

_group = group player; 
[_crew] joinSilent _group;

// We use behaviour careless while the crew member is boarding to prevent distraction.
_crew setBehaviour "AWARE";


