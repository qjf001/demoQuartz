<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Language" content="zh-cn"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="shortcut icon" href="/assets/images/dd.ico" type="image/x-icon">
    <title>xxxx系统</title>
    <script src="/js/jquery-3.1.1.min.js"></script>

    <style type="text/css">
        .layui-nav-tree .layui-nav-child a:hover {
            color: #fff;
            background: #4E5465;
        }

        /*sidebar mini*/
        .layui-layout-admin .sidebar-mini {
            width: 70px;
        }

        .layui-layout-admin .sidebar-mini .layui-side-scroll {
            width: 100px;
        }

        .layui-layout-admin .sidebar-mini #sidebar {
            width: 70px;
        }

        .layui-layout-admin .sidebar-mini .layui-nav-tree {
            width: 70px;
        }

        .layui-layout-admin .sidebar-mini .layui-nav .layui-nav-item a {
            padding: 0 15px;
        }

        .layui-layout-admin .sidebar-mini .layui-nav-item a cite {
            display: none;
        }

        #sidebar {
            height: 40px;
            width: 200px;
            background: #4A5064;
            text-align: center;
            line-height: 40px !important;
            font-size: 18px;
            user-select: none;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
        }

        @font-face {
            font-family: 'iconfont';  /* project id 58108 */
            src: url('//at.alicdn.com/t/font_4ol5mtrz7qoajor.eot');
            src: url('//at.alicdn.com/t/font_4ol5mtrz7qoajor.eot?#iefix') format('embedded-opentype'),
            url('//at.alicdn.com/t/font_4ol5mtrz7qoajor.woff') format('woff'),
            url('//at.alicdn.com/t/font_4ol5mtrz7qoajor.ttf') format('truetype'),
            url('//at.alicdn.com/t/font_4ol5mtrz7qoajor.svg#iconfont') format('svg');
        }


    </style>


    <style>


        .wrapper {
            color: white;
        }

        html {
            background-color: #393d49
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-weight: 300;
        }

        body {
            font-family: 'Source Sans Pro', sans-serif;

            font-weight: 300;
        }

        body ::-webkit-input-placeholder {
            /* WebKit browsers */
            font-family: 'Source Sans Pro', sans-serif;

            font-weight: 300;
        }

        body :-moz-placeholder {
            /* Mozilla Firefox 4 to 18 */
            font-family: 'Source Sans Pro', sans-serif;

            opacity: 1;
            font-weight: 300;
        }

        body ::-moz-placeholder {
            /* Mozilla Firefox 19+ */
            font-family: 'Source Sans Pro', sans-serif;

            opacity: 1;
            font-weight: 300;
        }

        body :-ms-input-placeholder {
            /* Internet Explorer 10+ */
            font-family: 'Source Sans Pro', sans-serif;
            font-weight: 300;
        }

        .wrapper {
            background: #393d49;
            background: -webkit-linear-gradient(top left, #393d49 0%, #393d49 100%);
            background: linear-gradient(to bottom right, #393d49 0%, #393d49 100%);
            opacity: 0.8;
            position: absolute;
            top: 45%;
            left: 0;
            width: 100%;
            height: 400px;
            margin-top: -200px;
            overflow: hidden;
        }

        .layui-form-item {
            color: #333
        }

        .layui-form-select .layui-input {
            color: #333
        }

        .layui-form-select dl dd, .layui-form-select {
            cursor: pointer;
            color: #333
        }

        .layui-form-item {
            text-align: center;
            margin-left: 180px
        }

        .wrapper.form-success .container h1 {
            -webkit-transform: translateY(85px);
            -ms-transform: translateY(85px);
            transform: translateY(85px);
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 80px 0;
            height: 400px;
            text-align: center;
        }

        .container h1 {
            font-size: 40px;
            -webkit-transition-duration: 1s;
            transition-duration: 1s;
            -webkit-transition-timing-function: ease-in-put;
            transition-timing-function: ease-in-put;
            font-weight: 200;
        }

        form {
            padding: 20px 0;
            position: relative;
            z-index: 2;
        }

        form input {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            outline: 0;
            border: 1px solid rgba(255, 255, 255, 0.4);
            background-color: rgba(255, 255, 255, 0.2);
            width: 250px;
            border-radius: 3px;
            padding: 10px 15px;
            margin: 0 auto 10px auto;
            display: block;
            text-align: center;
            font-size: 18px;
            color: white;
            -webkit-transition-duration: 0.25s;
            transition-duration: 0.25s;
            font-weight: 300;
        }

        form input:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }

        form input:focus {
            background-color: white;
            width: 300px;
            color: #5e7cba;
        }

        form button {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            outline: 0;
            background-color: white;
            border: 0;
            padding: 10px 15px;
            color: #5e7cba;
            border-radius: 3px;
            width: 250px;
            cursor: pointer;
            font-size: 18px;
            -webkit-transition-duration: 0.25s;
            transition-duration: 0.25s;
        }

        form button:hover {
            background-color: #f5f7f9;
        }

        .bg-bubbles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        .bg-bubbles li {
            position: absolute;
            list-style: none;
            display: block;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.15);
            bottom: -160px;
            -webkit-animation: square 25s infinite;
            animation: square 25s infinite;
            -webkit-transition-timing-function: linear;
            transition-timing-function: linear;
        }

        .bg-bubbles li:nth-child(1) {
            left: 10%;
        }

        .bg-bubbles li:nth-child(2) {
            left: 20%;
            width: 80px;
            height: 80px;
            -webkit-animation-delay: 2s;
            animation-delay: 2s;
            -webkit-animation-duration: 17s;
            animation-duration: 17s;
        }

        .bg-bubbles li:nth-child(3) {
            left: 25%;
            -webkit-animation-delay: 4s;
            animation-delay: 4s;
        }

        .bg-bubbles li:nth-child(4) {
            left: 40%;
            width: 60px;
            height: 60px;
            -webkit-animation-duration: 22s;
            animation-duration: 22s;
            background-color: rgba(255, 255, 255, 0.25);
        }

        .bg-bubbles li:nth-child(5) {
            left: 70%;
        }

        .bg-bubbles li:nth-child(6) {
            left: 80%;
            width: 120px;
            height: 120px;
            -webkit-animation-delay: 3s;
            animation-delay: 3s;
            background-color: rgba(255, 255, 255, 0.2);
        }

        .bg-bubbles li:nth-child(7) {
            left: 32%;
            width: 160px;
            height: 160px;
            -webkit-animation-delay: 7s;
            animation-delay: 7s;
        }

        .bg-bubbles li:nth-child(8) {
            left: 55%;
            width: 20px;
            height: 20px;
            -webkit-animation-delay: 15s;
            animation-delay: 15s;
            -webkit-animation-duration: 40s;
            animation-duration: 40s;
        }

        .bg-bubbles li:nth-child(9) {
            left: 25%;
            width: 10px;
            height: 10px;
            -webkit-animation-delay: 2s;
            animation-delay: 2s;
            -webkit-animation-duration: 40s;
            animation-duration: 40s;
            background-color: rgba(255, 255, 255, 0.3);
        }

        .bg-bubbles li:nth-child(10) {
            left: 90%;
            width: 160px;
            height: 160px;
            -webkit-animation-delay: 11s;
            animation-delay: 11s;
        }

        @-webkit-keyframes square {
            0% {
                -webkit-transform: translateY(0);
                transform: translateY(0);
            }
            100% {
                -webkit-transform: translateY(-700px) rotate(600deg);
                transform: translateY(-700px) rotate(600deg);
            }
        }

        @keyframes square {
            0% {
                -webkit-transform: translateY(0);
                transform: translateY(0);
            }
            100% {
                -webkit-transform: translateY(-700px) rotate(600deg);
                transform: translateY(-700px) rotate(600deg);
            }
        }
    </style>

</head>
<body>

<div class="wrapper">

    <div class="container">

        <h1>xxxx系统</h1>

        <form id="loginForm" action="/login" method="post">
            <input class="txt-input txtpd" name="username" id="username" lay-verify="required" type="text" value=""
                   placeholder="請輸入賬號" onkeydown="nameEnterKeyEvent();"/>
            <input class="txt-input txtpd" name="password" id="password" lay-verify="required" value=""
                   placeholder="請輸入密碼"
                   type="password" onkeydown="passEnterKeyEvent();"/>
            <div>
                <input class="txt-input txtpd" name="captcha" id="captcha" lay-verify="required" value="" placeholder="請輸入驗證碼" type="text" onkeydown="codeEnterKeyEvent();" style="width: 160px;display: inline-block"/>
                <img src="/captcha/get" style="display: inline-block;height: 40px;" onclick="codeReload($(this));"/>
            </div>
            <button id="login" type="button" onclick="page_save_ajax();">登錄</button>
        </form>
        <p style="color: orange; margin-top: 10px;font-size: 16px;">${message}</p>

    </div>

    <ul class="bg-bubbles">
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
        <li></li>
    </ul>
</div>
<script type="text/javascript" src="/js/jQuery.md5.js"></script>
<link rel="stylesheet" href="/layui/css/layui.css"/>
<script src="/layui/layui.js"></script>
<script type="text/javascript">

    layui.config({
        dir: '/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
        , version: false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
        , debug: false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
    });
    layui.use('layer', function () {});

    var page_save_ajax = function () {

        var userName = $('#username').val();
        var password = $('#password').val();
        var captcha = $('#captcha').val();
        if (!userName) {
            layer.alert("賬號不能為空", {icon: 5, title: "賬號"});
            return;
        }
        if (!password) {
            layer.alert("密碼不能為空", {icon: 5, title: "密碼"});
            return;
        }
        if (!captcha) {
            layer.alert("驗證碼不能為空", {icon: 5, title: "密碼"});
            return;
        }
        $('#password').val($.md5($.md5($('#password').val())));
        $('#loginForm').trigger("submit");
    }

    var codeEnterKeyEvent = function () {
        if (event.keyCode === 13){
            if(!$('#captcha').val()){
                layer.alert("驗證碼不能為空", {icon: 5, title: "密碼"});
                $('#captcha').blur();
            }else{
                page_save_ajax();
            }
        }
    }
    var passEnterKeyEvent = function () {
        if (event.keyCode === 13){
            if(!$('#password').val()){
                layer.alert("密碼不能為空", {icon: 5, title: "密碼"});
                $('#password').blur();
            }else{
                $('#captcha').focus();
            }
        }
    }
    var nameEnterKeyEvent = function () {
        if (event.keyCode === 13){
            if(!$('#username').val()){
                layer.alert("賬號不能為空", {icon: 5, title: "賬號"});
                $('#username').blur();
            }else{
                $('#password').focus();
            }
        }
    }
    var codeReload = function(obj){
        $(obj).attr("src","/captcha/get?time="+new Date().getTime());
        $('#captcha').val("");
    }

    document.onkeydown = function (event) {
        var target, code, tag;
        if (!event) {
            event = window.event; //针对ie浏览器
            target = event.srcElement;
            code = event.keyCode;
            if (code == 13) {
                tag = target.tagName;
                if (tag == "BUTTON") {
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
                console.log(tag);
                if (tag == "BUTTON") {
                    return false;
                }
                else {
                    return true;
                }
            }
        }
    };

    $(function () {
        $('#username').focus();
    });
</script>
</body>
</html>