#include "script_component.hpp"

// Draws an icon at current via uav lased position and draws a line between the uav and the icon

private ['_connectedUav', '_intersects', '_laserPos', '_validLaserPos', '_targetIcon', '_targetIconColor'];

_connectedUav = getConnectedUAV qipTPL_unit;
_laserPos = getPosASL laserTarget _connectedUav;
_validLaserPos = !(_laserPos isEqualTo [0,0,0]);
_targetIcon = '\A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa';
_targetIconColor = [1,0,0,0.5];

if (_validLaserPos) then {
    _this select 0 drawIcon [_targetIcon, _targetIconColor, _laserPos, 24, 24, 0, '', 1, 0.03, 'TahomaB', 'center'];
    _this select 0 drawLine [_connectedUav, _laserPos, [1,0,0,0.5]];
};