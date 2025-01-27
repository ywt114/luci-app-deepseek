local m = Map("deepseek", 
    translate("DeepSeek Configuration"),
    translate("Configure parameters for DeepSeek integration"))

local s = m:section(TypedSection, "general", translate("Core Settings"))
s.anonymous = true
s.addremove = false

s:option(Flag, "enabled", translate("Enable Service")).default = 0

api_key = s:option(Value, "api_key", translate("API Key"))
api_key.password = true
api_key.rmempty = false

interval = s:option(Value, "interval", translate("Update Interval (seconds)"))
interval.datatype = "range(60,3600)"
interval.default = 300

return m
