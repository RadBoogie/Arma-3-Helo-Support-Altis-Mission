//TODO: Handle scenario where we award a drop but no candidates are present...

_small_friendly_squads = [];

diag_log "*** AWARD AIRDOP ***";

{
	if (side _x == west) then {  // Check if the group belongs to the WEST side
		_units = units _x;  // Get all units in the group
		_isInfantryGroup = true;

		{
			// Check if the unit is not infantry
			if (!(_x isKindOf "CAManBase")) then {  // Check if the unit is not infantry
				_isInfantryGroup = false;
			};

			// Check if the unit is in a vehicle
			if (_x != vehicle _x) then {
				_isInfantryGroup = false;
			};

			if (!_isInfantryGroup) exitWith {};  // Exit the loop if condition is not met
		} forEach _units;

		if (_isInfantryGroup) then {
			_not_ai_spawned = _x getVariable "not_ai_spawned";

			if (
					(count _units > 1) && 
					(count _units < 6) && 
					(isNil "_not_ai_spawned") 
				) then {
					_small_friendly_squads pushBack _x;

					diag_log format ["   Small Group name: %1", groupId _x];				
			};
		};
	};

} forEach allGroups;

// Select a group to receive a vehicle...
_candidateGroupCount = count _small_friendly_squads;

if (_candidateGroupCount == 0) exitWith {
	diag_log "   No groups qualify for airdrop."
};

// TODO: Need to select another group from list if receipient is already getting airdrop...

_receipientGroup = _small_friendly_squads select (random _candidateGroupCount - 1);

_airdrop_in_progress = _receipientGroup getVariable ["airdrop_in_progress", false];

if (_airdrop_in_progress) exitWith {
	diag_log "   Recipient group is already receiving an airdrop."
};

diag_log format ["   Recipient group is: %1", groupId _receipientGroup];

[_receipientGroup] execVM "RewardSystem\airdrop_vehicle_to_group.sqf";