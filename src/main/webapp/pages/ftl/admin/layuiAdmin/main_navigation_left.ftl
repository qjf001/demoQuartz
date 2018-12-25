<div class="layui-side layui-bg-black" style="top:0px;">
    <div class="layui-side-scroll">
        <ul class="layui-nav" lay-filter="demo" style="position: fixed;top: 0;left:0;z-index: 9999;background: lightseagreen;">
            <li class="layui-nav-item " >
                <a href="javascript:;" style="width: 120px;"><i class="layui-icon">&#xe612;</i>${Session["user"].nickName?default("管理员")}</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:void(0);" onclick="changePwd();" style="text-align: left;">修改密碼</a></dd>
                    <dd><a href="javascript:void(0);" onclick="logout();" style="text-align: left;">登出系統</a></dd>
                </dl>
            </li>
        </ul>
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree" lay-filter="navTree" style="margin-top: 80px;">
            <li class="layui-nav-item">
                <a href="javascript:void(0);" class="layui-nav-parent-a site-demo-active" data-type="tabAdd" data-title="首頁" data-a="/admin/portal">首頁</a>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:void(0);" class="layui-nav-parent-a site-demo-active" data-type="tabAdd" data-title="定时任务管理" data-a="/admin/qrtzConsole/list" >定时任务管理</a>
            </li>
        </ul>
    </div>
</div>
<script>
    layui.use('element', function(){
        var $ = layui.jquery
                ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

        //触发事件
        var active = {
            tabAdd: function(othis){
                var url = othis.data("a");
                var iframeName = url.substr(1,url.length).replace(/\//g, ".");
                var contain = false,ind=-1;
                $.each($('.layui-tab-title li'), function (i,v) {
                    if(iframeName==$(this).attr('lay-id'))
                    {
                        contain = true;
                        ind = i;
                        return;
                    }
                });
                if(contain) {//show
                    $('.layui-tab-title li').removeClass("layui-this");
                    $('.layui-tab-title li:eq('+ind+')').addClass("layui-this");
                    $('.layui-tab-content .layui-tab-item').removeClass("layui-show");
                    $('.layui-tab-content .layui-tab-item:eq(' + ind + ')').addClass('layui-show');
                }
                else{
                    var tabheight = $('.layui-side.layui-bg-black').height()-42+'px';
                    //新增一个Tab项
                    element.tabAdd('demo', {
                        title: othis.data("title") //用于演示
                        ,content:'<iframe src="'+url+'" style="width:100%;overflow-y: hidden;" height="'+tabheight+'"  frameborder="0" name="'+iframeName+'"></iframe>'
                        ,id: iframeName //实际使用一般是规定好的id，这里以时间戳模拟下
                    });
                    $('.layui-tab-title li:last').trigger("click");
                }
            }
            ,tabDelete: function(othis){
                //删除指定Tab项
                element.tabDelete('demo', '44'); //删除：“商品管理”
                othis.addClass('layui-btn-disabled');
            }
            ,tabChange: function(){
                //切换到指定Tab项
                element.tabChange('demo', '22'); //切换到：用户管理
            }
        };

        $('.site-demo-active').on('click', function(){
            var othis = $(this), type = othis.data('type');
            active[type] ? active[type].call(this, othis) : '';
        });

        //监听选项卡事件
        element.on('tab(demo)', function (data) {
            var uri = "/" + $('.layui-tab-title li:eq(' + data.index + ')').attr('lay-id').replace(/\./g, '/');
            $.each($('ul.layui-nav-tree').find('a'), function () {
                if ($(this).data('a') === uri) {
                    if (!$(this).hasClass('layui-nav-parent-a')) {
                        $(this).parent().addClass('layui-this');
                        $(this).parents('li.layui-nav-item').addClass('layui-nav-itemed');
                    } else {
                        $(this).parent().addClass('layui-this');
                    }
                }else{
                    $(this).parent().removeClass('layui-this');
                }
            });
        });
    });
</script>
<script type="text/javascript">
    var logout = function () {
        var $ = layui.jquery;
        layer.confirm("確定退出該系統嗎？",{icon:3},function(index){
            layer.close(index);
            $.ajax({
                url: "/admin/logout",
                success: function (data) {
                    if (data.action === 'success')
                        window.location.reload();
                    else
                        layer.alert("登出失敗");
                }
            });
        },function(){});
    }
    var changePwd = function () {
        var $ = layui.jquery;
        layer.prompt({
            formType: 2,
            value: '',
            title: '請輸入新密碼',
            area: ['400px', '200px'] //自定义文本域宽高
        }, function (value, index, elem) {
            layer.close(index);
            $.post({
                url: "/admin/resetPwd",
                data: {"password": value.trim()},
                dataType: "json",
                success: function (data) {
                    if (data.action === 'success') {
                        layui.layer.alert("操作成功", {icon: 1, title: '提示',closeBtn: 0}, function (index) {
                            logout();
                        });
                    }
                    else {
                        layer.alert("操作失敗");
                    }
                }
            });
        });
    }
</script>