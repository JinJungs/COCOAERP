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
            obj._setContents("<ColumnInfo><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"str_start_time\" type=\"STRING\" size=\"256\"/><Column id=\"str_end_time\" type=\"STRING\" size=\"256\"/><Column id=\"color\" type=\"STRING\" size=\"256\"/><Column id=\"writer_name\" type=\"STRING\" size=\"256\"/><Column id=\"chk\" type=\"STRING\" size=\"1\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            obj = new Dataset("dsColor", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"color\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">#a4a6a5</Col><Col id=\"color\">Gray</Col></Row><Row><Col id=\"code\">#fc9a8d</Col><Col id=\"color\">Red</Col></Row><Row><Col id=\"code\">#f7cc54</Col><Col id=\"color\">Yellow</Col></Row><Row><Col id=\"code\">#8cdba4</Col><Col id=\"color\">Green</Col></Row><Row><Col id=\"code\">#8cd4db</Col><Col id=\"color\">Blue</Col></Row><Row><Col id=\"code\">#e1c9ff</Col><Col id=\"color\">Purple</Col></Row></Rows>");
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

            obj = new Calendar("cldEnd","276","12","150","25",null,null,null,null,null,null,this.divSearch.form);
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

            obj = new Calendar("cldStart","92","12","150","25",null,null,null,null,null,null,this.divSearch.form);
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
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"25\"/><Column size=\"20\"/><Column size=\"60\"/><Column size=\"110\"/><Column size=\"50\"/><Column size=\"50\"/><Column size=\"40\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"번호\"/><Cell col=\"2\" text=\"제목\"/><Cell col=\"3\" text=\"내용\"/><Cell col=\"4\" text=\"시작일\"/><Cell col=\"5\" text=\"종료일\"/><Cell col=\"6\" text=\"등록인\"/></Band><Band id=\"body\"><Cell displaytype=\"checkboxcontrol\" edittype=\"checkbox\" text=\"bind:chk\" checkboxfalsevalue=\"0\" checkboxtruevalue=\"1\"/><Cell col=\"1\" text=\"bind:seq\" displaytype=\"text\"/><Cell col=\"2\" text=\"bind:title\"/><Cell col=\"3\" text=\"bind:contents\"/><Cell col=\"4\" text=\"bind:str_start_time\" edittype=\"none\"/><Cell col=\"5\" text=\"bind:str_end_time\" displaytype=\"normal\" edittype=\"none\"/><Cell col=\"6\" text=\"bind:writer_name\" displaytype=\"text\"/></Band></Format></Formats>");
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

            obj = new Static("sta_line01","10","72","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("2");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00","10","36","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("3");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_startTime","8","76","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("4");
            obj.set_text("시작일");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_endTime","8","116","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("5");
            obj.set_text("종료일");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line04","10","112","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("6");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_writer","178","154","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("7");
            obj.set_text("등록인");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new TextArea("ta_contents","9","200","329","160",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("8");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Button("btn_modify","143","385","60","35",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("9");
            obj.set_text("수정");
            obj.set_cssclass("btn_WF_list01");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_title","76","42","105","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("10");
            obj.set_readonly("true");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_writer","246","160","94","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("11");
            obj.set_readonly("true");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Combo("cb_color","76","161","94","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("12");
            obj.set_innerdataset("dsColor");
            obj.set_datacolumn("color");
            obj.set_codecolumn("code");
            obj.set_text("Combo00");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_color","8","154","58","34",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("13");
            obj.set_text("색상");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line04_00","10","150","369","8",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("14");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Calendar("cldStartDate","76","81","105","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("15");
            this.Div00.form.div_info.addChild(obj.name, obj);

            obj = new Calendar("cldEndDate","77","121","105","25",null,null,null,null,null,null,this.Div00.form.div_info.form);
            obj.set_taborder("16");
            this.Div00.form.div_info.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item7","Div00.form.div_info.form.ta_contents","value","dsSchedule","contents");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item0","Div00.form.div_info.form.edt_title","value","dsSchedule","title");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item6","Div00.form.div_info.form.edt_writer","value","dsSchedule","writer_name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","Div00.form.div_info.form.cldStartDate","value","dsSchedule","str_start_time");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","Div00.form.div_info.form.cldEndDate","value","dsSchedule","str_end_time");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item3","Div00.form.div_info.form.cb_color","value","dsSchedule","color");
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

        	this.divSearch.form.cldStart.set_value(year+month+day);
        	this.divSearch.form.cldEnd.set_value(year+month+day);

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
        };

        this.fn_callback_reload = function(msg){
        	this.M21_companySchedule_onload();
        };

        this.divSearch_btnFind_onclick = function(obj,e)
        {
        	var sch_start = this.divSearch.form.cldStart.value;
        	var sch_end = this.divSearch.form.cldEnd.value;
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

        // 일정 추가
        this.divSearch_btnAdd_onclick = function(obj,e)
        {
        	var objCF = new ChildFrame();
        	objCF.set_openalign("center middle");
        	objCF.set_formurl("Base::M22_schedulePopup.xfdl");
        	objCF.showModal(
        		this.getOwnerFrame()
        		,{}
        		,this
        		, "fn_callback_popUp"
        	);
        };

        this.fn_callback_popUp = function(id, sRtn){

        	var arrRtn = sRtn.split("|");
        	var title = arrRtn[0];
        	var start = arrRtn[1];
        	var end = arrRtn[2];
        	var color = arrRtn[3];
        	var contents = arrRtn[4];

          	this.transaction(
            	"createSchedule"
            	, "/schedule/createSchedule.nex"
          		, ""
            	, "dsSchedule=out_ds"
           		, "title="+title+" start="+start+" end="+end+" color="+color+" contents="+contents
            	, "fn_callback_reload"
            );
        };

        this.divSearch_btnDel_onclick = function(obj,e)
        {
        	let arr = this.dsSchedule.extractRows("chk==1");
        	var seq = this.dsSchedule.getColumn(this.dsSchedule.rowposition, "seq");
        	trace("seq값은? "+seq);
        //  	if(arr.length == 0 || arr == -1) {alert("선택된 항목이 없습니다.");return}
        //
        //   	this.dsSchedule.deleteMultiRows(arr);
        //  	this.transaction(
        //    		"boardDelete" // id
        //    		, "/NecBoard/delBoard.nc" // url
        //  		, "ds_delBoard = ds_board_menu:D" // inData
        //    		, "" // outData
        //  		, "seq="+seq// strArg
        //    		, "fn_callback_del" // callback
        //    	);
        };
        /*
        this.Div00_GridList_onheadclick = function(obj:nexacro.Grid,e:nexacro.GridClickEventInfo)
        {
        	if(e.cell == 0){
        		this.gf_setCheckAll(obj, e);
        	}
        };

        this.gf_setCheckAll = function(obj:Grid, e:GridClickEventInfo)
        {
        	var strColID = obj.getCellProperty("body", e.cell, "text").replace("bind:", ""); //Cell의 특정 속성 값을 반환하는 메소드입니다.
        	var sheadValue = obj.getCellProperty("head", e.cell, "text"); //head에서 선택한 행의 text 값 가져오기
        	//var objDs = obj.getBindDataset();

        	sheadValue = (sheadValue == "0" ? "1" : "0");
        	obj.setCellProperty("head",e.cell,"text",sheadValue);
        	obj.setCellProperty("body",e.cell,"text",sheadValue);
        	trace("sheadValue "+sheadValue);

        	//this.ds_board_menu.set_enableevent(false);
        	for(var i=0; i<this.ds_board_menu.getRowCount(); i++){
        		this.ds_board_menu.setColumn(i, "chk", sheadValue);
        	}
        	//this.ds_board_menu.set_enableevent(true);
        };*/
        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M21_companySchedule_onload,this);
            this.divSearch.form.btnFind.addEventHandler("onclick",this.divSearch_btnFind_onclick,this);
            this.divSearch.form.btnAdd.addEventHandler("onclick",this.divSearch_btnAdd_onclick,this);
            this.divSearch.form.btnDel.addEventHandler("onclick",this.divSearch_btnDel_onclick,this);
            this.Div00.form.GridList.addEventHandler("onheadclick",this.Div00_GridList_onheadclick,this);
        };

        this.loadIncludeScript("M21_companySchedule.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
