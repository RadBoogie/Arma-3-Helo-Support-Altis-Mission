while {true} do {

	// diag_log format ["Trigger fired, list contains %1", typeOf _x ];

	_opforUnits = allUnits select {side _x == east}; // EAST corresponds to OPFOR

	{
		if (_x isKindOf "CAManBase") then  {
			if (isNil {_x getVariable "onKilledEventHandlerIndex"}) then {
				_index = _x addEventHandler ["Killed", {
					params ["_victim", "_killer"];
					
					if (_killer == player || (vehicle _killer) == (vehicle player)) then {
						rewardScore = rewardScore + 20;
					};

					diag_log format ["Victim %1 killed by %2", name _victim, name _killer ];

					// Remove the event handler
					_victim removeEventHandler ["Killed", (_victim getVariable "onKilledEventHandlerIndex")];
						
				}];
		
				_x setVariable ["onKilledEventHandlerIndex", _index];

				diag_log format ["Added killed event handler to %1", name _x ];				
			};
		};
	} forEach _opforUnits;

    sleep 10;
};