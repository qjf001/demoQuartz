<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript">
        /*主函数要使用的函数，进行声明*/
        var clock=new clock();
        /*指向计时器的指针*/
        var timer;
        window.onload=function(){
            /*主函数就在每50秒调用1次clock函数中的move方法即可*/
            timer=setInterval("clock.move()",1000);
        }
        function clock(){
            /*s是clock()中的变量，非var那种全局变量，代表剩余秒数*/
            this.s=10;
            this.move=function(){
                /*输出前先调用exchange函数进行秒到分秒的转换，因为exchange并非在主函数window.onload使用，因此不需要进行声明*/
                document.getElementById("timer").innerHTML=this.s-1;
                /*每被调用一次，剩余秒数就自减*/
                this.s=this.s-1;
                /*如果时间耗尽，那么，弹窗，使按钮不可用，停止不停调用clock函数中的move()*/
                if(this.s<0){
                    clearTimeout(timer);
                    toHomePage();
                }
            }
        }
        function toHomePage(){
            window.top.location="/admin/main";
        }
    </script>
</head>
<body style="background-color: #009688;">
<h3 style="display: inline-block;">您没有被授权访问该资源</h3> , <span id="timer">10</span>秒后自动返回首页，<a href="javascript:void(0);" onclick="toHomePage();">立即返回首页</a>
</body>
</html>

