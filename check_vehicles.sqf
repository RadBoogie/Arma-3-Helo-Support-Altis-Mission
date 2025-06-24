while {true} do {
		 diag_log "*** VEHICLE LIST ***";

	{	
	    diag_log format ["Vehicle: %1, Type: %2, damage: %3, can move: %4", _x, typeOf _x, damage _x, canMove _x];
	} forEach vehicles;

	sleep(5);
}

