/**
 * Created by Administrator on 2017/3/27 0027.
 */
layui.use(['form', 'layedit', 'laydate','laytpl','jquery','upload'], function(){
    var form = layui.form,$=layui.jquery;
    if(window.formRows && window.formRows[window.formRows.length-1].type != 'button')
        window.formRows.push({type:"button",formName:"buttonGroup", options:[
                {btName:"保存",filterName:"save",laySubmit:true,type:"button",clickEvent:"page_save_ajax('save');"},
                {btName:"重置",btId:"reset",type:"reset"}
            ]});
    // 绘制表单
    if(window.formRows){
        layui.laytpl(formTpl.innerHTML).render(window.formRows, function(html){
            aform.innerHTML = html; if(typeof formReady === "function") {formReady();}
        });
    }

    if(window.bindElem)
    {
        layui.upload.render({
            elem:'#'+bindElem
            ,url: uploadUrl
            ,accept:'images'
            ,size:2048
            ,exts: 'jpg|jpeg|png|gif' //只会支持这三种格式的上传。注意是用|分割。
            ,acceptMime: 'image/jpg, image/png,image/jpeg,image/gif'
            ,done: upload_success_fun
        });
    }

    // 通过循环表单元素绑定时间控件
    $.each($('form input.layui-input-datetime:visible,input.layui-input-date:visible,input.layui-input-time:visible'),function(ind,valu){
        if($(this).hasClass("layui-input-datetime"))
        {
            layui.laydate.render({
                elem: this
                , trigger: 'click'
                , type: 'datetime'
            });
        }
        else if($(this).hasClass("layui-input-date"))
        {
            layui.laydate.render({
                elem: this
                , trigger: 'click'
                , type: 'date'
            });
        }
        else if($(this).hasClass("layui-input-time"))
        {
            layui.laydate.render({
                elem: this
                , trigger: 'click'
                , type: 'time'
                , format: 'HH:mm'
            });
        }
    });

    form.render();

    $(function () {
        $.each($('textarea'), function (i, v) {
            if ($(this).attr("maxlength")) {
                $(this).after('<span class="textLimit">' + $(this).attr("maxlength") + '</span>');
                $(this).on('oninput',changeLimit($(this)));
                $(this).trigger("oninput");
            }
        });
    });
});
