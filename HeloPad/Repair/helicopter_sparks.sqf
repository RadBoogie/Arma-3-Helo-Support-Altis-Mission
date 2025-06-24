_position = (_this select 0);

// Emit sparks every few seconds...
while {true} do {
	_random = random [5, 12, 20];
	sleep _random;

	playSound3D ["a3\missions_f_epa\data\sounds\electricity_loop.wss", player, false, _position, 2, 1, 0, 4];

	[_position] execVM "HeloPad\Repair\sparks_particles.sqf";
};




