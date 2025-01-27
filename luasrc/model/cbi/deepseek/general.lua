local m = Map("deepseek", 
    translate("DeepSeek Configuration"),
    translate("Configure DeepSeek service parameters"))

local s = m:section(TypedSection, "general", translate("General Settings"))
s.anonymous = true

s:option(Flag, "enabled", translate("Enable Service"))
s:option(Value, "api_key", translate("API Key"))
s:option(Value, "interval", translate("Check Interval"))
    .datatype = "uinteger"

return m
