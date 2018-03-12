<#macro siteTitle>xxxx系統</#macro>
<#macro tplLeftTopBt >
<script id="leftTopBtGroupTpl" type="text/html" >
    {{#  layui.each(d, function(index, bt){  var id='';if(bt.id){id=bt.id;}
    let classes = ''; if(bt.classes){classes=bt.classes;}
    let style = ''; if(bt.style){style=bt.style;}
    let icon = ''; if(bt.icon){icon=bt.icon;}
    let clickEvent = ''; if(bt.clickEvent){clickEvent=bt.clickEvent;}
    }}
    <button class="layui-btn {{classes}}" id="{{id}}" style="{{style}}" {{# if(clickEvent){ }} onclick="{{clickEvent}}"  {{#  } }} >
        <i class="layui-icon">{{icon}}</i> {{bt.btName}}
    </button>
    {{#  }); }}
</script>
</#macro>
<#macro tplTableGrid >
<script id="tableTpl" type="text/html">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>{{d.title}}</legend>
    </fieldset>
    <table class="layui-table " lay-even lay-skin="primary">
        <thead>
        <tr>
            {{# if(d.checkbox===true){  }}
            <th style="text-align:center;">
                <div class="layui-unselect  layui-form-checkbox " lay-skin="primary" onclick="var $=layui.jquery;parentClick($(this));"><i class="layui-icon"></i></div>
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
        <tbody>
        {{#  layui.each(d.data, function(index, item){ }}
        <tr>
            {{# if(d.checkbox===true){ var _dataId='';if(item.id){_dataId=item.id;}  }}
            <td style="text-align:center;">
                <div class="layui-unselect  layui-form-checkbox" data-id="{{_dataId}}" lay-skin="primary" onclick="var $=layui.jquery;childClick($(this));"><i class="layui-icon"></i></div>
            </td>
            {{# }  }}
            {{# layui.each(d.columns, function(index, column){
            var _formatter=column.formatter,_thisField=column.field, _thisVa=item[_thisField],_thisClass='',_thisStyle='',_thisWidth='',_attrName='',_attrValue='';
            if(_formatter && typeof(_formatter)==='function' ){_thisVa = _formatter(_thisVa,item);}
            <#--可以定义模板，模板与formatter函数只能选择一个-->
            let _tpl = column.tpl;if(_tpl){layui.laytpl(document.getElementById(_tpl).innerHTML).render(item, function(html){_thisVa = html;});}else if(!_tpl && (_thisField==='op' || _thisField==='operation' || _thisField==='operate')){
                layui.laytpl(document.getElementById('defaultButtonTpl').innerHTML).render(item, function(html){_thisVa = html;});
            }
            if(column.classes){_thisClass=column.classes;}if(column.style){_thisStyle=column.style;}
            if(column.width){_thisWidth='width:'+column.width;} var hasAutoScreen='';if(column.autoScreen){hasAutoScreen=column.autoScreen;}
            if(column.attr){ _attrName=column.attr;_attrValue=item[_attrName] }
            }}
            <td style="text-align:{{column.align}};padding: 9px 0px;{{_thisStyle}}" {{# if(hasAutoScreen){ }}  {{hasAutoScreen}}  {{# } }} class="{{_thisClass}}"  {{# if(_attrName && _attrValue){ }} {{_attrName}}="{{_attrValue}}" {{# }}} >
                {{# if(typeof(_thisVa)!='undefined' && _thisVa != null){   }}
                <div class="layui-table-cell" style="text-align:{{column.align}};padding: 0 5px;height:100%;{{_thisWidth}}px;{{_thisStyle}}">{{_thisVa}}</div>
                {{# } }}
            </td>
            {{#  }); }}
        </tr>
        {{#  }); }}
        {{#  if(!d.data || d.data.length === 0){ var colspanNum=d.columns.length; if(d.checkbox===true){colspanNum+=1;}   }}
        <tr>
            <td colspan="{{colspanNum}}" style="text-align:center">
                {{d.noDataContent}}
            </td>
        </tr>
        {{#  } }}
        </tbody>
    </table>
    {{# if(d.hasPager){ }}
    <div id="pagerWarp" style="background-color: rgb(255,255,255);">
        <div id="pageerAssist" style="display: inline-block;position: absolute;margin: 10px 0 10px 10px;">
            <label style="display: inline;">每頁
                <select name="pageSizeSelect" class="" onchange="window.pageSize=layui.jquery(this).val();auto_initDataGrid(urlStr,1);" lay-ignore style="height:30px;">
                    <option value="10" {{# if(d.size===10) { }} selected  {{# } }} >10</option>
                    <option value="20" {{# if(d.size===20) { }} selected  {{# } }} >20</option>
                    <option value="50" {{# if(d.size===50) { }} selected  {{# } }} >50</option>
                    <option value="100" {{# if(d.size===100) { }} selected  {{# } }} >100</option>
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
    {{# if(d && d.length>0){ }}
    <div class="layui-form-item">
        {{#  layui.each(d, function(index, item){
        let labelClass="layui-form-label-samll"; if(item.labelClass){labelClass=item.labelClass;}
        let labelName=""; if(item.labelName){labelName=item.labelName;}
        let inputClass="layui-input-small";  if(item.type==='select'){inputClass="layui-select-small";} if(item.inputClass){inputClass+=" "+item.inputClass;}
        let style="";if(item.style){style=item.style;}
        let placeholder="";if(item.placeholder){placeholder=item.placeholder;}
        let formId="";if(item.formId){formId=item.formId;}
        let formName="";if(item.formName){formName=item.formName;}
        let laySearch=true;if(item.laySearch!=undefined){laySearch=item.laySearch;}
        let clickEvent="";if(item.clickEvent){clickEvent=item.clickEvent;}
        let value = "";if(item.value){value=item.value;}
        let layFilter="";if(item.layFilter){layFilter=item.layFilter;}
        }}
        {{# if(index<=1){ }}
        {{# if(item.type==='text'){ }}
        <div class="layui-inline" ><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
            <div class="layui-input-inline">
                <input type="text" id="{{formId}}" name="{{formName}}" class="layui-input {{inputClass}}" placeholder="{{placeholder}}"  {{# if(value){ }} value="{{value}}"  {{# } }} />
            </div>
        </div>
        {{#  } }}
        {{# if(item.type==='date' || item.type==='datetime'){ }}
        <div class="layui-inline" ><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
            <div class="layui-input-inline">
                <input type="text" dateType="{{item.type}}" id="{{formId}}" name="{{formName}}" class="layui-input {{inputClass}}" onclick="{{clickEvent}}"  placeholder="{{placeholder}}" {{# if(value){ }} value="{{value}}"  {{# } }} />
            </div>
        </div>
        {{#  } }}
        {{# if(item.type==='select'){ }}
        <div class="layui-inline">
            <label class="layui-form-label {{labelClass}}">{{labelName}}</label>
            <div class="layui-input-inline">
                <select id="{{formId}}" name="{{formName}}" {{# if(laySearch){ }} lay-search {{# } }} {{# if(layFilter){ }} lay-filter="{{layFilter}}" {{# } }}  class="{{inputClass}}">
                    {{# layui.each(item.options, function(index, opt){   }}
                    <option value="{{opt.v}}"  {{# if(opt.defaultSelect){ }} selected {{# } }} >{{opt.t}}</option>
                    {{#  }); }}
                </select>
            </div>
        </div>
        {{#  } }}
        {{# if(item.type==='textarea'){ }}
        <div class="layui-inline" ><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
            <div class="layui-input-block">
                <textarea id="{{formId}}" name="{{formName}}" class="layui-textarea {{inputClass}}" style="{{# if(style){ }} {{style}} {{# } }}" placeholder="{{placeholder}}"  {{# if(value){ }} value="{{value}}"  {{# } }} >{{value}}</textarea>
            </div>
        </div>
        {{#  } }}
        {{#  } }}
        {{#  }); }}
        {{#  layui.each(d, function(index, item){
        let labelClass="layui-form-label-samll"; if(item.labelClass){labelClass=item.labelClass;}
        let labelName=""; if(item.labelName){labelName=item.labelName;}
        let inputClass="layui-input-small";  if(item.type==='select'){inputClass="layui-select-small";} if(item.inputClass){inputClass+=" "+item.inputClass;}
        let style="";if(item.style){style=item.style;}
        let placeholder="";if(item.placeholder){placeholder=item.placeholder;}
        let formId="";if(item.formId){formId=item.formId;}
        let formName="";if(item.formName){formName=item.formName;}
        let laySearch=true;if(item.laySearch){laySearch=item.laySearch;}
        let clickEvent="";if(item.clickEvent){clickEvent=item.clickEvent;}
        let value = "";if(item.value){value=item.value;}var layFilter="";if(item.layFilter){layFilter=item.layFilter;}
        }}
        {{# if(index > 1){ }}
        <div style="display:none" class="moreSearchItem" >
            {{# if(item.type==='text'){ }}
            <div class="layui-inline" ><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
                <div class="layui-input-inline">
                    <input type="text" id="{{formId}}" name="{{formName}}" class="layui-input {{inputClass}}"  placeholder="{{placeholder}}" {{# if(value){ }} value="{{value}}"  {{# } }} />
                </div>
            </div>
            {{#  } }}
            {{# if(item.type==='date' || item.type==='datetime'){ }}
            <div class="layui-inline" ><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
                <div class="layui-input-inline">
                    <input type="text" dateType="{{item.type}}" id="{{formId}}" name="{{formName}}" class="layui-input {{inputClass}}" onclick="{{clickEvent}}"  placeholder="{{placeholder}}" {{# if(value){ }} value="{{value}}"  {{# } }} />
                </div>
            </div>
            {{#  } }}
            {{# if(item.type==='select'){ }}
            <div class="layui-inline">
                <label class="layui-form-label {{labelClass}}">{{labelName}}</label>
                <div class="layui-input-inline">
                    <select id="{{formId}}" name="{{formName}}" {{# if(laySearch){ }} lay-search {{# } }} {{# if(layFilter){ }} lay-filter="{{layFilter}}" {{# } }} class="{{inputClass}}">
                        {{# layui.each(item.options, function(index, opt){   }}
                        <option value="{{opt.v}}"  {{# if(opt.defaultSelect){ }} selected {{# } }} >{{opt.t}}</option>
                        {{#  }); }}
                    </select>
                </div>
            </div>
            {{#  } }}
            {{# if(item.type==='textarea'){ }}
            <div class="layui-inline" ><label class="layui-form-label {{labelClass}}" >{{labelName}}</label>
                <div class="layui-input-block">
                    <textarea id="{{formId}}" name="{{formName}}" class="layui-textarea {{inputClass}}"  style="{{# if(style){ }} {{style}} {{# } }}" placeholder="{{placeholder}}"  {{# if(value){ }} value="{{value}}"  {{# } }} >{{value}}</textarea>
                </div>
            </div>
            {{#  } }}
        </div>
        {{#  } }}
        {{#  }); }}
        <div class="layui-inline searchBtGroupPC" style="position: absolute;top: 10px;right: 5px;margin-right:0px;  " pc>
            {{# if(d && d.length>2){ }}
            <div id="" class="layui-btn-group" >
                <button type="button" class="layui-btn layui-btn-sm searchItemMore moreClose">更多<i class="layui-icon">&#xe619;</i></button>
                <button class="layui-btn layui-btn-sm" type="button" onclick="auto_initDataGrid(urlStr,1);">
                    <i class="layui-icon">&#xe615;</i> 搜索
                </button>
            </div>
            {{#  } }}
            {{# if(d && d.length<=2){ }}
            <button class="layui-btn layui-btn-sm" type="button" onclick="auto_initDataGrid(urlStr,1);">
                <i class="layui-icon">&#xe615;</i> 搜索
            </button>
            {{#  } }}
        </div>
        <#--<div class="layui-inline searchBtGroupMobile" style="position: absolute;top: 70px;right: 5px;margin-right:0px;  " mobile>
            {{# if(d && d.length>2){ }}
            <div id="" class="layui-btn-group" >
                <button type="button" class="layui-btn layui-btn-sm searchItemMore  moreClose">更多<i class="layui-icon">&#xe619;</i></button>
                <button class="layui-btn layui-btn-sm" type="button" onclick="auto_initDataGrid(urlStr,1);">
                    <i class="layui-icon">&#xe615;</i> 搜索
                </button>
            </div>
            {{#  } }}
            {{# if(d && d.length<=2){ }}
            <button class="layui-btn layui-btn-sm" type="button" onclick="auto_initDataGrid(urlStr,1);">
                <i class="layui-icon">&#xe615;</i> 搜索
            </button>
            {{#  } }}
        </div>-->
    </div>
    {{#  } }}
</script>
</#macro>
<#macro tplFrom >
<script id="formTpl" type="text/html" >
    {{# if(d && d.length>0){ }}
        {{# layui.each(d, function(index, item){  }}
            {{# if(layui.jquery.isArray(item)){    }}
                <div class="layui-form-item">
                    {{# layui.each(item, function(ind, ite){
                    let type=ite.type;
                    let formValue = ''; if(ite.value){formValue=ite.value;}

                    let formName=ite.formName;var formId='';if(ite.formId){formId=ite.formId;}
                    let labelName= ite.labelName;var layVerify='';if(ite.layVerify){layVerify=ite.layVerify;}
                    let placeholder='';if(ite.placeholder){placeholder=ite.placeholder;}
                    let options=[];if(ite.options){options=ite.options;}let filterName='';if(ite.filterName){filterName=ite.filterName;}
                    let layText='';if(ite.layText){layText=ite.layText;}let title='';if(ite.title){title=ite.title;}
                    let classes='';if(ite.classes){classes=ite.classes;}let style='';if(ite.style){style=ite.style;}
                    let laySkin='';if(ite.laySkin){laySkin=ite.laySkin;}let autocomplete='off';if(ite.autocomplete){autocomplete=ite.autocomplete;}
                    let clickEvent='';if(ite.clickEvent){clickEvent=ite.clickEvent;}
                    let readOnly=false;if(ite.readOnly){readOnly=ite.readOnly;}
                    let disabled=false;if(ite.disabled){disabled=ite.disabled;}
                    let onkeyup = '';if(ite.onkeyup){onkeyup=ite.onkeyup;}
                    let onpaste = '';if(ite.onpaste){onpaste=ite.onpaste;}
                    let maxlength='';if(ite.maxlength){maxlength=ite.maxlength}
                    }}

                        {{# if(type==='hidden'){ }} <input type="hidden" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} {{# if(formValue){ }}value="{{formValue}}" {{# }}}  /> {{# } }}
                        {{# if(labelName){ }}
                        <div class="layui-inline">
                            {{# if(type!='button'){  }}
                            <label class="layui-form-label">{{labelName}}</label>
                            {{# } }}
                            <div class="layui-input-inline">
                                {{# if(type==='textarea'){  }}
                                <textarea {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }}  {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }}  class="layui-textarea {{classes}} {{# if(disabled || readOnly){ }} layui-disabled {{#}}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }} {{# if(maxlength){ }} maxlength="{{maxlength}}" {{#}}} >{{formValue}}</textarea>
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
                                <input {{# if(placeholder){ }}placeholder="{{placeholder}}"{{# } }} type="{{type}}" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }} autocomplete="{{autocomplete}}" {{# if(layVerify){ }}lay-verify="{{layVerify}}" {{# } }}  class="layui-input {{classes}} {{# if(disabled || readOnly){}}layui-disabled{{#}}}" {{# if(style){}}style="{{style}}"{{#}}} {{# if(formValue){ }}value="{{formValue}}" {{# }}} {{# if(clickEvent){ }}onclick="{{clickEvent}}" {{# } }} {{# if(readOnly){ }} readOnly {{# } }} {{# if(disbaled){ }} disbaled {{# } }}/>
                                {{# } }}
                                {{# if(type==='file'){ var layType='';if(ite.layType){layType=ite.layType;} if(!classes){classes='layui-upload-file'}  }}
                                <input type="{{type}}" {{# if(formName){}} name="{{formName}}" {{#}}} {{# if(formId){ }}id="{{formId}}"{{# } }}  {{# if(layType){ }}lay-type="{{layType}}" {{# } }}  class="{{classes}} " />
                                {{# } }}
                                {{# if(type==='html'){   }}
                                    {{formValue}}
                                {{# } }}
                            </div>
                        </div>
                        {{# } }}
                    {{#  }) }}
                </div>
            {{# } }}
            {{# if(item && typeof(item)==='object' && !item.length && !layui.jquery.isArray(item) && Object.prototype.toString.call(item).toLowerCase() == "[object object]"  ){
                let type=item.type;
                let formValue = ''; if(item.value){formValue=item.value;}
                let formName=item.formName;var formId='';if(item.formId){formId=item.formId;}
                let labelName= item.labelName;var layVerify='';if(item.layVerify){layVerify=item.layVerify;}
                let placeholder='';if(item.placeholder){placeholder=item.placeholder;}
                let options=[];if(item.options){options=item.options;}let filterName='';if(item.filterName){filterName=item.filterName;}
                let layText='';if(item.layText){layText=item.layText;}let title='';if(item.title){title=item.title;}
                let classes='';if(item.classes){classes=item.classes;}let style='';if(item.style){style=item.style;}
                let laySkin='';if(item.laySkin){laySkin=item.laySkin;}let autocomplete='off';if(item.autocomplete){autocomplete=item.autocomplete;}
                let clickEvent='';if(item.clickEvent){clickEvent=item.clickEvent;}
                let readOnly=false;if(item.readOnly){readOnly=item.readOnly;}
                let disabled=false;if(item.disabled){disabled=item.disabled;}
                let onkeyup = '';if(item.onkeyup){onkeyup=item.onkeyup;}
                let onpaste = '';if(item.onpaste){onpaste=item.onpaste;}
                let maxlength='';if(item.maxlength){maxlength=item.maxlength}
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
                                      {{# if(readOnly){ }} readOnly {{# } }} {{# if(disabled){ }} disabled {{# } }} {{# if(maxlength){ }} maxlength="{{maxlength}}" {{#}}}>{{formValue}}</textarea>
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
                            {{# if(type==='html'){   }}
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
        <button class="layui-btn layui-btn-sm" onclick="openPage('edit?id={{d.id}}','編輯',true,5);" title="編輯">
            <i class="layui-icon">&#xe642;</i> 編輯
        </button>
        <button class="layui-btn layui-btn-sm layui-btn-danger" onclick="del('{{d.id}}');" title="刪除">
            <i class="layui-icon">&#xe640;</i>
        </button>
    </div>
</script>
</#macro>