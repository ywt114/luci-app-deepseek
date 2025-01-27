module("luci.controller.deepseek", package.seeall)

function index()
    -- 添加主菜单项
    entry({"admin", "services", "deepseek"}, 
        alias("admin", "services", "deepseek", "config"), 
        _("DeepSeek"), 
        60 -- 菜单位置
    ).dependent = true
    
    -- 子页面配置
    entry({"admin", "services", "deepseek", "config"},
        cbi("deepseek/general"),
        _("General Settings"), 
        1
    )
    
    -- 状态页面
    entry({"admin", "services", "deepseek", "status"},
        template("deepseek/overview"),
        _("Status"),
        2
    )
    
    -- AJAX接口
    entry({"admin", "services", "deepseek", "get_status"}, 
        call("action_get_status")
    )
end

-- AJAX回调函数
function action_get_status()
    local sys = require "luci.sys"
    local status = sys.exec("/etc/init.d/deepseek status")
    luci.http.prepare_content("application/json")
    luci.http.write_json({ status = status })
end
