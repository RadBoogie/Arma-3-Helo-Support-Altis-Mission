// Extract the thing that landed
params ["_triggeredList", "_trigger"];

private _repairman = helo_pad_1_mechanic;
private _refuelman = helo_pad_1_mechanic_2;

diag_log format ["Helo trigger landing pad"];

// Iterate through the list
{
	diag_log format ["Helo trigger landing pad - Helo: %1", typeOf _x];

	// Verify it's not null and is actually a helicopter
	if (!isNull _x && _x isKindOf "Helicopter" && alive _x) then {

		_trigger enableSimulation false;

    	_helo = _x;

		diag_log "Helo trigger landing pad";

		sleep 3; // Time for helo to settle on ground

		heloDisableTakeoff = true;

		[_helo] execVM "Helicopters\prevent_takeoff.sqf";


		_rewardScore = 0;
		if (damage _helo >= 0.75 || fuel _helo <= 0.75) then {
			// Repairing damage or refuelling wins reward. Don't know how to get ammo levels for turrets yet.
			_rewardScore = 50;
		};

		cutText ["REPAIRING", "PLAIN"];

		// Move the NPC to the vehicle
		_repairman doMove (getPos helo_pad_1_mechanic_work);

		_refuelman doMove (getPos helo_pad_1_mechanic2_work);

		sleep 2;

		playSound "BOOG_Repair";

		sleep 3;

		 _repairman playMove "AmovPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_Putdown"; 

		sleep 3;

 		_refuelman playMove "AmovPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_Putdown"; 

		_helo setDamage 0;

		_repairman doMove (getPos helo_pad_1_mechanic_home);

		sleep 2;

		cutText ["REFUELLING", "PLAIN"];

		playSound "BOOG_Refuel";

		_initialFuelState = fuel _helo;
		for [{_i = _initialFuelState}, {_i < 1}, {_i = _i + 0.01}] do {
			_helo setFuel _i;
			sleep 0.05;
		};

		_helo setFuel 1;
		
		_refuelman doMove (getPos helo_pad_1_mechanic2_home);

		cutText ["REARMING", "PLAIN"];

		playSound "BOOG_Rearm";

		_initialAmmoState = 0;		
		for [{_i = _initialAmmoState}, {_i < 1}, {_i = _i + 0.01}] do {
			_helo setVehicleAmmo _i;
			sleep 0.05;
		};

		_helo setVehicleAmmo 1;

		sleep 2;

		_repairman doWatch player;
		_refuelman doWatch player;
		
		sleep 1;

		cutText ["GOOD TO GO", "PLAIN"]; //TODO: Maybe build this into one HUD?

		sleep 2;

		cutRsc ["BOOG_ScoreHud", "PLAIN"];

		rewardScore = rewardScore + _rewardScore;

		_repairman playMove "AmovPercMstpSnonWnonDnon_Salute"; 

		heloDisableTakeoff = false;

		[_repairman, _trigger] spawn {
			params ["_repairman", "_trigger"];

			sleep 3;
			_repairman playMove "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground"; 			

			sleep 2;

			_trigger enableSimulation true;			
		};

	};

} forEach _triggeredList;