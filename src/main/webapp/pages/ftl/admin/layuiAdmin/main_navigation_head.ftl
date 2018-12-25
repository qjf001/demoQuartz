<div class="layui-header header header-demo">
    <div class="layui-main">
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav" lay-filter="demo">
               <li class="layui-nav-item " >
                   <a href="javascript:;"><i class="layui-icon">&#xe612;</i>${Session["user"].nickName?default("管理员")}</a>
                   <dl class="layui-nav-child">
                       <dd><a href="javascript:void(0);" onclick="changePwd();" style="text-align: left;">修改密碼</a></dd>
                       <dd><a href="javascript:void(0);" onclick="logout();" style="text-align: left;">登出系統</a></dd>
                   </dl>
               </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    var logout = function () {
        var $ = layui.jquery;
        $.ajax({
            url: "/admin/logout",
            success: function (data) {
                if (data.action === 'success')
                    window.location.reload();
                else
                    layer.alert("登出失敗");
            }
        });
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