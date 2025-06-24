
// Pilot chatter
// a3\dubbing_f_bootcamp\boot_m01\d10_fun\boot_m01_d10_fun_lac_0.ogg
// a3\dubbing_f_bootcamp\boot_m02\x15_long_2_reprimand\boot_m02_x15_long_2_reprimand_ada_0.ogg // empty gas tank
// a3\dubbing_f_bootcamp\boot_m03\05_idiots\boot_m03_05_idiots_ada_0.ogg //  something with these people
// a3\dubbing_f_bootcamp\boot_m03\05_idiots\boot_m03_05_idiots_ada_1.ogg //  Change of plans
// a3\dubbing_f_bootcamp\boot_m03\10_gather\boot_m03_10_gather_ada_1.ogg // Gonna learn something useful
// a3\dubbing_f_bootcamp\boot_m03\20_lesson\boot_m03_20_lesson_ada_0.ogg // Here's the deal
// a3\dubbing_f_bootcamp\boot_m03\20_lesson\boot_m03_20_lesson_ada_1.ogg // Rescue from certain doom
// a3\dubbing_f_bootcamp\boot_m03\35_info\boot_m03_35_info_ada_0.ogg // You guys still there?
// a3\dubbing_f_bootcamp\boot_m03\75_orders\boot_m03_75_orders_ada_1.ogg // Keep yourselves busy while were gone
// a3\dubbing_f_bootcamp\boot_m03\d01_situation\boot_m03_d01_situation_ada_0.ogg // What the hell happened hcRemoveAllGroups
// a3\dubbing_f_bootcamp\boot_m03\d01_situation\boot_m03_d01_situation_ada_4.ogg // You searched all of them?
// a3\dubbing_f_bootcamp\boot_m03\d05_returned\boot_m03_d05_returned_ada_2.ogg // Told these idtios to clean up the mess
// a3\dubbing_f_bootcamp\boot_m04\01_start\boot_m04_01_start_ada_2.ogg // You're kidding me
// a3\dubbing_f_bootcamp\boot_m04\95_check_up\boot_m04_95_check_up_ada_0.ogg // Son can you hear me
// a3\dubbing_f_bootcamp\boot_m05\d10_ending\boot_m05_d10_ending_ada_0.ogg // Orders are orders...
// a3\dubbing_f_bootcamp\boot_m05\d10_ending\boot_m05_d10_ending_ada_1.ogg // Cmon lets get outta here

// diag_log "repair_boss_chatter.sql start";

private _sounds = [
	"a3\dubbing_f_bootcamp\boot_m01\d10_fun\boot_m01_d10_fun_lac_0.ogg", 
	"a3\dubbing_f_bootcamp\boot_m02\x15_long_2_reprimand\boot_m02_x15_long_2_reprimand_ada_0.ogg", 
	"a3\dubbing_f_bootcamp\boot_m03\05_idiots\boot_m03_05_idiots_ada_0.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\05_idiots\boot_m03_05_idiots_ada_1.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\10_gather\boot_m03_10_gather_ada_1.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\20_lesson\boot_m03_20_lesson_ada_0.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\20_lesson\boot_m03_20_lesson_ada_1.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\35_info\boot_m03_35_info_ada_0.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\75_orders\boot_m03_75_orders_ada_1.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\d01_situation\boot_m03_d01_situation_ada_0.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\d01_situation\boot_m03_d01_situation_ada_4.ogg",
	"a3\dubbing_f_bootcamp\boot_m03\d05_returned\boot_m03_d05_returned_ada_2.ogg",
	"a3\dubbing_f_bootcamp\boot_m04\01_start\boot_m04_01_start_ada_2.ogg",
	"a3\dubbing_f_bootcamp\boot_m04\95_check_up\boot_m04_95_check_up_ada_0.ogg",
	"a3\dubbing_f_bootcamp\boot_m05\d10_ending\boot_m05_d10_ending_ada_0.ogg",
	"a3\dubbing_f_bootcamp\boot_m05\d10_ending\boot_m05_d10_ending_ada_1.ogg"
];

_prevSoundIndex = 999; // Prevent playing same sound twice

while {true} do {
	_random = random [8, 15, 22];
	sleep _random;

	_soundIndex = random 15;

	if (_prevSoundIndex != _soundIndex) then {
		playSound3D [
			_sounds select _soundIndex, 
			repair_boss, 
			false, 
			getPosASL repair_boss, 
			1, // Volume
			1, // Pitch
			0, // Distance 0 = unlimited
			0  // Offset
		];	

		_prevSoundIndex = _soundIndex;		
	};
};
