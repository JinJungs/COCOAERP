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
            obj._setContents("<ColumnInfo><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"str_start_time\" type=\"STRING\" size=\"256\"/><Column id=\"str_end_time\" type=\"STRING\" size=\"256\"/><Column id=\"color\" type=\"STRING\" size=\"256\"/><Column id=\"dept_name\" type=\"STRING\" size=\"256\"/><Column id=\"team_name\" type=\"STRING\" size=\"256\"/><Column id=\"emp_name\" type=\"STRING\" size=\"256\"/><Column id=\"writer_name\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
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

            obj = new Div("Div00","20","170",null,null,"90","30","905",null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);

            obj = new Grid("GridList","0.00%","0",null,null,"36.08%","0.00%",null,null,null,null,this.Div00.form);
            obj.set_taborder("0");
            obj.set_binddataset("dsSchedule");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"20\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"50\"/><Column size=\"50\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/><Column size=\"40\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"번호\"/><Cell col=\"1\" text=\"제목\"/><Cell col=\"2\" text=\"내용\"/><Cell col=\"3\" text=\"시작일\"/><Cell col=\"4\" text=\"종료일\"/><Cell col=\"5\" text=\"부서명\"/><Cell col=\"6\" text=\"팀명\"/><Cell col=\"7\" text=\"개인일정\"/><Cell col=\"8\" text=\"등록인\"/></Band><Band id=\"body\"><Cell text=\"bind:seq\" displaytype=\"text\"/><Cell col=\"1\" text=\"bind:title\"/><Cell col=\"2\" text=\"bind:contents\"/><Cell col=\"3\" text=\"bind:str_start_time\" edittype=\"none\"/><Cell col=\"4\" text=\"bind:str_end_time\" displaytype=\"normal\" edittype=\"none\"/><Cell col=\"5\" text=\"bind:dept_name\" displaytype=\"text\"/><Cell col=\"6\" text=\"bind:team_name\" displaytype=\"text\"/><Cell col=\"7\" text=\"bind:emp_name\" displaytype=\"text\"/><Cell col=\"8\" text=\"bind:writer_name\" displaytype=\"text\"/></Band></Format></Formats>");
            this.Div00.addChild(obj.name, obj);

            obj = new Div("div_info","GridList:10","0","340",null,null,"0","425",null,null,null,this.Div00.form);
            obj.set_taborder("1");
            obj.set_formscrollbartype("auto");
            obj.set_formscrolltype("vertical");
            obj.set_text("");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("sta_subtitle","0","-5",null,"34","252",null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("0");
            obj.set_text("일정 정보");
            obj.set_cssclass("sta_WF_title01");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_title","8","36","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("1");
            obj.set_text("제목");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_title","76","42","90","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("2");
            obj.set_format("######");
            obj.set_enable("false");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line01","10","72","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("3");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_emp","8","154","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("4");
            obj.set_text("개인일정");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00","10","36","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("5");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_startTime","8","76","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("6");
            obj.set_text("시작일");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_endTime","178","76","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("7");
            obj.set_text("종료일");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_team","178","116","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("8");
            obj.set_text("팀명");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line02","10","112","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("9");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line03","10","152","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("10");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line04","10","192","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("11");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_startTime","76","81","90","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("12");
            obj.set_format("######");
            obj.set_enable("false");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_endTime","246","81","90","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("13");
            obj.set_format("######");
            obj.set_enable("false");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_dept","8","116","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("14");
            obj.set_text("부서명");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_dept","76","121","90","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("15");
            obj.set_format("######");
            obj.set_enable("false");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_team","246","121","90","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("16");
            obj.set_format("######");
            obj.set_enable("false");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_writer","8","194","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("17");
            obj.set_text("등록인");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_emp","76","161","90","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("18");
            obj.set_format("######");
            obj.set_enable("false");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_writer","76","201","90","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("19");
            obj.set_format("######");
            obj.set_enable("false");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new TextArea("ta_contents","9","240","329","160",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("20");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Button("btn_modify","143","415","60","35",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("21");
            obj.set_text("수정");
            obj.set_cssclass("btn_WF_list01");
            this.Div00.form.div_info.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item0","Div00.form.div_info.form.msk_title","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","Div00.form.div_info.form.msk_startTime","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","Div00.form.div_info.form.msk_endTime","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item3","Div00.form.div_info.form.msk_dept","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item4","Div00.form.div_info.form.msk_team","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item5","Div00.form.div_info.form.msk_emp","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item6","Div00.form.div_info.form.msk_writer","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();
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

        this.Div00_GridList_oncellposchanged = function(obj,e)
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
            this.Div00.form.GridList.addEventHandler("oncellposchanged",this.Div00_GridList_oncellposchanged,this);
        };

        this.loadIncludeScript("M21_companySchedule.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
