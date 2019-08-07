#include "script_component.hpp"

params ['_di'];

private _exit = FALSE;
private _side = [EAST,WEST,RESISTANCE,CIVILIAN];
private _as = [];
private _au = [];
private _isAdmin = (((call (missionNamespace getVariable 'BIS_fnc_admin')) isEqualTo 2) && QS_ST_admin);

if (!(playerSide isEqualTo CIVILIAN)) then {
    if (!(QS_ST_showCivilianIcons)) then {
        _side = [EAST,WEST,RESISTANCE];
    };
};
if ((QS_ST_showAll) > 0) exitWith {
    if ((QS_ST_showAll) isEqualTo 1) then {
        _au = allUnits + vehicles;
    };
    if ((QS_ST_showAll) isEqualTo 2) then {
        _au = entities [[],[],TRUE,TRUE];
    };
    _au;
};
if (((_di isEqualTo 1) && QS_ST_showCivilianIcons) && {(!(QS_ST_showOnlyVehicles))}) then {
    _exit = TRUE;
    _au = units (group player);
    if ((QS_ST_showEmptyVehicles)) then {
        {
            if (!(_x in _au)) then {
                if (_x getVariable ['QS_ST_drawEmptyVehicle',FALSE]) then {
                    if ((crew _x) isEqualTo []) then {
                        _au pushBack _x;
                    };
                };
            };
        } forEach vehicles;
    };
    _au;
};
if ((_di isEqualTo 2) && QS_ST_GPSshowGroupOnly) then {
    _exit = TRUE;
    _au = units (group player);
    _au;
};
if (_exit) exitWith {_au;};
if (QS_ST_showFactionOnly) then {
    _as pushBack (_side select QS_ST_faction);
} else {
    if (isMultiplayer) then {
        if (_isAdmin) then {
            {
                _as pushBack _x;
            } forEach _side;
        } else {
            if (QS_ST_friendlySides_Dynamic) then {
                _as pushBack (_side select QS_ST_faction);
                {
                    if (((_side select QS_ST_faction) getFriend _x) > 0.6) then {
                        _as pushBack _x;
                    };
                } forEach _side;
            } else {
                _as pushBack (_side select QS_ST_faction);
                {
                    _as pushBack (_side select _x);
                } forEach QS_ST_showFriendlySides;
            };
        };
    } else {
        if (QS_ST_friendlySides_Dynamic) then {
            _as pushBack (_side select QS_ST_faction);
            {
                if (((_side select QS_ST_faction) getFriend _x) > 0.6) then {
                    _as pushBack _x;
                };
            } forEach _side;
        } else {
            _as pushBack (_side select QS_ST_faction);
            {
                _as pushBack (_side select _x);
            } forEach QS_ST_showFriendlySides;
        };
    };
};
if (!(QS_ST_showAI)) then {
    if (isMultiplayer) then {
        if (_isAdmin) then {
            {
                if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
                    _au pushBack _x;
                };
            } forEach allUnits;
        } else {
            {
                if (((side _x) in _as) || {(captive _x)}) then {
                    if (isPlayer _x) then {
                        if (_di isEqualTo 2) then {
                            if ((_x distance2D player) < QS_ST_GPSDist) then {
                                if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
                                    _au pushBack _x;
                                };
                            };
                        } else {
                            if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
                                _au pushBack _x;
                            };
                        };
                    };
                };
            } forEach (allPlayers + allUnitsUav);
        };
    } else {
        {
            if (((side _x) in _as) || {(captive _x)}) then {
                if (isPlayer _x) then {
                    if (_di isEqualTo 2) then {
                        if ((_x distance2D player) < QS_ST_GPSDist) then {
                            if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
                                _au pushBack _x;
                            };
                        };
                    } else {
                        if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
                            _au pushBack _x;
                        };
                    };
                };
            };
        } forEach (allPlayers + allUnitsUav);
    };
} else {
    {
        if (((side _x) in _as) || {(captive _x)}) then {
            if (_di isEqualTo 2) then {
                if ((_x distance2D player) < QS_ST_GPSDist) then {
                    if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
                        _au pushBack _x;
                    };
                };
            } else {
                if (_x isEqualTo ((crew (vehicle _x)) select 0)) then {
                    _au pushBack _x;
                };
            };
        };
    } forEach allUnits;
};
if ((_di isEqualTo 1) && QS_ST_showOnlyVehicles) exitWith {
    private _auv = [];
    {
        if (!((vehicle _x) isKindOf 'Man')) then {
            _auv pushBack _x;
        };
    } forEach _au;
    if (QS_ST_showEmptyVehicles) then {
        {
            if (!(_x in _auv)) then {
                if (_x getVariable ['QS_ST_drawEmptyVehicle',FALSE]) then {
                    if ((crew _x) isEqualTo []) then {
                        _auv pushBack _x;
                    };
                };
            };
        } forEach vehicles;
    };
    if (QS_ST_showGroupOnly) then {
        {
            _auv pushBack _x;
        } forEach (units (group player));
    };
    _auv;
};
if ((_di isEqualTo 1) && QS_ST_showEmptyVehicles) exitWith {
    {
        if (!(_x in _au)) then {
            if (_x getVariable ['QS_ST_drawEmptyVehicle',FALSE]) then {
                if ((crew _x) isEqualTo []) then {
                    _au pushBack _x;
                };
            };
        };
    } foreach vehicles;
    _au;
};

_au;
