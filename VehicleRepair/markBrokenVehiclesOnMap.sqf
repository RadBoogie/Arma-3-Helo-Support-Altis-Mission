while {true} do {

	_index = 0;
	_markers = [];

	{
		_crew = crew _x;

		if (
			speed _x <= 0.01 && 
			(count _crew == 0) && 
			(_x isKindOf "Car" || _x isKindOf "Tank") &&
			(_x distance2D west_base > 500) &&
			(_x distance2D east_base > 500) &&
			alive _x) then 
		{
			// Stopped vehicle with no crew...

			//diag_log format["Found vehicle %1",  getPos _x];

			_markerName = format["emptyVehicleMarker%1", _index];
			_marker = createMarker [_markerName, getPos _x];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "c_car";
			_marker setMarkerColor "ColorYellow";
			//_marker setMarkerText "Empty Vehicle";

			_markers pushBack _markerName;

			_index = _index + 1;
		};

	} forEach vehicles;

	sleep 15;

	{
		deleteMarker _x;
	} forEach _markers;
};



