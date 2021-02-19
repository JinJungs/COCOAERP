(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M21_companySchedule");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("dsSchedule", this);
            obj._setContents("<ColumnInfo><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"start_time\" type=\"TIME\" size=\"256\"/><Column id=\"end_time\" type=\"TIME\" size=\"256\"/><Column id=\"color\" type=\"STRING\" size=\"256\"/><Column id=\"dept_code\" type=\"INT\" size=\"256\"/><Column id=\"team_code\" type=\"INT\" size=\"256\"/><Column id=\"emp_code\" type=\"INT\" size=\"256\"/><Column id=\"writer\" type=\"INT\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("회사 일정 관리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Calendar("CldEnd","305","70","150","20",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            this.addChild(obj.name, obj);

            obj = new Calendar("CldStart","115","70","150","20",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","15","67","95","23",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("기간 선택");
            this.addChild(obj.name, obj);

            obj = new Button("btnFind","450","156","112","34",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("조회");
            obj.set_background("darkgray");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","284","66","12","28",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("-");
            this.addChild(obj.name, obj);

            obj = new Static("Static03","15","211","120","28",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("조회 결과");
            this.addChild(obj.name, obj);

            obj = new Grid("GridList","15","245","1055","370",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_binddataset("Schedule");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"48\"/><Column size=\"56\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"seq\"/><Cell col=\"2\" text=\"title\"/><Cell col=\"3\" text=\"contents\"/><Cell col=\"4\" text=\"start_time\"/><Cell col=\"5\" text=\"end_time\"/><Cell col=\"6\" text=\"color\"/><Cell col=\"7\" text=\"dept_code\"/><Cell col=\"8\" text=\"team_code\"/><Cell col=\"9\" text=\"emp_code\"/><Cell col=\"10\" text=\"writer\"/></Band><Band id=\"body\"><Cell displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"bind:seq\"/><Cell col=\"2\" text=\"bind:title\"/><Cell col=\"3\" text=\"bind:contents\"/><Cell col=\"4\" text=\"bind:start_time\"/><Cell col=\"5\" text=\"bind:end_time\"/><Cell col=\"6\" text=\"bind:color\"/><Cell col=\"7\" text=\"bind:dept_code\"/><Cell col=\"8\" text=\"bind:team_code\"/><Cell col=\"9\" text=\"bind:emp_code\"/><Cell col=\"10\" text=\"bind:writer\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btnDel","1010","211","60","30",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_text("삭제");
            obj.set_background("darkgray");
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
        this.registerScript("M21_companySchedule.xfdl", function() {
        this.M21_companySchedule_onload = function(obj,e)
        {
        	var currDate = new Date();
        	var year = currDate.getFullYear().toString().padLeft(4, "0");
            var month = (currDate.getMonth()+1).toString().padLeft(2, "0");
            var day = currDate.getDate().toString().padLeft(2, "0");

        	this.CldStart.set_value(year+month+day);
        	this.CldEnd.set_value(year+month+day);

        	this.transaction(
        		"getSchedule"
        		, "/schedule/getList.nex"
        		, ""
        		, "dsSchedule=out_ds"
        		, ""
        		, ""
        	);
        };


        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M21_companySchedule_onload,this);
        };

        this.loadIncludeScript("M21_companySchedule.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
