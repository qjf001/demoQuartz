<!DOCTYPE html>
<html>
<head>
    <#include "/admin/layuiAdmin/main_htmlHead.ftl">
    <style>
        #aform .layui-form-item {
            width:99.5%;
        }
        #aform  .layui-form-item .layui-input-inline {
            width: 280px;
        }
        @media screen and (max-width: 450px){
            #aform .layui-form-item .layui-input-inline {
                display: block;
                float: none;
                left: -3px;
                width: auto;
                margin: 0 0 10px 112px;
            }
        }
        #aform .layui-form-select dl{
            top:38px;
        }
        #aform .layui-form-label{width:100px;}
        #aform .layui-input-block {
            margin-left: 130px;}
    </style>
</head>
<body>
<@main.tplFrom />
<#include "${springMacroRequestContext.getRequestUri()}.ftl">
<script type="text/javascript" src="/layui/formIncubator.js"></script>
<form class="layui-form" id="aform" action="" style="padding-top:20px;"></form>
<script type="text/javascript">
var page_save_ajax = function(filterName)
{
    layui.form.on('submit('+filterName+')', function(data){
        var $ = layui.jquery;
        //layer.alert($("#aform").serialize(), {title: '最终的提交信息'});
        $.ajax({
            url:"save",
            data:$("#aform").serialize(),
            type:'post',
            dataType:"json",
            success:function(data){
                if(data.action=="success"){window.parent.auto_initDataGrid(window.parent.urlStr,window.parent._pageNum);layer.alert("保存成功",{time:2000,icon:1},function(){
                    window.parent.closeOpenPage();
                }); setTimeout(function(){ window.parent.closeOpenPage();},2000); }
                else{
                    layer.alert("保存失败 "+data.msg,{time:2000,icon:2});
                }
            }
        });
        return false;// 使用ajax提交表单，阻止form提交
    });
}
var page_save = function(filterName)
{
    layui.form.on('submit('+filterName+')', function(data){
        var $ = layui.jquery;
        //layer.alert($("#aform").serialize(), {title: '最终的提交信息'});
         $('#aform').attr("action","save");
         $('#aform').trigger('submit');
        return true;
    });
}
</script>
</body>
</html>
