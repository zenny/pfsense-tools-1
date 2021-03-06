--
-- conf/pfSense.lua
-- $Id$
--
-- This file contains pfSense-specific overrides to BSDInstaller.lua.
--

product = {
	name = "pfDNS",
	version = "1.0-BETA1"
}

mountpoints = function(part_cap, ram_cap)

        --
        -- First, calculate suggested swap size:
        --
        local swap = 2 * ram_cap
        if ram_cap > (part_cap / 2) or part_cap < 4096 then
                swap = ram_cap
        end
        swap = tostring(swap) .. "M"

        --
        -- Now, based on the capacity of the partition,
        -- return an appropriate list of suggested mountpoints.
        --

        --
        -- pfSense: We want to only setup / and swap.
        --

        return {
                { mountpoint = "/",     capstring = "*" },
                { mountpoint = "swap",  capstring = swap },
        }

end

cmd_names = cmd_names + {
	DMESG_BOOT = "var/log/dmesg.boot"
}

install_items = {
        "boot",
        "COPYRIGHT",
        "bin",
        "conf",
        "conf.default",
        "dev",
        "etc",
		"kernels",
        "libexec",
        "lib",
        "root",
        "sbin",
        "sys",
        "usr",
        "var"
}

ui_nav_control = {
	["*/welcome"] = "ignore",           	     			-- do not show any "welcome" items
	["*/configure_installed_system"] = "ignore", 			-- don't put these on
	["*/upgrade_installed_system"] = "ignore",   			-- the main menu...
	["*/load_kernel_modules"] = "ignore", 		 			-- do not ask about loading kernel modules
	["*/pit/configure_console"] = "ignore",   	 			-- do not ask about console
	["*/pit/configure_network"] = "ignore",   	 			-- do not ask about network
	["*/*netboot*"] = "ignore",						-- ignore netboot installation services
	["*/install/select_packages"] = "ignore", 	 			-- do not do the "Select Packages" step on install
	["*/install/confirm_install_os"] = "ignore",			-- no need to confirm os install
	["*/install/warn_omitted_subpartitions"] = "ignore",	-- warn that /tmp /var and friends are being ommited
	["*/install/finished"] = "ignore",						-- no need to extra spamming
	["*/install/select_additional_filesystems"] = "ignore", -- do not include additional filesystems prompts
	["*/install/270_install_bootblocks.lua"] = "ignore", 	-- ignore the old boot block installer program
	["*/configure/*"] = "ignore",             	 			-- do not configure, we've already did it.
}

booted_from_install_media=true

dir = { root = "/", tmp = "/tmp/" }

limits.part_min = "100M"

offlimits_devices = { "fd%d+", "md%d+", "cd%d+" }

offlimits_mounts  = { "union" }

use_cpdup = true
