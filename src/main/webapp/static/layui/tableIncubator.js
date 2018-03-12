layui.use(['layer','laytpl', 'element','jquery','form','laypage','laydate'], function(){

  let form=layui.form;window.tableTpl = tableTpl.innerHTML;

    if(!window.urlStr)
        window.urlStr = window.location.pathname+"Data";

	// 初始化button 组(新增、批量删除等)
	if(window.bts){
		layui.laytpl(leftTopBtGroupTpl.innerHTML).render(window.bts, function(html){
			btArea.innerHTML = html;
		});
	}
	/**初始化搜索表单*/
	if(window.searchInputs){
		layui.laytpl(searchFormTpl.innerHTML).render(window.searchInputs, function(html){
			searchForm.innerHTML = html;
		});
	}
	/** 日期类型绑定控件 */
	initDateInputForSearchForm();

	form.render('radio');//searchForm以静态的方式插入到指定区域，需要动态渲染一下 form.render('select');

	try{
		if(!columns instanceof Array){alert("columns is not array");return false;}
	}catch(e) {alert("columns is not defined");throw new Error("columns is not defined");return false;}
	window.pageSize = (!window.pageSize) ? 10 : pageSize;//维持一个全局变量，然后将声明的全局变量的值赋给去全局变量

	auto_initDataGrid(urlStr,1);// 页面打开，初始化数据表格第一页

	$('#searchForm .layui-inline .layui-btn-group .searchItemMore').on('click',function() {
		if ($(this).hasClass('moreClose')) {
			$(this).removeClass('moreClose');
			$(this).addClass('moreOpen');
			$(this).find('i.layui-icon').html('&#xe61a;');
			$('#searchForm .moreSearchItem').attr('style','display:inline-block');
			if($(this).parent().parent().hasClass('searchBtGroupPC'))
			{
				let bt = $(this).parent().parent().next().find('.searchItemMore');
				bt.removeClass('moreClose');
				bt.addClass('moreOpen');
				bt.find('i.layui-icon').html('&#xe61a;');
			}
			if($(this).parent().parent().hasClass('searchBtGroupMobile'))
			{
				let bt = $(this).parent().parent().prev().find('.searchItemMore');
				bt.removeClass('moreClose');
				bt.addClass('moreOpen');
				bt.find('i.layui-icon').html('&#xe61a;');
			}
		}
		else
		{
			$(this).removeClass('moreOpen');
			$(this).addClass('moreClose');
			$(this).find('i.layui-icon').html('&#xe619;');
			$('#searchForm .moreSearchItem').attr('style','display:none');
			if($(this).parent().parent().hasClass('searchBtGroupPC'))
			{
				let bt = $(this).parent().parent().next().find('.searchItemMore');
				bt.removeClass('moreOpen');
				bt.addClass('moreClose');
				bt.find('i.layui-icon').html('&#xe619;');
			}
			if($(this).parent().parent().hasClass('searchBtGroupMobile'))
			{
				let bt = $(this).parent().parent().prev().find('.searchItemMore');
				bt.removeClass('moreOpen');
				bt.addClass('moreClose');
				bt.find('i.layui-icon').html('&#xe619;');
			}
		}
	});
});

var auto_initDataGrid = function(urlStr,currentPage){
	var laytpl = layui.laytpl;
	// 获取请求参数：1、翻页参数pageNum和pageSize，2、查询条件
	// var searchItem = $("#searchForm").serialize();//会将selection option中的第一个空值传递到服务端，服务端转数字类型时会出错
	let searchItem = "&";
	$.each($("#searchForm").find(":input"),function(i,v){
		var sformName = $.trim($(v).prop('name'));
		if(sformName)
			searchItem += sformName+"="+$.trim($(v).prop('value'))+"&";
	});
	if(urlStr.indexOf("?") > 0)
		urlStr += "&current="+currentPage+"&size="+window.pageSize+searchItem;
	else
		urlStr += "?current="+currentPage+"&size="+window.pageSize+searchItem;
	$.get({
		url:urlStr,
		success:function(data){
			var page = data;
			page.checkbox=(window.hasCheckbox===undefined) ? false : window.hasCheckbox;
			var allWidth = 0;
			var tableGridWidth = window.hasCheckbox ? $('#tableGrid').width()*0.99-49 : $('#tableGrid').width()*0.99;
			$.each(columns,function(ind,valu){allWidth += (valu.width) ? valu.width : 0;});
			allWidth = (allWidth==0) ? columns.length : allWidth;
			$.each(columns,function(ind,valu){if(valu.width) valu.width = valu.width/allWidth*tableGridWidth; else valu.width= 1/allWidth*tableGridWidth });
			page.columns=window.columns;
			page.noDataContent = (!window.noDataContent) ? '沒有相關數據' : noDataContent;
			page.title = (!window.title) ? '' : title;
			page.hasPager=(window.hasPager===undefined) ? true : window.hasPager;
			laytpl(tableTpl).render(page, function(html){
				tableGrid.innerHTML = html;
			});
			layui.form.render();
			window.pageSize=page.size;
			if(page.hasPager)
				auto_initPager(page);

			if(typeof findChildren === "function")
				findChildren();
			if(typeof pageReadyCallBack === "function")
				pageReadyCallBack();
		}
	});
}
// 页面加载完成后，搜索域内，日期元素绑定事件
function initDateInputForSearchForm(){
	var dates = $('#searchForm input[dateType="date"]');
	$.each(dates,function(){
		layui.laydate.render({
			elem: this
			, type: 'date'
			, theme: 'molv'
			, show: false
			, showBottom: false //showBottom
		});
	});
	var datetimes = $('#searchForm input[dateType="datetime"]');
	$.each(datetimes,function(){
		layui.laydate.render({
			elem: this
			, type: 'datetime'
			, theme: 'molv'
			, show: false
			, showBottom: true //showBottom
		});
	});
}
var auto_initPager = function(page)
{
	layui.use('laypage',function(){});
	window._pageNum = page.current;
	console.log(window._pageNum);
	try{
		layui.laypage.render({// 实例化分页,偶尔会出现layui.laypage没有加载上的情况
			elem: 'pager'
            ,layout:[ 'prev', 'page', 'next', 'skip']
			,curr:page.current
			,count:page.total
			,limit:page.size
			//,pages: page.pages //得到总页数
			//,skip: true
		});
	}
	catch(e)
	{
		console.log(e);
		layui.layer.msg(' server is not ready yet ! And the page will be reload after 2 second ',{icon:5,time:2000},function(){
			//window.location.reload();
		});
	}

	// 翻页事件手动绑定
	$('#pager .layui-laypage a').on('click',function(){
	 	auto_initDataGrid(urlStr,$(this).attr("data-page"));
	 });
	$('#pager button.layui-laypage-btn').on('click',function(){
		var skipNum = $('#pager span.layui-laypage-skip input').val();
		auto_initDataGrid(urlStr,skipNum);
	});
	$('#pager span.layui-laypage-skip input').on('keydown',function(e){
		if(e.keyCode===13)
			auto_initDataGrid(urlStr,$(this).val());
	});
}
var childClick = function(obj){
	if($(obj).hasClass('layui-form-checked'))
		$(obj).removeClass('layui-form-checked');
	else
		$(obj).addClass('layui-form-checked');
}
var parentClick = function(obj)
{
	
	let child = $('table.layui-table').find('tbody div.layui-form-checkbox');
	if(!$(obj).hasClass('layui-form-checked'))
	{
		$(obj).addClass('layui-form-checked');
		child.each(function(index, item){$(this).addClass('layui-form-checked');});
	}
	else
	{
		$(obj).removeClass('layui-form-checked');
		child.each(function(index, item){$(this).removeClass('layui-form-checked');});
	}
}

var getAllCheckedAttr = function()
{
	var ids = [];
	var child = $('table.layui-table').find('tbody div.layui-form-checked');
	child.each(function(index, item){
		let _thisId=$(this).attr('data-id');
		if(_thisId &&　_thisId!='undefined')ids.push(_thisId);
	});
	return ids;
}
var getAllCheckedObj = function()
{
	var objects = [];
	let child = $('table.layui-table').find('tbody div.layui-form-checked');
	child.each(function(index, item){
		objects.push($(this).parents('tr'));
	});
	return objects;
}
var openPage = function(urlStr,title,fullScreen,anim,width,height)
{
	if(width===undefined)width=window.screen.width*0.8;
	if(height===undefined)height=window.screen.height*0.9;
	if(isNaN(width))throw new Error(" width is not a number ");
	if(isNaN(height))throw new Error(" height is not a number ");
	if(width > window.screen.width)throw new Error(" width is too large ");
	if(height > window.screen.height)throw new Error(" height is too large ");
	if(isNaN(anim))anim = 3;

	var index = layui.layer.open({
		type: 2,// type=1 弹层为普通，不会请求链接
		title: title===undefined ? "  " : title,// 没有title也要占个位
		skin: 'layui-layer-molv',// title皮肤
		shadeClose: false,// 点击遮罩不关闭
		shade: true,// 遮罩父窗口
		maxmin: false, //开启最大化最小化按钮
		fixed:true,
		anim: anim,// 来点动画 1-从上中弹出，2-从下方弹出，3-从中间来，4-左下方旋出来，5-从中间来，6-抖出来，
		area: [width+'px',height+'px'],
		content: urlStr
	});
	if(fullScreen)layui.layer.full(index);// 弹出即全屏
}
var closeOpenPage=function(){
	layer.closeAll('iframe');
}
var del = function(id)
{
	layui.layer.confirm("您確定刪除該記錄？",{icon: 3, title:'提示'},function(){
		$.post({
			url:"delete",
			data:{"id":id},
			dataType:"json",
			success:function(data)
			{
				if(data.action==="success")
					layui.layer.alert("操作成功",{icon: 1, title:'提示'},function(index){
						window.parent.auto_initDataGrid(window.urlStr,window._pageNum);
                        layui.layer.close(index);
					});
				else
					layui.layer.alert( "操作失敗："+(data.msg!="操作失败") ? data.msg : "",{icon:5});
			}
		});
	},function(){});
}
