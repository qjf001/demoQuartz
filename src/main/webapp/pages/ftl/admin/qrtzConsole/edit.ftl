<script type="text/javascript">
    var formRows = [
        [
            {type:"hidden",formName:"id",labelName:"",value:"${data.id}"},
            {type:"hidden",formName:"status",labelName:"",value:"<#if data.id>${data.status}<#else>2</#if>"}
        ],
        {type:"text",formName:"name",labelName:"任務名稱",layVerify:"required",value:"${data.name}"},
        {type:"text",formName:"nameEn",labelName:"任務名稱(英文)",layVerify:"required",value:"${data.nameEn}"},
        {type:"text",formName:"fullClassName",labelName:"任務類全名",layVerify:"required",value:"<#if data.fullClassName>${data.fullClassName}<#else>com.qjf.quartz.job.</#if>"},
        {type:"text",formName:"cron",labelName:"cron表達式",layVerify:"required",value:"${data.cron}"},
        {type:"textarea",formName:"memo",labelName:"備註",value:`${data.memo}`,maxlength:255,style:'height:200px;'}
    ];
</script>