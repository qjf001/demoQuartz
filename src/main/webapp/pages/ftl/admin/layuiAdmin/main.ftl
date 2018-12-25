<!DOCTYPE html>
<html>
<head><#include "/admin/layuiAdmin/main_htmlHead.ftl"></head>
<style type="text/css">
    .p_icon{
        width: 75%;
    }
     .layui-tab-title li.layui-this{
         background-color: #009688;
     }
</style>
<body class="gray-bg">
<div class="layui-layout layui-layout-admin">
    <#include "/admin/layuiAdmin/main_navigation.ftl" >
    <div class="layui-body" style="overflow-y: hidden;top:0px;bottom:0px;">
        <div class="layui-tab" lay-filter="demo" lay-allowclose="true" style="margin: 0 0;">
            <ul class="layui-tab-title"></ul>
            <div class="layui-tab-content"></div>
        </div>
    </div>
</div>
<#include "/admin/layuiAdmin/main_mobileShade.ftl" >
</body>
<script>
    var openPageIndex ;
    var openPage = function(urlStr,title,fullScreen,anim,width,height)
    {
        if(width===undefined || width > window.screen.width)width=window.screen.width*0.8;
        if(height===undefined || height > window.screen.height)height=window.screen.height*0.9;
        if(isNaN(width))throw new Error(" width is not a number ");
        if(isNaN(height))throw new Error(" height is not a number ");
        if(isNaN(anim))anim = 3;
        openPageIndex = layui.layer.open({
            type: 2,// type=1 弹层为普通，不会请求链接
            title: title===undefined ? "  " : title,// 没有title也要站个位
            skin: 'layui-layer-molv',// title皮肤
            shadeClose: false,// 点击遮罩不关闭
            shade: true,// 遮罩父窗口
            maxmin: false, //开启最大化最小化按钮
            fixed:true,
            anim: anim,// 来点动画 1-从上中弹出，2-从下方弹出，3-从中间来，4-左下方旋出来，5-从中间来，6-抖出来，
            area: [width+'px',height+'px'],
            content: urlStr
        });
        if(fullScreen)layui.layer.full(openPageIndex);// 弹出即全屏
    }
    var reload = function(){
        var currentIframeSrc = $('.layui-tab-content .layui-tab-item.layui-show iframe').attr("src");
        for(var i=0;i<window.frames.length;i++){
            var parser = document.createElement('a');
            parser.href = window.frames[i].document.documentURI;
            if(parser.pathname==currentIframeSrc)
                window.frames[i].reload();
        }
    }
    var closeOpenPage=function(){
        if(openPageIndex)
            layer.close(openPageIndex);
    }
    window.onload = function(){
        $('.layui-nav.layui-nav-tree .layui-nav-item:eq(0) a:eq(0)').trigger('click');
    }
</script>
</html>
