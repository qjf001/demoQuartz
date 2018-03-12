<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree" lay-filter="navTree">
            <li class="layui-nav-item">
                <a href="/admin/main" class="layui-nav-parent-a">首頁</a>
            </li>
            <li class="layui-nav-item">
                <a href="/admin/qrtzConsole/list" class="layui-nav-parent-a">定时任务管理</a>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    layui.use(['element','jquery'],function(){
        var uri = window.location.pathname,$=layui.jquery;
        $.each($('ul.layui-nav-tree').find('a'),function(){
            if($(this).attr('href')===uri)
            {
                if(!$(this).hasClass('layui-nav-parent-a'))
                {
                    $(this).parent().addClass('layui-this');
                    $(this).parents('li.layui-nav-item').addClass('layui-nav-itemed');
                }else
                {
                    $(this).parent().addClass('layui-this');
                }
                return ;
            }
        });
    });
</script>
