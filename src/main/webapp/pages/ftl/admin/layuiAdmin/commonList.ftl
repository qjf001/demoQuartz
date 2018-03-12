<!DOCTYPE html>
<html>
<head>
<#include "/admin/layuiAdmin/main_htmlHead.ftl">
    <script type="text/javascript">
        var rightError = function (v,rightText,errorText)
        {
            if(!rightText)rightText="";if(!errorText)errorText="";
            if(v==1)
                return "<i class=\"layui-icon\" style='color:#5FB878;font-weight: 900;font-size: 18px;' title='"+rightText+"'>&#xe605;</i>";
            return "<i class=\"layui-icon\" style='color:#FF5722;font-weight: 900;font-size: 18px;' title='"+errorText+"'>&#x1006;</i>";
        }
    </script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <#include "/admin/layuiAdmin/main_navigation.ftl" >
    <div class="layui-body">
        <!-- 内容主体区域 -->
        <@main.tplLeftTopBt />
        <@main.tplSearchFrom />
        <@main.tplTableGrid />
        <@main.defaultButtonTpl />
        <#include "${springMacroRequestContext.getRequestUri()}.ftl">
        <script type="text/javascript" src="/layui/tableIncubator.js"></script>
        <div id="navbar">
            <div id="btArea" class="layui-btn-group" style="float: left;margin:10px 0 0 10px;"></div>
            <div id="searchArea" class="layui-form" style="float: right;width:70%;margin-top:10px;">
                <form id="searchForm"></form>
            </div>
        </div>
        <div>
            <div id="tableGrid" class="layui-form" style="clear:both;"></div>
        </div>
    </div>
    <#include "/admin/layuiAdmin/main_footer.ftl" >
</div>
<#include "/admin/layuiAdmin/main_mobileShade.ftl" >
<script type="text/javascript">
layui.use('jquery',function(){
    var $ = layui.jquery;
    var btCount = $('#btArea').children().length;
    if(btCount <= 1)
        $('#btArea').removeClass('layui-btn-group');
});
</script>
</body>
</html>
