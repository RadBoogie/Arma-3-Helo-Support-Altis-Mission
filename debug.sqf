{

		diag_log format ["Name: %1, Side: %2, IsAlive: %3, IsVisible: %4", name _x, side _x, alive _x , isObjectHidden _x];

		_marker = createMarker [name _x, getPos _x]; // The coordinates
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_objective";
		_marker setMarkerColor "ColorRed";
		_marker setMarkerText name _x;
	
} forEach allUnits;