// Engineer noises

execVM "HeloPad\Repair\repair_boss_chatter.sqf";
execVM "HeloPad\Repair\mechanic_chatter.sqf";

diag_log "Starting sparks and smoke";
[helo_sparks_origin modelToWorld [0, 0, 0]] execVM "HeloPad\Repair\helicopter_sparks.sqf";
[helo_smoke_origin modelToWorld [0, 0, 0]] execVM "HeloPad\Repair\mild_smoke_particles.sqf";

