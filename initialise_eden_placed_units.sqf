/* Tags all units placed in the editor with the not_ai_spawned variable so we know
* they weren't placed by the ground support system. */

{
	// Current result is saved in variable _x
	if (side _x == west) then{
		_x setVariable ["not_ai_spawned", true];
	}

} forEach allGroups;