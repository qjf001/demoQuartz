<!DOCTYPE html>
<html>
<head><#include "/admin/layuiAdmin/main_htmlHead.ftl"></head>
<body>
<div class="layui-layout layui-layout-admin">
    <#include "/admin/layuiAdmin/main_navigation.ftl" >
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="height: 100%;width: 100%;">
            <p style="height: 20px;line-height: 20px;padding-top: 20px;font-size: 20px;margin-left: 40px;">${Session["nickName"]} ${Session["role"].nickName}，歡迎登錄！</p>
        </div>
    </div>
    <#include "/admin/layuiAdmin/main_footer.ftl" >
</div>
<#include "/admin/layuiAdmin/main_mobileShade.ftl" >
</body>
</html>
