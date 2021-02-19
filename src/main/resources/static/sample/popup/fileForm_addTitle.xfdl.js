(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("fileForm_addTitle");
            this.set_titletext("New Form");
            this.set_scrolltype("none");
            this.set_scrollbartype("none");
            if (Form == this.constructor)
            {
                this._setFormPosition(310,400);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","-780",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("양식 분류 추가");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","10","44","120","36",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("양식 분류 명 *");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00","10","110","120","36",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("설명");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00","91","52","199","26",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            this.addChild(obj.name, obj);

            obj = new TextArea("TextArea00","91","120","199","144",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            this.addChild(obj.name, obj);

            obj = new Button("btn_cancel","30","317","112","46",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("취소");
            this.addChild(obj.name, obj);

            obj = new Button("btn_add","160","317","112","46",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("등록");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","0","4","310","36",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_text("");
            this.addChild(obj.name, obj);

            obj = new Static("sta_titleErrMsg","91","88","201","24",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_color("red");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",310,400,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("fileForm_addTitle.xfdl", function() {
        this.btn_cancel_onclick = function(obj,e)
        {
        	this.close("cancel");
        };

        this.btn_add_onclick = function(obj,e)
        {
        	var title = this.Edit00.value;
        	var contents = this.TextArea00.value;

        	if(title==null){
        		this.sta_titleErrMsg.set_text("양식 분류명을 작성해주세요.");
        		this.Edit00.setFocus(true);
        		return;
        	}else{
        		this.sta_titleErrMsg.set_text("");
        	}

        	this.transaction(
        		"tp_getFormInfoByCode" //1. strsvcid
        		,"/nexTemp/tp_titleAdd.nex" //2.strurl
        		,"" //3.strInDatasets Sds=Fds:U :A :
        		,"" //4.strOutDatasets
        		,"title='"+title+"' contents='"+contents+"'" //5.strArgument
        		,"fn_addListCallBack" //6.strCallbackFunc
        	);
        };

        this.fn_addListCallBack=function(id,msg){
        	this.close(msg);
        }



        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.Edit00.addEventHandler("onchanged",this.Edit00_onchanged,this);
            this.btn_cancel.addEventHandler("onclick",this.btn_cancel_onclick,this);
            this.btn_add.addEventHandler("onclick",this.btn_add_onclick,this);
        };

        this.loadIncludeScript("fileForm_addTitle.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
