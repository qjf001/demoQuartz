<script type="text/html" id="statusTpl">
    {{# var s = d.status; if(s==1){ }}
    <div style="font-size: 16px;font-weight: 600;color:#5FB878;">運行中</div>
    {{# }else if(s==2){ }}
    <div style="font-size: 16px;font-weight: 600;color:#FF5722;">已停止</div>
    {{# }else if(s==3){ }}
    暫停
    {{# } }}
</script>
<script type="text/html" id="opTpl">
    <#-- 編輯、刪除、啟動、暫停、停止-->
    <div class="layui-btn-group">
        {{# var s = d.status; if(s==1){ }}
        <button class="layui-btn layui-btn-sm layui-bg-gray layui-disabled" title="编辑">
            <i class="layui-icon">&#xe642;</i>
        </button>
        {{# }else{ }}
        <button class="layui-btn layui-btn-sm" onclick="openPage('edit?id={{d.id}}','编辑商品信息',true,5);" title="编辑">
            <i class="layui-icon">&#xe642;</i>
        </button>
        {{# } }}
    <#--禁用刪除功能-->
    <#-- <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="del('{{d.id}}');" title="删除">
         <i class="layui-icon">&#xe640;</i>
     </button>-->

        {{# var s = d.status; if(s==1){ }}
        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="stop('{{d.id}}');" title="停止">
            <i class="layui-icon">&#xe651;</i>停止
        </button>
        {{# }else{ }}
        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="start('{{d.id}}');" title="啟動">
            <i class="layui-icon">&#xe652;</i>啟動
        </button>
        {{# } }}
    </div>
</script>
<script type="text/javascript">
    var title = "定時任務列表";
    var bts = [
        {btName: "新增", clickEvent: "openPage('edit','编辑定時任務',true,2);", icon: "&#xe608;",classes:"layui-btn-sm"},
        {btName: "暂停调度",id:"shutdown",style:"display:none;" ,clickEvent: "startOrShutdown();", icon: "&#xe651;",classes:"layui-btn layui-btn-danger"},
        {btName: "开始调度",id:"start",style:"display:none;" ,clickEvent: "startOrShutdown();", icon: "&#xe652;",classes:"layui-btn layui-btn-danger"}
    ];
    var searchInputs = [];
    var columns = [
        {title: 'ID', field: 'id', width: 60, align: 'center'},
        {title: '任務名稱', field: 'name', width: 60, align: 'center'},
        {title: 'cron表達式', field: 'cron', width: 60, align: 'center'},
        {title: '任務狀態', field: 'status', width: 60, align: 'center', tpl: 'statusTpl'},
        {title: '操作', field: 'op', width: 60, align: 'center', tpl: 'opTpl'}
    ];
    function start(id){
        update(id);
    }
    function stop(id){
        update(id);
    }
    var update = function(id){
        $.post({
            url:"update",
            data:{"id":id},
            dataType:"json",
            success:function(data){
                if(data.action==='success'){
                    window.parent.auto_initDataGrid(window.urlStr,window._pageNum);
                    layui.layer.alert("操作成功",{icon: 1, title:'提示'},function(index){
                        layer.close(index);
                    });
                }
                else{
                    layui.layer.alert( "操作失敗："+(data.msg!="操作失败") ? data.msg : "",{icon:5});
                }
            }
        });
    }
    function pageReadyCallBack(){
        $.get({
            url:"getSchedulerStatus",
            success:function(data){
                if(data.action==='success'){
                    if(data.paused){
                        $('#start').show();
                        $('#shutdown').hide();
                    }
                    else{
                        $('#shutdown').show();
                        $('#start').hide();
                    }
                }
            }
        });
    }
    function startOrShutdown(){
        $.post({
            url:"schedulerStartOrShutDown",
            success:function(data){
                if(data.action==='success'){
                    if(data.paused){
                        $('#start').show();
                        $('#shutdown').hide();
                    }
                    else{
                        $('#shutdown').show();
                        $('#start').hide();
                    }
                }
            }
        });
    }
</script>
