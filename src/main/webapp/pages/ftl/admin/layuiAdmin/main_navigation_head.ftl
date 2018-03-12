<div class="layui-header header header-demo">
    <div class="layui-main">
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav" lay-filter="demo">
           <#-- <li class="layui-nav-item" pc><a href="javascript:void(0);">最新活动</a></li>
            <li class="layui-nav-item layui-this" pc>
                <a href="javascript:;">产品</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:void(0);">选项1</a></dd>
                    <dd><a href="javascript:void(0);">选项2</a></dd>
                    <dd><a href="javascript:void(0);">选项3</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" pc><a href="javascript:void(0);">大数据</a></li>
            <li class="layui-nav-item" pc>
                <a href="javascript:void(0);">解决方案</a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:void(0);">移动模块</a></dd>
                    <dd><a href="javascript:void(0);">后台模版</a></dd>
                    <dd class="layui-this"><a href="javascript:void(0);">选中项</a></dd>
                    <dd><a href="javascript:void(0);">电商平台</a></dd>
                </dl>
            </li>-->
            <#--<li class="layui-nav-item" pc>&lt;#&ndash;mobile&ndash;&gt;
                <a href="javascript:;">管理员1<span class="layui-nav-more"></span></a>
                <dl class="layui-nav-child layui-anim layui-anim-upbit">
                    <dd><a href="javascript:void(0);" target="_blank">修改密码</a></dd>
                    <dd><a href="javascript:void(0);" target="_blank">登出</a></dd>
                </dl>
            </li>-->
               <li class="layui-nav-item " >
                   <a href="javascript:;"><i class="layui-icon">&#xe612;</i>${Session["nickName"]?default("管理员")}</a>
                   <dl class="layui-nav-child">
                       <dd><a href="javascript:void(0);" onclick="changePwd();" style="text-align: left;">修改密碼</a></dd>
                       <dd><a href="javascript:void(0);" onclick="logout();" style="text-align: left;">登出系統</a></dd>
                   </dl>
               </li>
        </ul>
    </div>
</div>