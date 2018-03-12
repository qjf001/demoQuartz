/**
 * Created by Administrator on 2017/3/27 0027.
 */
layui.use(['form', 'layedit', 'laydate','laytpl','jquery','upload'], function(){
    var form = layui.form,$=layui.jquery;
    // 绘制表单
    if(window.formRows){
        layui.laytpl(formTpl.innerHTML).render(window.formRows, function(html){
            aform.innerHTML = html;
        });
    }

    if(window.bindElem)
    {
        layui.upload.render({
            elem:'#'+bindElem
            ,url: uploadUrl
            ,ext: 'jpg|jpeg|png|gif' //只会支持这三种格式的上传。注意是用|分割。
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

    $.each($('textarea'),function(i,v){
        if($(this).attr("maxlength")){
            $(this).attr('oninput','changeLimit($(this));');
            $(this).after('<span class="textLimit">'+$(this).attr("maxlength")+'</span>');/*$(this).on('input',changeLimit($(this)));*/
            $(this).trigger("oninput");
        }
    });

});
/* 提升到header中
var changeLimit = function(obj)
{
    var total = 0;// 統計回車
    var tvalu = obj.val();
    for(var i= 0;i<tvalu.length;i++)
    {
        var ch = tvalu.substr(i,1);
        if(ch==='\n')
            total += 1;
    }
    var limit = (obj.attr("maxlength")-obj.val().length-total);
    if(limit < 0) obj.next().html(0); else obj.next().html(limit);
    if(limit <= 0) obj.val(obj.val().substr(0,obj.attr("maxlength")-total));
}*/
