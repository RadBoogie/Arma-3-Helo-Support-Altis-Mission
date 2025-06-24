/* We store the current score in a global "rewardScore"
periodically we see if there has been any change to the BIS reward system in the 
global variable BIS_requester_completedRequestsSession. If so we add the BIS score
to our global score. When rewardScore reaches the threshold we deduct the points and 
issue the reward. 

Being global means we can add points to rewardScore from anywhere...
*/

publicVariable "rewardScore";

/*
 Global Variable BIS_requester_completedRequestsSession is array of completed tasks."

	#define INDEX_COMPLETED_REQUESTS_TRANSPORT	0
	#define INDEX_COMPLETED_REQUESTS_MEDEVAC	1
	#define INDEX_COMPLETED_REQUESTS_RESUPPLY	2
	#define INDEX_COMPLETED_REQUESTS_CAS		3
 */

#define POINTS_REWARD_THRESHOLD	300

rewardScore = 0;
_previousBisScore = 0;

/////////////////////////////////////
//*** FUNCTION _getBisScoreDelta ***/
/////////////////////////////////////
_getBisScoreDelta = {
	// BIS Transport tasks are fairly mundane so only qualify for a quarter of the others, 
	// resupply is a one way trip so gets half as much as medevac or CAS.

	//diag_log format ["BIS_requester_completedRequestsSession: %1", BIS_requester_completedRequestsSession];

	_bisScore =  (BIS_requester_completedRequestsSession select 0) +
				((BIS_requester_completedRequestsSession select 1) * 4) +
				((BIS_requester_completedRequestsSession select 2) * 2) +
				((BIS_requester_completedRequestsSession select 3) * 4);

//	diag_log format ["_bisScore: %1, _previousBisScore %2", _bisScore, _previousBisScore];

	_delta = 0;

	if (_bisScore != _previousBisScore) then {
		_delta = _bisScore - _previousBisScore;
		_previousBisScore = _bisScore;
	};	

	_delta * 100;
};

_randomRewardInterval = 900;
_startTime = time;

// Rewards are randomly chosen from array so having more than one instance
// increases the chances of it being chosen.
_rewards = [
	"RewardSystem\award_airdrop.sqf", 
	"RewardSystem\award_airdrop.sqf", 
	"RewardSystem\award_airdrop.sqf", 	
	"RewardSystem\CAS\spawn_cas_flight.sqf",
	"RewardSystem\CAS\spawn_cas_helo_flight.sqf"
];

while {true} do {

	sleep 2;

	// See if player qualifies for an reward...

	// We get the change in rewards points awarded by the BIS code
	_bisScoreDelta = call _getBisScoreDelta;

	rewardScore = rewardScore + _bisScoreDelta;

	_progress = 0;

	if (rewardScore > 0) then {
		_progress = rewardScore / POINTS_REWARD_THRESHOLD; 
		_progress = _progress min 1; 
	};

	((uiNamespace getVariable "BOOG_ScoreHud_Display") displayCtrl 1001) progressSetPosition _progress;

	if (rewardScore >= POINTS_REWARD_THRESHOLD) then {
		// Award reward...

		//TODO: Handle scenario where no groups qualify for airdrop...

		_randomReward = _rewards call BIS_fnc_selectRandom;
		execVm _randomReward;

		rewardScore = rewardScore - POINTS_REWARD_THRESHOLD;

		sleep 5;
	};

	// Every _randomRewardInterval seconds give 50/50 chance of free reward.
	if ((time - _startTime) > _randomRewardInterval) then {
		_startTime = time;

		if ((random 1) > 0.5) then {
			_randomReward = _rewards call BIS_fnc_selectRandom;
			execVm _randomReward;
		};
	};
};





