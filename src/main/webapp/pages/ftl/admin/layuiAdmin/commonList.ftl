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
    <style>
        .layui-elem-field legend{font-size:16px}
    </style>
</head>
<body style="overflow: hidden;">
<!-- 内容主体区域 -->
    <@main.tplLeftTopBt />
    <@main.tplSearchFrom />
    <@main.tplTableGrid />
    <@main.defaultButtonTpl />
    <#include "${springMacroRequestContext.getRequestUri()}.ftl">
<script type="text/javascript" src="/layui/tableIncubator.js"></script>
<div id="navbar" style="display: flex;">
    <div id="btArea" class="layui-btn-group" style="margin:0 0 10px 10px;min-width: 200px;"></div>
    <div id="searchArea" class="layui-form" style="margin-top:0px;">
        <form id="searchForm"></form>
    </div>
</div>
<div id="tableGrid" class="layui-form" style="clear:both;display: block"></div>
<script type="text/javascript">
    layui.use('jquery',function(){
        if($('#btArea').children().length <= 1)
            $('#btArea').removeClass('layui-btn-group');
    });
$(window).resize(function () {          //当浏览器宽度变化时才会触发
    resetDataTableHeight();
});
function resetDataTableHeight(){
    let maxH =  $('.layui-side.layui-bg-black',window.top.document).height()-42;          //浏览器时下窗口可视区域高度
    let sh = 0;
    if($('#searchArea'))
        sh = $('#searchArea').height();
    maxH -= (100+sh);
    $('table.layui-table-data').css("max-height",maxH);
}
</script>
</body>
</html>
