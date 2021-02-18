(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M51_logo");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("로고 변경");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Static("sta_logo_name","630","238","271","32",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_cm_box02L");
            obj.set_text("cocoaNewLogo.png");
            this.addChild(obj.name, obj);

            obj = new Static("Static07","521","238","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("현재 로고");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","521","207","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("로고 등록 날짜");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("sta_registe_date","630","207","376","32",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Button("btn_register","680","390","126","44",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("등록");
            this.addChild(obj.name, obj);

            obj = new Button("btn_fileUpload","900","240","106","30",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("찾아보기");
            this.addChild(obj.name, obj);

            obj = new Static("sta_logo","135","180","271","270",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M51_logo.xfdl", function() {

        this.btn_fileUpload_onclick = function(obj,e)
        {

        };

        this.M51_logo.onload = function(obj,e){
        	this.transaction(
          		"getAuth" // id
          		, "/admin/getAuth.nex" // url
        		, "" // inData
          		, "dsAuth=out_ds" // outData
         		, ""// strArg
          		, "fn_callback" // callback
          	);
        }

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.btn_fileUpload.addEventHandler("onclick",this.btn_fileUpload_onclick,this);
        };

        this.loadIncludeScript("M51_logo.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
