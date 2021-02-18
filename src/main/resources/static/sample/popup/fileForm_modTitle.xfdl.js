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
                this._setFormPosition(310,440);
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
            obj.set_text("양식 분류 명");
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

            obj = new Button("btn_cancel","20","370","112","46",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("취소");
            this.addChild(obj.name, obj);

            obj = new Button("btn_add","160","370","112","46",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("등록");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00_00","10","274","71","36",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_text("등록 정보");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00_00_00","10","314","71","36",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_text("수정 정보");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","0","-5","310","44",null,null,null,null,null,null,this);
            obj.set_taborder("9");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.addChild(obj.name, obj);

            obj = new Static("sta_made_date","91","274","196","36",null,null,null,null,null,null,this);
            obj.set_taborder("10");
            this.addChild(obj.name, obj);

            obj = new Static("sta_mod_date","90","314","196","36",null,null,null,null,null,null,this);
            obj.set_taborder("11");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",310,440,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("fileForm_modTitle.xfdl", function() {

        this.fileForm_modTitle_onload = function(obj,e)
        {

        	var title = this.parent.title;
        	var contents = this.parent.contents;
        	var made_date = this.parent.made_date.substr(0,10);
        	if(this.parent.mod_date==undefined){
        	}else{
        		var mod_date=this.parent.made_date.substr(0,10);
        		this.sta_mod_date.set_text(mod_date);
        	}
        	this.Edit00.set_value(title);
        	this.TextArea00.set_value(contents);
        	this.sta_made_date.set_text(made_date);

        };

        this.btn_cancel_onclick = function(obj,e)
        {
        	this.close("cancel");
        };

        this.btn_add_onclick = function(obj,e)
        {
        	var title = this.Edit00.value;
        	var contents = this.TextArea00.value;
        	var args = title +"|"+contents;
        	this.close(args);
        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.fileForm_modTitle_onload,this);
            this.Edit00.addEventHandler("onchanged",this.Edit00_onchanged,this);
            this.btn_cancel.addEventHandler("onclick",this.btn_cancel_onclick,this);
            this.btn_add.addEventHandler("onclick",this.btn_add_onclick,this);
        };

        this.loadIncludeScript("fileForm_modTitle.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
