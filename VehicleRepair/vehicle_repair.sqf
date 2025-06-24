params ["_thisList"];

sleep 3;

{
	if ((_x isKindOf "Car" || _x isKindOf "Tank") && isTouchingGround _x && (speed _x < 0.05)) then {
		diag_log format["*** Vehicle Repair Triggered"];

		_vehicle = _x;

		{
			_vehicle deleteVehicleCrew _x;
			diag_log format["   Deleting crew from vehicle..."];
		} forEach crew _vehicle;

		_vehicle setVariable ["bis_unstuckpos", nil];
		_vehicle setVariable ["bis_fnc_modulespawnaisectortactic_ehhit", nil];

		diag_log format["   Vehicle State - Damage: %1, Fuel: %2, Alive: %3, Can Move: %4", 
		damage _vehicle, fuel _vehicle, alive _vehicle, canMove _vehicle];

		if (damage _vehicle < 0.5) then {
			_vehicle setDamage 0.5;
		};

		superVehicleRepairMan assignAsDriver _vehicle;
		[superVehicleRepairMan] orderGetIn true;

		waitUntil {
			sleep 0.1;
			vehicle superVehicleRepairMan != superVehicleRepairMan
		};

		sleep 5;

		_vehicle setDamage 0;

		_vehicle setFuel 1;

		_vehicle setVehicleAmmo 1;

		sleep 1;

		rewardScore = rewardScore + 100;

		// This got stuck once and the driver couldn't reach destination.
		// Now we reset a couple of vehicle vars at the start and 
		// have a timeout waiting for him to reach position.

		superVehicleRepairMan doMove (getPos superVehicleRepairManDropOff);

		_startTime = time;

		waitUntil {
			sleep 0.5;
			((superVehicleRepairMan distance2D superVehicleRepairManDropOff) < 8) || (time > _startTime + 20);
		};

		sleep 1;

		[superVehicleRepairMan] orderGetIn false;

		waitUntil {
			sleep 0.1;
			vehicle superVehicleRepairMan == superVehicleRepairMan
		};

		unassignVehicle superVehicleRepairMan;

		sleep 4;

		superVehicleRepairMan doMove (getPos superVehicleRepairManHome);

		waitUntil {
			sleep 0.1;
			(superVehicleRepairMan distance2D superVehicleRepairManHome) < 3;
		};

		sleep 3;

		superVehicleRepairMan doWatch superVehicleRepairManDropOff;

		sleep 2;

		superVehicleRepairMan playMove "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground"; 

	}
} forEach _thisList;