params ["_configPath", "_loadoutTarget"];

{_loadoutTarget addItemToBackpack _x;} forEach getArray (_configPath);
