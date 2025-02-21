-- Fx_Amp

local fx = require("fx/lib/fx")
local mod = require("core/mods")

local FxAmp = fx:new{
    subpath = "/fx_amp"
}

function FxAmp:add_params()
   params:add_separator("fx_amp", "fx_amp")
   FxAmp:add_slot("fx_amp_slot", "slot")
   FxAmp:add_control("fx_amp_in_mult", "pre gain", "in_mult", controlspec.new(0, 4, "db", 0, 1))
   FxAmp:add_control("fx_amp_env_sens", "env. sens.", "env_sens", controlspec.new(0, 4, "db", 0, 1))
   FxAmp:add_control("fx_amp_env_decay", "env. decay", "env_decay", controlspec.new(0.8, 0.9999, "exp", 0, 0.999, "", 0.01))
   FxAmp:add_control("fx_amp_env_mult", "env. amount", "env_mult", controlspec.new(0.01, 10, "exp", 0, 1))
   FxAmp:add_control("fx_amp_amp_mult", "post gain", "amp_mult", controlspec.new(0, 4, "db", 0, 1))
   FxAmp:add_control("fx_amp_dry_mult", "dry level", "dry_mult", controlspec.new(0, 1, "lin", 0, 0))
   FxAmp:add_control("fx_amp_wet_mult", "wet level", "wet_mult", controlspec.new(0, 1, "lin", 0, 1))
end

mod.hook.register("script_post_init", "Fx_Amp mod post init", function()
   FxAmp:add_params()
end)

mod.hook.register("script_post_cleanup", "Fx_Amp mod post cleanup", function()
end)

return FxAmp