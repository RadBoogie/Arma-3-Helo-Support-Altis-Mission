// Find the intro ground attack jets and make sure they get deleted when destroyed
{
	if (typeOf _x == "O_Plane_CAS_02_dynamicLoadout_F") then {

		if (isNil {_x getVariable "handleDamageEventIndex"}) then {

			_index = _x addEventHandler ["HandleDamage", {
				params ["_vehicle", "_selection", "_damage", "_source", "_projectile", "_hitPartIndex"];

				if (_damage >= 1) then {

					[_vehicle] spawn {
						params["_vehicle"];

						_index = _vehicle getVariable "handleDamageEventIndex";
						_vehicle removeEventHandler ["HandleDamage", _index];

						sleep 300; // Delete vehicle 5 minutes after it gets destroyed
						deleteVehicle _vehicle;
						diag_log "XXXXXXX DELETED CAS JET XXXXXXX";					
					};
				};
			}];

			_x setVariable ["handleDamageEventIndex", _index];
		};
	};
} forEach vehicles;

