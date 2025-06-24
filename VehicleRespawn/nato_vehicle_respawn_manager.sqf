_natoSpawnedProwler = [] call BOOG_fnc_spawn_nato_prowler;

while {true} do {
	sleep 2;

	{
		if (_x isKindOf "Helicopter" && _natoSpawnedProwler == getSlingload _x) then {
			_natoSpawnedProwler = [] call BOOG_fnc_spawn_nato_prowler;
		};
	} foreach vehicles;

};
