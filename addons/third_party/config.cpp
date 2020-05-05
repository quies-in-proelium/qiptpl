#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "qiptpl_main",
            "qiptpl_assets"
        };
        author = "NemesisRE";
        authors[] = {
            "aliascartoons",
            "EO",
            "Cephel",
			"diwako"
        };
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgFunctions.hpp"
#include "CfgRscTitles.hpp"
#include "CfgSounds.hpp"
#include "CfgVehicles.hpp"
