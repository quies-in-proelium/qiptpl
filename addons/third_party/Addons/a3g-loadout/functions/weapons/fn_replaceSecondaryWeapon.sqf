params ["_configPath", "_loadoutTarget"];

if (getText _configPath == "") then {
	_loadoutTarget removeWeapon (secondaryWeapon _loadoutTarget);
} else {
	_loadoutTarget addWeapon getText _configPath;
};
