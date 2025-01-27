module("luci.controller.deepseek", package.seeall)

function index()
    entry({"admin", "services", "deepseek"}, 
        alias("admin", "services", "deepseek", "config"), 
        _("DeepSeek"), 
        60
    ).dependent = true
    
    entry({"admin", "services", "deepseek", "config"},
        cbi("deepseek/general"),
        _("General Settings"), 
        1
    )
    
    entry({"admin", "services", "deepseek", "status"},
        template("deepseek/overview"),
        _("Status"),
        2
    )
    
    entry({"admin", "services", "deepseek", "get_status"}, 
        call("action_get_status")
    )
    
    entry({"admin", "services", "deepseek", "control"},
        call("action_control")
    )
end

function action_get_status()
    local sys = require "luci.sys"
    local status = sys.exec("/etc/init.d/deepseek status 2>&1")
    luci.http.prepare_content("application/json")
    luci.http.write_json({ status = status })
end

function action_control()
    local http = require "luci.http"
    local action = http.formvalue("action")
    os.execute("/etc/init.d/deepseek " .. action .. " >/dev/null 2>&1")
    http.redirect(luci.dispatcher.build_url("admin/services/deepseek/status"))
end
