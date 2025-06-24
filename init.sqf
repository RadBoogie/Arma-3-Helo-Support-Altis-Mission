// Functions...
BOOG_fnc_airdrop_vehicle = compile preprocessFile "RewardSystem\airdrop_vehicle.sqf";
BOOG_fnc_spawn_reserve_helo_crew = compile preprocessFile "HeloPad\Medical\spawn_reserve_crew_member.sqf";
BOOG_fnc_spawn_nato_prowler = compile preprocessFile "VehicleRespawn\nato_vehicle_respawn.sqf";

publicVariable "heloDisableTakeoff";
publicVariable "previousPlayer";
publicVariable "previousPlayers";

previousPlayer = player;
previousPlayers = [];

playerIndex = 0;


execVM "Player\init_player.sqf";

execVM "initialise_eden_placed_units.sqf";

execVM "HeloPad\Repair\helo_repair_ambience.sqf";

execVM "HeloPad\Medical\helo_crew_spawn_manager.sqf";

execVM "VehicleRespawn\nato_vehicle_respawn_manager.sqf";

execVM "RewardSystem\reward_system.sqf";

execVM "EnemyAI\attach_enemy_ai_event_handler.sqf";

execVM "SupplyCrates\supply_crates_respawn.sqf";

execVM "EnemyAI\enemy_ground_attack_planes.sqf";

execVM "VehicleRepair\markBrokenVehiclesOnMap.sqf";

execVM "Player\createDiary.sqf";


[] spawn {
	sleep 2;
	playMusic "";
	player removeDiarySubject "BIS_fnc_moduleMPTypeGroundSupport";
};



cutRsc ["BOOG_ScoreHud", "PLAIN"];