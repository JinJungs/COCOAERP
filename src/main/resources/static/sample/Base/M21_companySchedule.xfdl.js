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
            obj._setContents("<ColumnInfo><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"str_start_time\" type=\"STRING\" size=\"256\"/><Column id=\"str_end_time\" type=\"STRING\" size=\"256\"/><Column id=\"color\" type=\"STRING\" size=\"256\"/><Column id=\"dept_code\" type=\"INT\" size=\"256\"/><Column id=\"team_code\" type=\"INT\" size=\"256\"/><Column id=\"emp_code\" type=\"INT\" size=\"256\"/><Column id=\"writer\" type=\"INT\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","20","10",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("회사 일정 관리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Div("divSearch","20","100",null,"50","100",null,"905",null,null,null,this);
            obj.set_taborder("2");
            obj.set_border("1px solid #c7c7c7");
            obj.set_text("");
            obj.set_background("#eeeeee");
            this.addChild(obj.name, obj);

            obj = new Calendar("CldEnd","276","12","150","25",null,null,null,null,null,null,this.divSearch.form);
            obj.set_taborder("0");
            this.divSearch.addChild(obj.name, obj);

            obj = new Static("Static01","10","12","50","25",null,null,null,null,null,null,this.divSearch.form);
            obj.set_taborder("1");
            obj.set_text("기간 선택");
            this.divSearch.addChild(obj.name, obj);

            obj = new Static("Static02","256","12","10","25",null,null,null,null,null,null,this.divSearch.form);
            obj.set_taborder("2");
            obj.set_text("-");
            this.divSearch.addChild(obj.name, obj);

            obj = new Calendar("CldStart","92","12","150","25",null,null,null,null,null,null,this.divSearch.form);
            obj.set_taborder("3");
            this.divSearch.addChild(obj.name, obj);

            obj = new Button("btnFind","453","12","54","25",null,null,null,null,null,null,this.divSearch.form);
            obj.set_taborder("4");
            obj.set_text("조회");
            obj.set_cssclass("btn_WF_search01");
            this.divSearch.addChild(obj.name, obj);

            obj = new Button("btnAdd",null,"12","70","25","80",null,null,null,null,null,this.divSearch.form);
            obj.set_taborder("5");
            obj.set_text("추가");
            obj.set_cssclass("btn_WF_add01");
            this.divSearch.addChild(obj.name, obj);

            obj = new Button("btnDel",null,"12","60","25","10",null,null,null,null,null,this.divSearch.form);
            obj.set_taborder("6");
            obj.set_text("삭제");
            obj.set_cssclass("btn_WF_delete01");
            this.divSearch.addChild(obj.name, obj);

            obj = new Div("Div00","20","170",null,null,"100","50","905",null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);

            obj = new Grid("GridList","0.00%","0",null,null,"0.00%","0.00%",null,null,null,null,this.Div00.form);
            obj.set_taborder("0");
            obj.set_binddataset("dsSchedule");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"25\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"번호\"/><Cell col=\"1\" text=\"제목\"/><Cell col=\"2\" text=\"내용\"/><Cell col=\"3\" text=\"시작기간\"/><Cell col=\"4\" text=\"종료기간\"/><Cell col=\"5\" text=\"부서코드\"/><Cell col=\"6\" text=\"팀코드\"/><Cell col=\"7\" text=\"사번\"/><Cell col=\"8\" text=\"작성자\"/></Band><Band id=\"body\"><Cell text=\"bind:seq\" displaytype=\"text\"/><Cell col=\"1\" text=\"bind:title\"/><Cell col=\"2\" text=\"bind:contents\"/><Cell col=\"3\" text=\"bind:str_start_time\" edittype=\"none\"/><Cell col=\"4\" text=\"bind:str_end_time\" displaytype=\"normal\" edittype=\"none\"/><Cell col=\"5\" text=\"bind:dept_code\"/><Cell col=\"6\" text=\"bind:team_code\"/><Cell col=\"7\" text=\"bind:emp_code\"/><Cell col=\"8\" text=\"bind:writer\"/></Band></Format></Formats>");
            this.Div00.addChild(obj.name, obj);

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

        	this.divSearch.form.CldStart.set_value(year+month+day);
        	this.divSearch.form.CldEnd.set_value(year+month+day);

        	this.transaction(
        		"getList"
        		, "/schedule/getList.nex"
        		, ""
        		, "dsSchedule=out_ds"
        		, ""
        		, "fn_callback"
        	);
        };

        this.fn_callback = function(msg){
        	trace(msg);
        }
        this.divSearch_btnFind_onclick = function(obj,e)
        {
        	var sch_start = this.divSearch.form.CldStart.value;
        	var sch_end = this.divSearch.form.CldEnd.value;
        	trace(sch_start);
        	trace(sch_end);
        	this.transaction(
        		"searchByDate"
        		, "/schedule/searchByDate.nex"
        		, ""
        		, "dsSchedule=out_ds"
        		, "sch_start="+sch_start+" sch_end="+sch_end
        		, "fn_callback"
        	);
        };

        this.divSearch_btnAdd_onclick = function(obj,e)
        {

        };

        this.divSearch_btnDel_onclick = function(obj,e)
        {

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M21_companySchedule_onload,this);
            this.divSearch.form.btnFind.addEventHandler("onclick",this.divSearch_btnFind_onclick,this);
            this.divSearch.form.btnAdd.addEventHandler("onclick",this.divSearch_btnAdd_onclick,this);
            this.divSearch.form.btnDel.addEventHandler("onclick",this.divSearch_btnDel_onclick,this);
        };

        this.loadIncludeScript("M21_companySchedule.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
