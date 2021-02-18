(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M32_grantVacation");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_document", this);
            obj._setContents("<ColumnInfo><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"write_date\" type=\"DATETIME\" size=\"256\"/><Column id=\"final_date\" type=\"DATETIME\" size=\"256\"/><Column id=\"writer_code\" type=\"INT\" size=\"256\"/><Column id=\"dept_code\" type=\"INT\" size=\"256\"/><Column id=\"temp_code\" type=\"INT\" size=\"256\"/><Column id=\"leave_start\" type=\"DATE\" size=\"256\"/><Column id=\"leave_end\" type=\"DATE\" size=\"256\"/><Column id=\"leave_type\" type=\"STRING\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/><Column id=\"process\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"seq\">1001</Col><Col id=\"title\">조퇴</Col><Col id=\"contents\">3시에 먼저 갑니다</Col><Col id=\"write_date\">2021-02-16</Col><Col id=\"final_date\">2021-02-16</Col><Col id=\"writer_code\">1004</Col><Col id=\"leave_start\">2021-02-16</Col><Col id=\"leave_end\"/><Col id=\"leave_type\">조퇴</Col><Col id=\"status\">CONFIRM</Col><Col id=\"process\">N</Col></Row><Row><Col id=\"seq\">1002</Col><Col id=\"title\">기타</Col><Col id=\"contents\">일주일만 쉴게여</Col><Col id=\"write_date\">2021-02-17</Col><Col id=\"final_date\">2021-02-17</Col><Col id=\"writer_code\">1004</Col><Col id=\"leave_start\">2021-02-20</Col><Col id=\"leave_end\">2021-02-27</Col><Col id=\"leave_type\">기타</Col><Col id=\"status\">CONFIRM</Col><Col id=\"process\">N</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("휴가 사용처리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Div("Div00","2%","100","35%","500",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("Div00");
            obj.set_border("1px solid black");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","1%","1%",null,null,"1%","1%",null,null,null,null,this.Div00.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_document");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"61\"/><Column size=\"129\"/><Column size=\"93\"/><Column size=\"51\"/></Columns><Rows><Row size=\"32\" band=\"head\"/><Row size=\"33\"/></Rows><Band id=\"head\"><Cell text=\"문서번호\"/><Cell col=\"1\" text=\"제목\"/><Cell col=\"2\" text=\"승인날짜\" autosizecol=\"default\"/><Cell col=\"3\" text=\"처리여부\"/></Band><Band id=\"body\"><Cell text=\"bind:seq\" textAlign=\"center\" displaytype=\"mask\" maskeditformat=\"####\"/><Cell col=\"1\" text=\"bind:title\" textAlign=\"center\"/><Cell col=\"2\" text=\"bind:final_date\" textAlign=\"center\" displaytype=\"calendarcontrol\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell col=\"3\" text=\"bind:process\" textAlign=\"center\"/></Band></Format></Formats>");
            this.Div00.addChild(obj.name, obj);

            obj = new Div("Div01","39%","100",null,"300","2%",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("Div01");
            obj.set_border("1px solid black");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00","50%","19",null,"30","3%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("0");
            obj.set_enable("false");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00",null,"19","40","30","50%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("1");
            obj.set_text("제목");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_00",null,"58","40","30","50%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("2");
            obj.set_text("내용");
            this.Div01.addChild(obj.name, obj);

            obj = new TextArea("TextArea00","50%","59",null,"220","3%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("3");
            obj.set_enable("false");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01","3%","69","65","30",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("4");
            obj.set_text("승인날짜");
            this.Div01.addChild(obj.name, obj);

            obj = new Calendar("Calendar00","15%","71",null,"27","65%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("5");
            obj.set_enable("false");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01_00","3%","159","65","30",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("6");
            obj.set_text("종류");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("Edit00_00_00","15%","159",null,"30","65%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("7");
            obj.set_enable("false");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_02","3.5%","19","120","30",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("8");
            obj.set_text("문서번호");
            obj.set_font("bold 16px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01_01","3%","204","65","30",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("9");
            obj.set_text("시작 날짜");
            this.Div01.addChild(obj.name, obj);

            obj = new Calendar("Calendar00_00","15%","206",null,"27","65%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("10");
            obj.set_enable("false");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01_02","3%","249","65","30",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("11");
            obj.set_text("마감 날짜");
            this.Div01.addChild(obj.name, obj);

            obj = new Calendar("Calendar00_01","15%","251",null,"27","65%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("12");
            obj.set_enable("false");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_00","3%","114","65","30",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("13");
            obj.set_text("작성자");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("writerEdit","15%","114",null,"30","65%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("14");
            obj.set_enable("false");
            this.Div01.addChild(obj.name, obj);

            obj = new Div("Div02","39%","420",null,"180","2%",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("Div02");
            obj.set_border("1px solid black");
            this.addChild(obj.name, obj);

            obj = new CheckBox("checkMinus","20","139","194","25",null,null,null,null,null,null,this.Div02.form);
            obj.set_taborder("0");
            obj.set_text("휴가 차감 여부");
            this.Div02.addChild(obj.name, obj);

            obj = new Static("seq","3.5%","7","141","42",null,null,null,null,null,null,this.Div02.form);
            obj.set_taborder("1");
            obj.set_text("문서번호");
            obj.set_font("bold 16px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            this.Div02.addChild(obj.name, obj);

            obj = new Spin("spinTime","15%","95",null,"27","65%",null,null,null,null,null,this.Div02.form);
            obj.set_taborder("2");
            obj.set_min("1");
            obj.set_max("7");
            obj.set_value("");
            this.Div02.addChild(obj.name, obj);

            obj = new Static("Static01","3%","50","64","31",null,null,null,null,null,null,this.Div02.form);
            obj.set_taborder("3");
            obj.set_text("종류");
            this.Div02.addChild(obj.name, obj);

            obj = new Static("Static01_00","19","95","64","31",null,null,null,null,null,null,this.Div02.form);
            obj.set_taborder("4");
            obj.set_text("시간");
            this.Div02.addChild(obj.name, obj);

            obj = new Edit("editType","15%","50",null,"27","65%",null,null,null,null,null,this.Div02.form);
            obj.set_taborder("5");
            obj.set_enable("false");
            this.Div02.addChild(obj.name, obj);

            obj = new Button("submitBtn",null,"144","69","25","2.02%",null,null,null,null,null,this.Div02.form);
            obj.set_taborder("6");
            obj.set_text("등록");
            obj.set_background("linear-gradient(#23cccc,#1098d5)");
            obj.set_borderRadius("10px");
            obj.set_color("#ffffff");
            this.Div02.addChild(obj.name, obj);

            obj = new Static("Static01_01",null,"48","60","31","40%",null,null,null,null,null,this.Div02.form);
            obj.set_taborder("7");
            obj.set_text("시작 날짜");
            this.Div02.addChild(obj.name, obj);

            obj = new Calendar("calStart","60%","50",null,"27","20%",null,null,null,null,null,this.Div02.form);
            obj.set_taborder("8");
            this.Div02.addChild(obj.name, obj);

            obj = new Static("Static01_01_00",null,"95","60","31","40%",null,null,null,null,null,this.Div02.form);
            obj.set_taborder("9");
            obj.set_text("마감 날짜");
            this.Div02.addChild(obj.name, obj);

            obj = new Calendar("calEnd","60%","95",null,"27","20%",null,null,null,null,null,this.Div02.form);
            obj.set_taborder("10");
            this.Div02.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,
            	//-- Layout function
            	function(p)
            	{
                var rootobj = p;


                // {{ this.Div00
                p = rootobj.Div00.form;

                p.Grid00.set_taborder("0");
                p.Grid00.set_binddataset("ds_document");
                p.Grid00.set_autofittype("col");
                p.Grid00.move("1%","1%",null,null,"1%","1%");
                // this.Div00 }}


                // {{ this.Div01
                p = rootobj.Div01.form;

                p.Edit00.set_taborder("0");
                p.Edit00.set_enable("false");
                p.Edit00.move("50%","19",null,"30","3%",null);

                p.Static00.set_taborder("1");
                p.Static00.set_text("제목");
                p.Static00.move(null,"19","40","30","50%",null);

                p.Static00_00.set_taborder("2");
                p.Static00_00.set_text("내용");
                p.Static00_00.move(null,"58","40","30","50%",null);

                p.TextArea00.set_taborder("3");
                p.TextArea00.set_enable("false");
                p.TextArea00.move("50%","59",null,"220","3%",null);

                p.Static00_01.set_taborder("4");
                p.Static00_01.set_text("승인날짜");
                p.Static00_01.move("3%","69","65","30",null,null);

                p.Calendar00.set_taborder("5");
                p.Calendar00.set_enable("false");
                p.Calendar00.move("15%","71",null,"27","65%",null);

                p.Static00_01_00.set_taborder("6");
                p.Static00_01_00.set_text("종류");
                p.Static00_01_00.move("3%","159","65","30",null,null);

                p.Edit00_00_00.set_taborder("7");
                p.Edit00_00_00.set_enable("false");
                p.Edit00_00_00.move("15%","159",null,"30","65%",null);

                p.Static00_02.set_taborder("8");
                p.Static00_02.set_text("문서번호");
                p.Static00_02.set_font("bold 16px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
                p.Static00_02.move("3.5%","19","120","30",null,null);

                p.Static00_01_01.set_taborder("9");
                p.Static00_01_01.set_text("시작 날짜");
                p.Static00_01_01.move("3%","204","65","30",null,null);

                p.Calendar00_00.set_taborder("10");
                p.Calendar00_00.set_enable("false");
                p.Calendar00_00.move("15%","206",null,"27","65%",null);

                p.Static00_01_02.set_taborder("11");
                p.Static00_01_02.set_text("마감 날짜");
                p.Static00_01_02.move("3%","249","65","30",null,null);

                p.Calendar00_01.set_taborder("12");
                p.Calendar00_01.set_enable("false");
                p.Calendar00_01.move("15%","251",null,"27","65%",null);

                p.Static00_01_00_00.set_taborder("13");
                p.Static00_01_00_00.set_text("작성자");
                p.Static00_01_00_00.move("3%","114","65","30",null,null);

                p.writerEdit.set_taborder("14");
                p.writerEdit.set_enable("false");
                p.writerEdit.move("15%","114",null,"30","65%",null);
                // this.Div01 }}


                // {{ this.Div02
                p = rootobj.Div02.form;

                p.checkMinus.set_taborder("0");
                p.checkMinus.set_text("휴가 차감 여부");
                p.checkMinus.move("20","139","194","25",null,null);

                p.seq.set_taborder("1");
                p.seq.set_text("문서번호");
                p.seq.set_font("bold 16px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
                p.seq.move("3.5%","7","141","42",null,null);

                p.spinTime.set_taborder("2");
                p.spinTime.set_min("1");
                p.spinTime.set_max("7");
                p.spinTime.set_value("");
                p.spinTime.move("15%","95",null,"27","65%",null);

                p.Static01.set_taborder("3");
                p.Static01.set_text("종류");
                p.Static01.move("3%","50","64","31",null,null);

                p.Static01_00.set_taborder("4");
                p.Static01_00.set_text("시간");
                p.Static01_00.move("19","95","64","31",null,null);

                p.editType.set_taborder("5");
                p.editType.set_enable("false");
                p.editType.move("15%","50",null,"27","65%",null);

                p.submitBtn.set_taborder("6");
                p.submitBtn.set_text("등록");
                p.submitBtn.set_background("linear-gradient(#23cccc,#1098d5)");
                p.submitBtn.set_borderRadius("10px");
                p.submitBtn.set_color("#ffffff");
                p.submitBtn.move(null,"144","69","25","2.02%",null);

                p.Static01_01.set_taborder("7");
                p.Static01_01.set_text("시작 날짜");
                p.Static01_01.move(null,"48","60","31","40%",null);

                p.calStart.set_taborder("8");
                p.calStart.move("60%","50",null,"27","20%",null);

                p.Static01_01_00.set_taborder("9");
                p.Static01_01_00.set_text("마감 날짜");
                p.Static01_01_00.move(null,"95","60","31","40%",null);

                p.calEnd.set_taborder("10");
                p.calEnd.move("60%","95",null,"27","20%",null);
                // this.Div02 }}
                p = rootobj;
                p.set_titletext("New Form");

                p.Static00.set_taborder("0");
                p.Static00.set_text("휴가 사용처리");
                p.Static00.set_cssclass("sta_WF_title01");
                p.Static00.move("0","0",null,"34","10",null);

                p.Div00.set_taborder("1");
                p.Div00.set_text("Div00");
                p.Div00.set_border("1px solid black");
                p.Div00.move("2%","100","35%","500",null,null);

                p.Div01.set_taborder("2");
                p.Div01.set_text("Div01");
                p.Div01.set_border("1px solid black");
                p.Div01.move("39%","100",null,"300","2%",null);

                p.Div02.set_taborder("3");
                p.Div02.set_text("Div02");
                p.Div02.set_border("1px solid black");
                p.Div02.move("39%","420",null,"180","2%",null);
            	}
            );
            this.addLayout(obj.name, obj);

            //-- Normal Layout : this
            obj = new Layout("default0","",1090,650,this,
            	//-- Layout function
            	function(p)
            	{
                var rootobj = p;


                // {{ this.Div00
                p = rootobj.Div00.form;

                p.Grid00.set_taborder("0");
                p.Grid00.set_binddataset("ds_document");
                p.Grid00.set_autofittype("col");
                p.Grid00.move("1%","1%","99%","99%",null,null);
                // this.Div00 }}


                // {{ this.Div01
                p = rootobj.Div01.form;

                p.Edit00.set_taborder("0");
                p.Edit00.move("334","19","300","30",null,null);

                p.Static00.set_taborder("1");
                p.Static00.set_text("제목");
                p.Static00.move("285","19","40","30",null,null);

                p.Static00_00.set_taborder("2");
                p.Static00_00.set_text("내용");
                p.Static00_00.move("285","58","40","30",null,null);

                p.TextArea00.set_taborder("3");
                p.TextArea00.move("335","59","300","220",null,null);
                // this.Div01 }}
                p = rootobj;
                p.Static00.set_taborder("0");
                p.Static00.set_text("휴가 부여");
                p.Static00.set_cssclass("sta_WF_title01");
                p.Static00.move("0","0",null,"34","10",null);

                p.Div00.set_taborder("1");
                p.Div00.set_text("Div00");
                p.Div00.set_border("1px solid black");
                p.Div00.move("2%","100","35%","500",null,null);

                p.Div01.set_taborder("2");
                p.Div01.set_text("Div01");
                p.Div01.set_border("1px solid black");
                p.Div01.move("39%","100",null,"300","2%",null);
            	}
            );
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item1","Div01.form.Edit00","value","ds_document","title");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item3","Div01.form.Calendar00","value","ds_document","final_date");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item0","Div01.form.Static00_02","text","ds_document","seq");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item4","Div01.form.Calendar00_00","value","ds_document","leave_start");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item5","Div01.form.Calendar00_01","value","ds_document","leave_end");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item6","Div01.form.Calendar00_00","accessibilityaction","ds_document","leave_start");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item7","Div01.form.Calendar00_01","accessibilityaction","ds_document","leave_end");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item10","Div01.form.Edit00_00_00","value","ds_document","leave_type");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item9","Div02.form.seq","text","ds_document","seq");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item11","Div02.form.editType","value","ds_document","leave_type");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item12","Div02.form.calStart","value","ds_document","leave_start");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item13","Div02.form.calEnd","value","ds_document","leave_end");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","Div01.form.TextArea00","value","ds_document","contents");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item8","Div01.form.writerEdit","value","ds_document","name");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M31_grantVacation.xfdl", function() {


        this.M31_grantVacation_onload = function(obj,e)
        {
        	this.transaction(
        			"documentList", // 1. strSvcID
        			"/documentN/getEarlyList.documentN", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"ds_document=out_document", // 4. strOutDatasets -select Fds=Sds
        			"" , // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"" // 6. strCallbackFunc
        		);
        };
        this.fn_callback = function(result)
        {
        	this.ds_document_onrowposchanged();
        }

        this.Div02_submitBtn_onclick = function(obj,e)
        {
        	var seq = this.Div02.form.seq.text;
        	trace("seq " + seq);
        	var type = this.Div02.form.typeEdit.value;
        	trace("type " + type);
        	var startDate = this.Div02.form.startCalendar.value;
        	trace("startDate " + startDate);
        	var endDate = this.Div02.form.endCalendar.value;
        	trace("endDate " + endDate);
        	var time = this.Div02.form.timeSpin.value;
        	trace("time " + time);
        	var empCode = this.ds_employee.getColumn(this.ds_employee.rowposition, "code");
        	trace("empCode " + empCode);
        	var check = this.Div02.form.checkMinus.value;
        	trace("check " + check);


        	//ds_document 가져오기
        	this.transaction(
        			"insertLeave", // 1. strSvcID
        			"/leaveN/insert.leaveN", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"", // 4. strOutDatasets -select Fds=Sds
        			"seq=" +seq + " type=" + type + " startDate=" + startDate + " endDate=" + endDate + " time=" + time + " empCode=" + empCode + " check=" + check, // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"" // 6. strCallbackFunc
        		);
        	this.M31_grantVacation_onload();

        };

        this.ds_document_onrowposchanged = function(obj,e)
        {
        	var type = this.ds_document.getColumn(e.newrow, "leave_type");
        	if (type == "기타"){
        		this.Div02.form.spinTime.set_enable(true);
        		this.Div02.form.calEnd.set_enable(false);
        	}else if (type == "조퇴"){
        		this.Div02.form.spinTime.set_enable(false);
        		this.Div02.form.calEnd.set_enable(true);
        	}

        };


        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M31_grantVacation_onload,this);
            this.Div01.form.Calendar00_01.addEventHandler("onchanged",this.Div01_Calendar00_01_onchanged,this);
            this.Div02.form.checkMinus.addEventHandler("onclick",this.Div02_CheckBox00_onclick,this);
            this.Div02.form.submitBtn.addEventHandler("onclick",this.Div02_submitBtn_onclick,this);
            this.ds_document.addEventHandler("onrowposchanged",this.ds_document_onrowposchanged,this);
        };

        this.loadIncludeScript("M31_grantVacation.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
