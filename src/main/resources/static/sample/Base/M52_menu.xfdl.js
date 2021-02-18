(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M52_menu");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_sidebar", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"mid_code\" type=\"INT\" size=\"256\"/><Column id=\"mid_name\" type=\"STRING\" size=\"256\"/><Column id=\"sub_name\" type=\"STRING\" size=\"256\"/><Column id=\"menu_seq\" type=\"INT\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/><Column id=\"board_menu_seq\" type=\"INT\" size=\"256\"/><Column id=\"menu_name\" type=\"STRING\" size=\"256\"/><Column id=\"type\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("메뉴 관리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Div("div_sidebar","10","87","960","470",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_menu_manage","20","27","910","393",null,null,null,null,null,null,this.div_sidebar.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_sidebar");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"48\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"136\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"138\"/><Column size=\"80\"/><Column size=\"392\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell edittype=\"none\" text=\"chk\"/><Cell col=\"1\" text=\"code\"/><Cell col=\"2\" text=\"mid_code\"/><Cell col=\"3\" text=\"mid_name\"/><Cell col=\"4\" text=\"sub_name\"/><Cell col=\"5\" text=\"menu_seq\"/><Cell col=\"6\" text=\"status\"/><Cell col=\"7\" text=\"board_menu_seq\"/><Cell col=\"8\" text=\"menu_name\"/><Cell col=\"9\" text=\"type\"/><Cell col=\"10\" text=\"contents\"/></Band><Band id=\"body\"><Cell edittype=\"checkbox\"/><Cell col=\"1\" text=\"bind:code\"/><Cell col=\"2\" text=\"bind:mid_code\"/><Cell col=\"3\" text=\"bind:mid_name\"/><Cell col=\"4\" text=\"bind:sub_name\"/><Cell col=\"5\" text=\"bind:menu_seq\"/><Cell col=\"6\" text=\"bind:status\"/><Cell col=\"7\" text=\"bind:board_menu_seq\"/><Cell col=\"8\" text=\"bind:menu_name\"/><Cell col=\"9\" text=\"bind:type\"/><Cell col=\"10\" text=\"bind:contents\"/></Band></Format></Formats>");
            this.div_sidebar.addChild(obj.name, obj);

            obj = new Button("Button00","825","515","110","30",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("변경사항 적용");
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
        this.registerScript("M52_menu.xfdl", function() {
        this.M52_menu_onload = function(obj,e)
        {
        	this.transaction(
        			"getSidbarList" // 1. strSvcID
        			,"/sidebar/getSidbarList.nex" // 2. strURL
        			,"" // 3. inData Sds=Fds:U,:A,:N
        			,"ds_sidebar=out_ds" // 4. utData - select Fds=Sds
        			,"" // 5. strArgument
        			,"fn_callback" // 6. strCallbackFunc
        		)
        };

        this.fn_callback = function(result)
        {
        	trace("도착성공!");
        }

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M52_menu_onload,this);
        };

        this.loadIncludeScript("M52_menu.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
