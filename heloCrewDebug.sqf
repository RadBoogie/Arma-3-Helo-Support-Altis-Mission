_helo = vehicle player;

diag_log "***********************************";
diag_log "HELO EVENTS";

		_helo removeEventHandler ["GetOut", 0];
		//_helo removeEventHandler ["GetOutMan", 1];

		_info = _helo getEventHandlerInfo ["GetIn", 0];	
		diag_log format ["Helo: GetIn Event Info 0: %1",  _info];

		_info = _helo getEventHandlerInfo ["GetInMan", 0];	
		diag_log format ["Helo: GetInMan Event Info 0: %1",  _info];

		_info = _helo getEventHandlerInfo ["GetOut", 0];	
		diag_log format ["Helo: GetOut Event Info 0: %1",  _info];

		_info = _helo getEventHandlerInfo ["GetOutMan", 0];	
		diag_log format ["Helo: GetOutMan Event Info 0: %1",  _info];

		_info = _helo getEventHandlerInfo ["Respawn", 0];	
		diag_log format ["Helo: Respawn Event Info 0: %1",  _info];


diag_log "***********************************";
diag_log "CREW EVENTS";

{

	if (_x != player) then {

		_info = _x getEventHandlerInfo ["Killed", 0];	
		diag_log format ["Crew: %1, Killed Event Info 0: %2", name _x, _info];

		_info = _x getEventHandlerInfo ["Deleted", 0];	
		diag_log format ["Crew: %1, Deleted Event Info 0: %2", name _x, _info];

		_info = _x getEventHandlerInfo ["GetOutMan", 0];	
		diag_log format ["Crew: %1, GetOutMan Event Info 0: %2", name _x, _info];

		_info = _x getEventHandlerInfo ["HandleDamage", 0];	
		diag_log format ["Crew: %1, HandleDamage Event Info 0: %2", name _x, _info];

		_info = _x getEventHandlerInfo ["Respawn", 0];	
		diag_log format ["Crew: %1, Respawn Event Info 0: %2", name _x, _info];


		[_x] allowGetIn false;

//		unassignVehicle _x;

		moveOut _x;

		deleteVehicle _x;

//		_x leaveVehicle _helo;

//		[_x] allowGetIn false;




		diag_log "****";
	};

} forEach crew _helo;






diag_log "***********************************";