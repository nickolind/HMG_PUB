
private ["_justConnected","_respawnMark"];

_justConnected = false;
if (isNil {NSA_hp_PlayerConnected}) then {
	_justConnected = true;
	NSA_hp_PlayerConnected = true;
	// titleCut ["", "BLACK OUT", 0];
	cutText ["","BLACK OUT",0];
	waitUntil { sleep 0.14; (player getVariable ["NSA_plrInitDone", false]) };
	titleCut ["", "BLACK IN", 4];
};

_respawnMark = (NSA_hp_RespawnWave select 0);
setPlayerRespawnTime 9999;

if !(_justConnected) then {
	[_this select 1] spawn {
		[format["<t color='#FFA500' size = '1.0'>Убийца: %1</t>",name (_this select 0)],0,-0.1,5,0.7,0,709] call bis_fnc_dynamictext;
	};
};

[_justConnected, _respawnMark] spawn {
		
		// _justConnected
	if !(_this select 0) then {
		BIS_fnc_feedback_allowPP = false;

		// Disable all PP effect
		"radialBlur" ppEffectEnable false;
		"DynamicBlur" ppEffectEnable false;
		"dynamicBlur" ppEffectEnable false;
		"filmGrain" ppEffectEnable false; 
		"chromAberration" ppEffectEnable false;

		// Hide map
		forceMap false;

		cutText ["","BLACK OUT",0];
	
		sleep 10;
		titleCut ["", "BLACK IN", 0]; 

	};

	if !(alive player) then {
		["Initialize", [player, [side group player], true, false]] call BIS_fnc_EGSpectator;
	};

		// _respawnMark
	[(_this select 1)] spawn {
		while {(!alive player) } do {
						// titleText [ format ["Следующая волна подкреплений через: %1", [playerRespawnTime,"MM:SS"] call BIS_fnc_secondsToString], "PLAIN DOWN"];
			
				// _respawnMark
			if (
				((_this select 0) != (NSA_hp_RespawnWave select 0) && ((NSA_hp_RespawnWave select 0) != 0)) 
				||
				// (NSA_hp_GameStarted > 0)
				// ||
				(missionNamespace getVariable ["NSA_hp_forceRespawn", false])
			
			) exitWith {
				setPlayerRespawnTime 0;
				NSA_hp_forceRespawn = nil;

			};

			if (abs((NSA_hp_RespawnWave select 1) - playerRespawnTime) > 5) then {setPlayerRespawnTime (NSA_hp_RespawnWave select 1); };
			if (NSA_hp_RespawnWave select 0 <= 0) then {
				hint format ["Игра начнется через: %1", [0 max playerRespawnTime,"MM:SS"] call BIS_fnc_secondsToString];
			} else { hint format ["Следующая волна подкреплений через: %1", [0 max playerRespawnTime,"MM:SS"] call BIS_fnc_secondsToString]; };
			
			sleep 0.2;
		};
		hint "";
	};
	
	
};
