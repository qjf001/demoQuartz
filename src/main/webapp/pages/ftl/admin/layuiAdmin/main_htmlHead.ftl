<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<title><@main.siteTitle /></title>
<link rel="shortcut icon" href="/assets/images/dd.ico" type="image/x-icon">
<link rel="stylesheet" href="/layui/css/layui.css"/>
<link rel="stylesheet" href="/layui/css/modules/layui-icon-extend/iconfont.css"/>
<link rel="stylesheet" href="/layui/css/global.css"/>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/layui/layui.js"></script>
<script type="text/javascript" >
    <#--使用layui.use隐式的加载layui的其他js模块,如果不设置dir: '/layui/'有一定几率不能按照正常路径（spingmvc设定的静态路径）加载所需的js模块-->
    layui.config({
        dir: '/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
        , version: false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
        , debug: false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
    });
    layui.use(['laydate','layer'], function () {
        $.ajaxSetup({
            dataType:"json",
            complete: function (event) {
                var httpStatus = event.status;
                // console.log(event);
                if(event.responseJSON && event.responseJSON.status)
                    httpStatus = event.responseJSON.status;
                if (httpStatus == "901")
                    window.top.location.reload();
                else if (httpStatus == "401")
                    layui.layer.alert("您没有被授权访问该资源：</br>"+event.responseJSON.path,{icon:5});
                else if(httpStatus != "200" ){
                    if(event.responseJSON)
                        layui.layer.alert(event.responseJSON.message+"：</br>"+event.responseJSON.path,{icon:5});
                    else if(!event.responseJSON && httpStatus===0) // 无法访问服务器
                      window.top.location.reload();
                }
            }
        });
    });

    var changeLimit = function (obj) {
        var total = 0;// 統計回車
        var tvalu = obj.val();
        for (var i = 0; i < tvalu.length; i++) {
            var ch = tvalu.substr(i, 1);
            if (ch === '\n')
                total += 1;
        }
        var limit = (obj.attr("maxlength") - obj.val().length - total);
        if (limit < 0) obj.next().html(0); else obj.next().html(limit);
        if (limit <= 0) obj.val(obj.val().substr(0, obj.attr("maxlength") - total));
    }

    document.onkeydown = function (event) {
        var target, code, tag;
        if (!event) {
            event = window.event; //针对ie浏览器
            target = event.srcElement;
            code = event.keyCode;
            if (code == 13) {
                tag = target.tagName;
                if (tag == "TEXTAREA" || tag == "INPUT" || tag == "BUTTON") {
                    return false;
                }
                else {
                    return true;
                }
            }
        }
        else {
            target = event.target; //针对遵循w3c标准的浏览器，如Firefox
            code = event.keyCode;
            if (code == 13) {
                tag = target.tagName;
                if (tag == "INPUT" || tag == "BUTTON") {
                    return false;
                }
                else {
                    return true;
                }
            }
        }
    };
</script>
<style>
    span.textLimit {
        position: absolute;
        right: 20px;
        bottom: 0;
        color: gray;
        font-style: italic;
    }

    .layui-disabled, .layui-disabled:hover {
        color: #d2d2d2 !important;
        cursor: not-allowed !important;
    }
    div.layui-layout-admin div.layui-side div.layui-side-scroll ul.layui-nav-tree li.layui-nav-item dl dd a{
        margin-left: 15px;
    }
    div.header-demo div.layui-main{
        text-align: right;
    }
    div.footer-demo{
        text-align: center;
    }
</style>

