/*
null = [] call compile preprocessFileLineNumbers "init_respawnWave.sqf";
NSA_hp_init_respawnWave = compile preprocessFileLineNumbers "init_respawnWave.sqf";
[] call NSA_hp_init_respawnWave;

	Зачищаются валяющиеся на земле предметы.
	
	Ящики/машины с оборудованием на базах возвращаются на исходные позции (если целы. Если уничтожены - спавнятся заново).
*/

if !(isServer) exitWith {};

private ["_respawnWave","_resSide","_resSideInt"];

_resSide = _this select 1;
_resSideInt = [east,west,resistance] find _resSide;
// _resSide = if (count _this >= 2) then { _this select 1 } else { [east,west,resistance,civilian,sideLogic] };


// Если боец в бессознанке - респавнить
{
	if ((isPlayer _x) && (_x getVariable ["ACE_isUnconscious",false]) && (side group _x == _resSide)) then {
		_x setDamage 1;
		NSA_hp_forceRespawn = true;
		(owner _x) publicVariableClient "NSA_hp_forceRespawn";
		NSA_hp_forceRespawn = nil;
	};
} forEach PlayableUnits;


_respawnWave = _this select 0;
_waveNum = ((NSA_hp_RespawnWave select _resSideInt) select 0) + 1;

["hp_respWaveTime_" + str _resSide, "create", _respawnWave] call NSA_Timer;
NSA_hp_RespawnWave set [_resSideInt, [_waveNum, _respawnWave]];
publicVariable "NSA_hp_RespawnWave";
