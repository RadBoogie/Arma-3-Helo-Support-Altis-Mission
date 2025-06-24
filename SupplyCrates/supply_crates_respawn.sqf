// Get the player's position
_position = getPos player;

// Find all supply crates within a 10,000m radius (or adjust as needed)
_crates = nearestObjects [_position, ["B_supplyCrate_F"], 10000];

_crates apply {_x setVariable ["index", _crates find _x]};

_cratePositions = _crates apply {
	[_crates find _x, getPos _x];
};

diag_log format ["Crate Positions: %1", _cratePositions];


while {true} do {
	{
		_isTouchingGround = (getPos _x) select 2 < 0.5; // Threshold of 0.5m

		if (!_isTouchingGround) then {
			// Crate has been lifted...

			sleep 10; // Time for helo to get clear...

			_crateIndex = _x getVariable "index";
			_x setVariable ["index", nil];

			_liftedCrateData = _cratePositions select (_cratePositions findIf {(_x select 0) == _crateIndex});

			_newCrate = "B_supplyCrate_F" createVehicle (_liftedCrateData select 1); 
			_newCrate setVariable ["index", _crateIndex];

			_crates set [_crateIndex, _newCrate];
		}
	} forEach _crates;

	sleep 2;
};

