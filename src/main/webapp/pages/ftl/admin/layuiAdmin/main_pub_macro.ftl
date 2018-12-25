<#macro siteTitle>多多旺鋪管理系統</#macro>
<#macro tplLeftTopBt >
<script id="leftTopBtGroupTpl" type="text/html" >
    {{#  layui.each(d, function(index, bt){  var id='';if(bt.id){id=bt.id;}
    var classes = ''; if(bt.classes){classes=bt.classes;}
    var style = ''; if(bt.style){style=bt.style;}
    var icon = ''; if(bt.icon){icon=bt.icon;}
    var clickEvent = ''; if(bt.clickEvent){clickEvent=bt.clickEvent;}
    }}
    <button class="layui-btn {{classes}}" id="{{id}}" style="{{style}}" {{# if(clickEvent){ }} onclick="{{clickEvent}}"  {{#  } }} >
        <i class="layui-icon">{{icon}}</i> {{bt.btName}}
    </button>
    {{#  }); }}
</script>
</#macro>
<#macro tplTableGrid >
<script id="tableTpl" type="text/html">
    <table class="layui-table " lay-even lay-skin="primary" style="display: block;">
        <thead>
        <tr>
            {{# if(d.checkbox===true){  }}
            <th style="text-align:center;width: 49px;padding: 0;">
                <div class="layui-unselect  layui-form-checkbox " lay-skin="primary" onclick="parentClick($(this));"><i class="layui-icon"></i></div>
            </th>
            {{# }  }}
            {{#  layui.each(d.columns, function(index, item){ var _thisClass='',_thisStyle='',_thisWidth=''; var hasAutoScreen='';if(item.autoScreen){hasAutoScreen=item.autoScreen;}
            if(item.classes){_thisClass=item.classes;}if(item.style){_thisStyle=item.style;}if(item.width){_thisWidth='width:'+item.width;}}}
            <th style="text-align:center;{{_thisStyle}} padding: 9px 0px;"  {{# if(hasAutoScreen){ }}  {{hasAutoScreen}}  {{# } }} class="{{_thisClass}}">
                <div class="layui-table-cell" style="font-weight: bold;text-align:center;padding: 0 5px;height:100%;{{_thisWidth}}px;{{_thisStyle}}">{{item.title}}</div>
            </th>
            {{#  }); }}
        </tr>
        </thead>
    </table>
    {{# let tableDataHeight=$('.layui-side.layui-bg-black',window.top.document).height()-42; let sh = 0;if($('#searchArea') && $('#searchArea').height() > 0){sh = $('#searchArea').height()+100;} tableDataHeight -= sh; }}
    <table class="layui-table layui-table-data" lay-even lay-skin="primary" style="display: block;overflow-y: auto;overflow-x: hidden;max-height: {{tableDataHeight}}px;">
        {{# }}
        <tbody >
        {{#  layui.each(d.result, function(index, item){ }}
        <tr>
            {{# if(d.checkbox===true){ var _dataId='';if(item.id){_dataId=item.id;}  }}
            <td style="text-align:center;width: 49px;padding: 0;">
                <div class="layui-unselect  layui-form-checkbox" style="text-align:center;width: 49px;" data-id="{{_dataId}}" lay-skin="primary" onclick="var $=layui.jquery;childClick($(this));"><i class="layui-icon" style="margin-left: 13px;"></i></div>
            </td>
            {{# }  }}
            {{# layui.each(d.columns, function(index, column){
            let _formatter=column.formatter,_thisField=column.field, _thisVa=item[_thisField],_thisClass='',_thisStyle='',_thisWidth='',_attrName='',_attrValue='';
            if(_formatter && typeof(_formatter)==='function' ){_thisVa = _formatter(_thisVa,item);}
            else{
            <#--可以定义模板，模板与formatter函数只能选择一个-->
                let _tpl = column.tpl;if(_tpl){layui.laytpl(document.getElementById(_tpl).innerHTML).render(item, function(html){_thisVa = html;});}else if(!_tpl && (_thisField==='op' || _thisField==='operation' || _thisField==='operate')){
                    let pathname = window.location.pathname; item.pathname = pathname.substring(0,pathname.lastIndexOf("/"));
                    layui.laytpl(document.getElementById('defaultButtonTpl').innerHTML).render(item, function(html){_thisVa = html;});
                }
            }
            if(column.classes){_thisClass=column.classes;}if(column.style){_thisStyle=column.style;}
            if(column.width){_thisWidth='width:'+column.width;} var hasAutoScreen='';if(column.autoScreen){hasAutoScreen=column.autoScreen;}
            if(column.attr){ _attrName=column.attr;_attrValue=item[_attrName] };if(!column.align){column.align='center';};
            }}
            <td style="text-align:{{column.align}};padding: 5px 0px;{{_thisStyle}}" {{# if(hasAutoScreen){ }}  {{hasAutoScreen}}  {{# } }} class="{{_thisClass}}"  {{# if(_attrName && _attrValue){ }} {{_attrName}}="{{_attrValue}}" {{# }}} >
                <div class="layui-table-cell" style="text-align:{{column.align}};padding: 0 5px;height:100%;{{_thisWidth}}px;{{_thisStyle}}">{{# if(typeof(_thisVa)!='undefined' && _thisVa != null){   }}{{_thisVa}} {{# } }}</div>
            </td>
            {{#  }); }}
        </tr>
        {{#  }); }}
        {{#  if(!d.result || d.result.length === 0){ var colspanNum=d.columns.length; if(d.checkbox===true){colspanNum+=1;}   }}
        <tr>
            <td colspan="{{colspanNum}}" style="text-align:center;width: 100%;">
                <div class="layui-table-cell" style="width:{{# let tablewith = $('#navbar').width(); }}{{tablewith}}{{#  }}px;">{{d.noDataContent}}</div>
            </td>
        </tr>
        {{#  } }}
        </tbody>
    </table>
    {{# if(d.hasPager && d.result && d.result.length > 0 ){ }}
    <div id="pagerWarp" style="background-color: rgb(255,255,255); position: sticky;">
        <div id="pageerAssist" style="display: inline-block;position: absolute;margin: 10px 0 10px 10px;">
            <label style="display: inline;">每頁
                <select name="pageSizeSelect" class="" onchange="window._pageSize=layui.jquery(this).val();auto_initDataGrid(urlStr,_startPageNum);" lay-ignore style="height:30px;">
                    {{#  layui.each(d['pageerOptions'], function(index, item){ }}
                    <option value="{{item}}" {{# if(d.pageSize===item) { }} selected  {{# } }} >{{item}}</option>
                    {{# }); }}
                </select>
                條記錄，總計{{d.total}}條記錄 共{{d.pages}}頁</label>
        </div>
        <div id="pager" style="display: inline-block;position: absolute;right:10px"></div>
    </div>
    {{#  } }}
</script>
</#macro>
<#macro tplSearchFrom >
<script id="searchFormTpl" type="text/html" >
    {{# if(layui.jquery.isArray(d)){ var datas=new Array(Math.ceil(d.length/4));
    for(var i = 0;i < datas.length;i++) {datas[i] = new Array();}
    for(var j = 0;j < d.length;j++) {datas[parseInt(j/4)][j%4] = d[j];}
    }}
    {{# layui.each(datas,function(outterIndex,outterData){ }}
    <div class="layui-form-item {{# if(outterIndex>0){ }}moreSearchItem{{#}}}" style="{{# if(outterIndex>0){ }}display:none;{{#}}}margin:0 0 5px; 50px;" >
        {{# layui.each(outterData, function(innerIndex, inner){
        var labelClass="layui-form-label-samll"; if(inner.labelClass){labelClass=inner.labelClass;}
        var labelName=""; if(inner.labelName){labelName=inner.labelName;}
        var inputClass="layui-input-small";  if(inner.type==='select'){inputClass="layui-select-small";} if(inner.inputClass){inputClass=inputClass+" "+inner.inputClass;}
        var style="";if(inner.style){style=inner.style;}
        var placeholder="";if(inner.placeholder){placeholder=inner.placeholder;}
        var formId="";if(inner.formId){formId=inner.formId;}
        var formName="";if(inner.formName){formName=inner.formName;}
        var laySearch=true;if(inner.laySearch!=undefined){laySearch=inner.laySearch;}
        var clickEvent="";if(inner.clickEvent){clickEvent=inner.clickEvent;}
        var value = "";if(inner.value){value=inner.value;}
        var layFilter="";if(inner.layFilter){layFilter=inner.layFilter;}
        }}

        {{# if(inner.type==='text'){ }}
        <div class="layui-inline" style="margin-right:0;"><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
            <div class="layui-input-inline">
                <input type="text" id="{{formId}}" name="{{formName}}" class="layui-input {{inputClass}}" placeholder="{{placeholder}}"  {{# if(value){ }} value="{{value}}"  {{# } }} />
            </div>
        </div>
        {{#  } }}
        {{# if(inner.type==='date' || inner.type==='datetime'){ }}
        <div class="layui-inline" style="margin-right:0;"><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
            <div class="layui-input-inline">
                <input type="text" dateType="{{item.type}}" id="{{formId}}" name="{{formName}}" class="layui-input {{inputClass}}" onclick="{{clickEvent}}"  placeholder="{{placeholder}}" {{# if(value){ }} value="{{value}}"  {{# } }} />
            </div>
        </div>
        {{#  } }}
        {{# if(inner.type==='select'){ let defaultValue=inner.defaultValue; }}
        <div class="layui-inline" style="margin-right:0;">
            <label class="layui-form-label {{labelClass}}">{{labelName}}</label>
            <div class="layui-input-inline">
                <select id="{{formId}}" name="{{formName}}" {{# if(laySearch){ }} lay-search {{# } }} {{# if(layFilter){ }} lay-filter="{{layFilter}}" {{# } }}  class="{{inputClass}}">
                    {{# layui.each(inner.options, function(index, opt){   }}
                    <option value="{{opt.v}}"  {{# if(opt.defaultSelect||opt.v==defaultValue){ }} selected {{# } }} >{{opt.t}}</option>
                    {{#  }); }}
                </select>
            </div>
        </div>
        {{#  } }}
        {{# if(inner.type==='textarea'){ }}
        <div class="layui-inline" style="margin-right:0;"><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
            <div class="layui-input-block">
                <textarea id="{{formId}}" name="{{formName}}" class="layui-textarea {{inputClass}}" style="{{# if(style){ }} {{style}} {{# } }}" placeholder="{{placeholder}}"  {{# if(value){ }} value="{{value}}"  {{# } }} >{{value}}</textarea>
            </div>
        </div>
        {{#  } }}

        {{#   }); }}

        {{# if(outterIndex==0){ }}
        <div class="layui-inline searchBtGroupPC" style="position: absolute;top: 0px;right: 5px;margin-right:0px;  " pc>
            {{# if(datas && datas.length>1){ }}
            <div id="" class="layui-btn-group" >
                <button type="button" class="layui-btn layui-btn-sm searchItemMore moreClose">更多<i class="layui-icon">&#xe619;</i></button>
                <button class="layui-btn layui-btn-sm" type="button" onclick="auto_initDataGrid(urlStr,1);">
                    <i class="layui-icon">&#xe615;</i> 搜索
                </button>
            </div>
            {{#  } }}
            {{# if(datas.length==1){ }}
            <button class="layui-btn layui-btn-sm" type="button" onclick="auto_initDataGrid(urlStr,1);">
                <i class="layui-icon">&#xe615;</i> 搜索
            </button>
            {{#  } }}
        </div>
        {{#}}}

    </div>
    {{# }); }}


    {{#}}}
</script>
</#macro>
<#macro tplFrom >
<script id="formTpl" type="text/html" >
    {{# if(d && d.length>0){ }}
        {{# layui.each(d, function(index, item){  }}
            {{# if(layui.jquery.isArray(item)){    }}
                <div class="layui-form-item">
                    {{# layui.each(item, function(ind, ite){
                    var type = ite.type;
                    var formValue = ''; if(ite.value){formValue=ite.value;}
                    if(type==='html'){
                        let _tpl = ite.tpl;if(_tpl){layui.laytpl(document.getElementById(_tpl).innerHTML).render(ite.value, function(html){formValue = html;});}
                    }
                    var formName=ite.formName;var formId='';if(ite.formId){formId=ite.formId;}
                    var labelName= ite.labelName;var layVerify='';if(ite.layVerify){layVerify=ite.layVerify;}
                    var placeholder='';if(ite.placeholder){placeholder=ite.placeholder;}
                    var options=[];if(ite.options){options=ite.options;}var filterName='';if(ite.filterName){filterName=ite.filterName;}
                    var layText='';if(ite.layText){layText=ite.layText;}var title='';if(ite.title){title=ite.title;}
                    var classes='';if(ite.classes){classes=ite.classes;}var style='';if(ite.style){style=ite.style;}
                    var laySkin='';if(ite.laySkin){laySkin=ite.laySkin;}var autocomplete='off';if(ite.autocomplete){autocomplete=ite.autocomplete;}
                    var clickEvent='';if(ite.clickEvent){clickEvent=ite.clickEvent;}
                    var readOnly=false;if(ite.readOnly){readOnly=ite.readOnly;}
                    var disabled=false;if(ite.disabled){disabled=ite.disabled;}
                    var onkeyup = '';if(ite.onkeyup){onkeyup=ite.onkeyup;}
                    var onpaste = '';if(ite.onpaste){onpaste=ite.onpaste;}
                    var maxlength='';if(ite.maxlength){maxlength=ite.maxlength}
                    }}

                        {{# if(type==='hidden'){ }} <input type="hidden" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} {{# if(formValue){ }}value="{{formValue}}" {{# }}}  /> {{# } }}
                        {{# if(labelName){ }}
                        <div class="layui-inline">
                            {{# if(type!='button'){  }}
                            <label class="layui-form-label">{{labelName}}</label>
                            {{# } }}
                            <div class="layui-input-inline">
                                {{# if(type==='textarea'){  }}
                                <textarea {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }}  {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }}  class="layui-textarea {{classes}} {{# if(disabled || readOnly){ }} layui-disabled {{#}}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }} {{# if(maxlength){ }} maxlength="{{maxlength}}" oninput="var $=layui.jquery;changeLimit($(this));" {{#}}} >{{formValue}}</textarea>
                                {{# } }}
                                {{# if(type==='textEdit'){  }}
                                <textarea {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }} class="layui-textarea layui-hide  {{classes}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} >{{formValue}}</textarea>
                                {{# } }}
                                {{# if(type==='text'){  }}
                                <input {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} type="text" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}"{{# } }} class="layui-input {{classes}} {{# if(disabled || readOnly){ }} layui-disabled {{#}}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }} {{# if(onkeyup){ }} onkeyup="{{onkeyup}}" {{#}}} {{# if(onpaste){ }} onpaste="{{onpaste}}" {{#}}} {{# if(maxlength){ }} maxlength="{{maxlength}}" {{#}}}/>
                                {{# } }}
                                {{# if(type==='radio'){  }}
                                    {{#  layui.each(options, function(index, option){  }}
                                    <input type="radio" {{# if(formName){}} name="{{formName}}" {{#}}} value="{{option.v}}" title="{{option.t}}" {{# if(formValue && formValue==option.v){ }}checked {{# }}}  {{# if(!formValue && option.defaultSelect){ }} checked {{# } }} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(option.disabled){ }} disabled {{# } }} />
                                    {{# }) }}
                                {{# } }}
                                {{# if(type==='select'){ var laySearch=true;if(ite.laySearch){laySearch=ite.laySearch;} }}
                                <select {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} {{# if(filterName){}}lay-filter="{{filterName}}"{{#}}}  {{# if(layVerify){ }}lay-verify="{{layVerify}}"{{# } }} {{# if(laySearch){ }}lay-search {{# } }} class="{{classes}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(disabled){ }} disabled {{# } }}>
                                {{#  layui.each(options, function(index, option){ var opStyle='';if(option.style){opStyle=option.style;}  }}
                                    <option value="{{option.v}}" {{# if(opStyle){ }} style="{{opStyle}}" {{# } }}  {{# if(formValue && formValue==option.v){ }} selected {{# }}} {{# if(!formValue && option.defaultSelect){ }} selected {{# } }}{{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(option.disabled){ }} disabled {{# } }}>{{option.t}}</option>
                                {{# }) }}
                                 </select>
                                {{# } }}
                                {{# if(type==='tel' || type==='password'){ }}
                                <input {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} type="{{type}}" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }}  class="layui-input {{classes}} {{# if(disabled || readOnly){}}layui-disabled{{#}}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }}/>
                                {{# } }}
                                {{# if(type==='file'){ var layType='';if(ite.layType){layType=ite.layType;} if(!classes){classes='layui-upload-file'}  }}
                                <input type="{{type}}" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }}  {{# if(layType){ }}lay-type="{{layType}}" {{# } }}  class="{{classes}} " />
                                {{# } }}
                                {{# if(type==='html'){  }}
                                    {{formValue}}
                                {{# } }}
                            </div>
                        </div>
                        {{# } }}
                    {{#  }) }}
                </div>
            {{# } }}
            {{# if(item && typeof(item)==='object' && !item.length && !layui.jquery.isArray(item) && Object.prototype.toString.call(item).toLowerCase() == "[object object]"  ){
                var type=item.type;
                var formValue = ''; if(item.value){formValue=item.value;}
                if(type==='html'){
                    let _tpl = item.tpl;if(_tpl){layui.laytpl(document.getElementById(_tpl).innerHTML).render(item.value, function(html){formValue = html;});}
                }
                var formName=item.formName;var formId='';if(item.formId){formId=item.formId;}
                var labelName= item.labelName;var layVerify='';if(item.layVerify){layVerify=item.layVerify;}
                var placeholder='';if(item.placeholder){placeholder=item.placeholder;}
                var options=[];if(item.options){options=item.options;}var filterName='';if(item.filterName){filterName=item.filterName;}
                var layText='';if(item.layText){layText=item.layText;}var title='';if(item.title){title=item.title;}
                var classes='';if(item.classes){classes=item.classes;}var style='';if(item.style){style=item.style;}
                var laySkin='';if(item.laySkin){laySkin=item.laySkin;}var autocomplete='off';if(item.autocomplete){autocomplete=item.autocomplete;}
                var clickEvent='';if(item.clickEvent){clickEvent=item.clickEvent;}
                var readOnly=false;if(item.readOnly){readOnly=item.readOnly;}
                var disabled=false;if(item.disabled){disabled=item.disabled;}
                var onkeyup = '';if(item.onkeyup){onkeyup=item.onkeyup;}
                var onpaste = '';if(item.onpaste){onpaste=item.onpaste;}
                var maxlength='';if(item.maxlength){maxlength=item.maxlength}
            }}
            {{# if(type==='hidden'){ }} <input type="hidden" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} {{# if(formValue){ }}value="{{formValue}}" {{# }}}  /> {{# } }}
                {{# if(type!='hidden'){ }}
                    <div class="layui-form-item {{# if(type==='textarea' || type==='textEdit'){ }} layui-form-text {{# } }} ">
                        {{# if(labelName){  }}
                        <label class="layui-form-label">{{labelName}}</label>
                        {{# } }}
                        <div class="layui-input-block" {{# if(type==='button'){  }} style="text-align: center" {{# } }} >
                            {{# if(type==='textarea'){  }}
                            <textarea {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }}
                                      autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }}
                                      class="layui-textarea {{classes}} {{# if(disabled || readOnly){ }} layui-disabled {{#}}}" {{# if(style){}}style="{{style}}"{{#}}}
                                      {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }}
                                      {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }} {{# if(maxlength){ }} maxlength="{{maxlength}}" oninput="var $=layui.jquery;changeLimit($(this));" {{#}}}>{{formValue}}</textarea>
                            {{# } }}
                            {{# if(type==='textEdit'){  }}
                            <textarea {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }} class="layui-textarea layui-hide  {{classes}} {{# if(disabled){ }} layui-disabled {{#}}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }}>{{formValue}}</textarea>
                            {{# } }}
                            {{# if(type==='text'){  }}
                            <input {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} type="text" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}"{{# } }} class="layui-input {{classes}} {{# if(disabled||readOnly){ }} layui-disabled {{#}}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }} {{# if(onkeyup){ }} onkeyup="{{onkeyup}}" {{#}}} {{# if(onpaste){ }} onpaste="{{onpaste}}" {{#}}} {{# if(maxlength){ }} maxlength="{{maxlength}}" {{#}}}/>
                            {{# } }}
                            {{# if(type==='radio'){  }}
                            {{#  layui.each(options, function(index, option){  }}
                            <input type="radio" {{# if(formName){}} name="{{formName}}" {{#}}} value="{{option.v}}" title="{{option.t}}" {{# if(formValue && formValue==option.v){ }}checked {{# }}}  {{# if(!formValue && option.defaultSelect){ }} checked {{# } }} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(option.disabled){ }} disabled {{# } }} />
                            {{# }) }}
                            {{# } }}
                            {{# if(type==='select'){ var laySearch=true;if(item.laySearch){laySearch=ite.laySearch;} }}
                            <select {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} {{# if(filterName){}}lay-filter="{{filterName}}"{{#}}} {{# if(layVerify){ }}lay-verify="{{layVerify}}"{{# } }} {{# if(laySearch){ }}lay-search {{# } }} class="{{classes}}" style="{{style}}" {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(disabled){ }} disabled {{# } }} {{# if(formValue){ }}value="{{formValue}}" {{# }}} >
                                {{#  layui.each(options, function(index, option){ var opStyle='';if(option.style){opStyle=option.style;} }}
                                <option value="{{option.v}}" {{# if(opStyle){ }} style="{{opStyle}}" {{# } }} {{# if(formValue && formValue==option.v){ }} selected {{# }}} {{# if(!formValue && option.defaultSelect){ }} selected {{# } }} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(option.disabled){ }} disabled {{# } }}>{{option.t}}</option>
                                {{# }) }}
                            </select>
                            {{# } }}
                            {{# if(type==='tel' || type==='password'){ }}
                            <input {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} type="{{type}}" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }}  class="layui-input {{classes}} {{# if(disabled||readOnly){ }} layui-disabled {{#}}}" {{# if(style){ }}style="{{style}}"{{# } }} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }}/>
                            {{# } }}
                            {{# if(type==='file'){ var layType='';if(item.layType){layType=item.layType;} if(!classes){classes='layui-upload-file'}  }}
                            <input type="{{type}}" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }}  {{# if(layType){ }}lay-type="{{layType}}" {{# } }}  class="{{classes}} " />
                            {{# } }}
                            {{# if(type==='html'){  }}
                            {{formValue}}
                            {{# } }}
                            {{# if(type==='button'){  }}
                                {{#  layui.each(options, function(index, option){  }}
                                    <button class="layui-btn  {{# if(option.classes){  }} {{option.classes}} {{# } }}"
                                            {{# if(option.type){  }} type="{{option.type}}" {{# } }}
                                            {{# if(option.clickEvent){  }} onclick="{{option.clickEvent}}" {{# } }}
                                            {{# if(option.btId){  }} id="{{option.btId}}" {{# } }}
                                            {{# if(option.style){  }} style="{{option.style}}" {{# } }}
                                            {{# if(option.filterName){  }} lay-filter="{{option.filterName}}" {{# } }}
                                            {{# if(option.laySubmit){  }} lay-submit {{# } }} >{{option.btName}}</button>
                                {{# }) }}
                            {{# } }}
                        </div>
                    </div>
                {{# } }}
            {{# } }}
        {{#  }) }}
    {{# } }}
</script>
</#macro>
<#macro defaultButtonTpl>
<script type="text/html" id="defaultButtonTpl">
    <div class="layui-btn-group">
        <button class="layui-btn layui-btn-sm" onclick="openPage('{{d.pathname}}/edit?id={{d.id}}','',false,5);" title="">
            <i class="layui-icon">&#xe642;</i> 編輯
        </button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="del('{{d.id}}');" title="刪除">
            <i class="layui-icon">&#xe640;</i>
        </button>
    </div>
</script>
</#macro>