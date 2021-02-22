(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M32_approveVaction");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_employee", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"deptname\" type=\"STRING\" size=\"256\"/><Column id=\"teamname\" type=\"STRING\" size=\"256\"/><Column id=\"posname\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"hire_date\" type=\"STRING\" size=\"256\"/><Column id=\"office_phone\" type=\"STRING\" size=\"256\"/><Column id=\"year\" type=\"INT\" size=\"256\"/><Column id=\"leave_got\" type=\"INT\" size=\"256\"/><Column id=\"leave_used\" type=\"INT\" size=\"256\"/><Column id=\"deptCode\" type=\"INT\" size=\"256\"/><Column id=\"teamCode\" type=\"INT\" size=\"256\"/><Column id=\"posCode\" type=\"INT\" size=\"256\"/><Column id=\"addLeave\" type=\"INT\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_departments", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">01</Col><Col id=\"name\">개발부</Col></Row><Row><Col id=\"code\">02</Col><Col id=\"name\">영업부</Col></Row><Row><Col id=\"code\">03</Col><Col id=\"name\">부우부</Col></Row><Row><Col id=\"code\">04</Col><Col id=\"name\">말리부</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_position", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">01</Col><Col id=\"name\">대표</Col></Row><Row><Col id=\"code\">02</Col><Col id=\"name\">사장</Col></Row><Row><Col id=\"code\">03</Col><Col id=\"name\">부장</Col></Row><Row><Col id=\"code\">04</Col><Col id=\"name\">대리</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","20","10",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("휴가 부여");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Div("Div00","20","170",null,null,"100","50",null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","0.00%","0",null,null,"0%","0.00%",null,null,null,null,this.Div00.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_employee");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"사번\"/><Cell col=\"1\" text=\"부서명\"/><Cell col=\"2\" text=\"팀명\"/><Cell col=\"3\" text=\"posname\"/><Cell col=\"4\" text=\"name\"/><Cell col=\"5\" text=\"hire_date\"/><Cell col=\"6\" text=\"office_phone\"/><Cell col=\"7\" text=\"year\"/><Cell col=\"8\" text=\"leave_got\"/><Cell col=\"9\" text=\"leave_used\"/><Cell col=\"10\" text=\"addLeave\"/></Band><Band id=\"body\"><Cell text=\"bind:code\"/><Cell col=\"1\" text=\"bind:deptname\"/><Cell col=\"2\" text=\"bind:teamname\"/><Cell col=\"3\" text=\"bind:posname\"/><Cell col=\"4\" text=\"bind:name\"/><Cell col=\"5\" text=\"bind:hire_date\"/><Cell col=\"6\" text=\"bind:office_phone\"/><Cell col=\"7\" text=\"bind:year\"/><Cell col=\"8\" text=\"bind:leave_got\"/><Cell col=\"9\" text=\"bind:leave_used\"/><Cell col=\"10\" text=\"bind:addLeave\" edittype=\"mask\" maskeditformat=\"###\" displaytype=\"editcontrol\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.Div00.addChild(obj.name, obj);

            obj = new Div("Div01","20","100",null,"50","100",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("Div01");
            obj.set_border("1px solid #c7c7c7");
            obj.set_background("#eeeeee");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","9","12","27","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("0");
            obj.set_text("사번");
            obj.set_textAlign("right");
            this.Div01.addChild(obj.name, obj);

            obj = new Button("btnSearch","92%","12",null,"25","2%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("1");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_search01");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("editName","52.38%","12","100","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("2");
            this.Div01.addChild(obj.name, obj);

            obj = new Combo("comboDept","19.94%","12","110","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("3");
            obj.set_innerdataset("ds_departments");
            obj.set_codecolumn("code");
            obj.set_datacolumn("name");
            obj.set_text("");
            obj.set_value("0");
            obj.set_index("-1");
            this.Div01.addChild(obj.name, obj);

            obj = new Combo("comboPos","36.16%","12","110","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("4");
            obj.set_innerdataset("ds_position");
            obj.set_codecolumn("code");
            obj.set_datacolumn("name");
            obj.set_text("");
            obj.set_value("0");
            obj.set_index("-1");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("editYear","67.46%","12","100","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("5");
            obj.set_text("d");
            this.Div01.addChild(obj.name, obj);

            obj = new Button("btnReset","82.44%","12",null,"25","9.92%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("6");
            obj.set_text("초기화");
            obj.set_cssclass("btn_WF_reset01");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("editEmpCode","46","12","100","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("7");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01","156","12","27","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("8");
            obj.set_text("부서");
            obj.set_textAlign("right");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01_00","313","12","27","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("9");
            obj.set_text("직위");
            obj.set_textAlign("right");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_00","470","12","27","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("10");
            obj.set_text("이름");
            obj.set_textAlign("right");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_00_00","617","12","27","25",null,null,null,null,null,null,this.Div01.form);
            obj.set_taborder("11");
            obj.set_text("년도");
            obj.set_textAlign("right");
            this.Div01.addChild(obj.name, obj);

            obj = new Button("btnInsert",null,"55","80","35","100",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("일괄부여");
            obj.set_cssclass("btn_WF_add01");
            this.addChild(obj.name, obj);

            obj = new Button("btnAdd",null,"55","110","35","190",null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("추가휴가 입력");
            obj.set_cssclass("btn_WF_add01");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            obj.set_stepcount("0");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M32_approveVaction.xfdl", function() {

        this.M32_approveVaction_onload = function(obj,e)
        {
        	//1. ds_employee 받아오기
        	this.transaction(
        			"selectEmployeeList", // 1. strSvcID
        			"/membership/selectEmployeeLTU.employee", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"ds_employee=out_employee", // 4. strOutDatasets -select Fds=Sds
        			"", // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"" // 6. strCallbackFunc
        		);

        	//2. ds_departments 받아오기
        	this.transaction(
        			"getDepartmentsList", // 1. strSvcID
        			"/department/getDeptList.department", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"ds_departments=out_departments", // 4. strOutDatasets -select Fds=Sds
        			"", // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"" // 6. strCallbackFunc
        		);

        	//3. ds_position 받아오기
        	this.transaction(
        			"getPositionList", // 1. strSvcID
        			"/position/getPositionList.position", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"ds_position=out_position", // 4. strOutDatasets -select Fds=Sds
        			"", // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"" // 6. strCallbackFunc
        		);
        };

        this.btnInsert_onclick = function(obj,e)
        {
        	//Leave_Taken_Used 넣기
        	this.transaction(
        			"insertAllLTU", // 1. strSvcID
        			"/ltuN/insertAllLTU.ltuN", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"ds_employee=out_employee", // 4. strOutDatasets -select Fds=Sds
        			"", // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"fn_callback" // 6. strCallbackFunc
        		);
        };
        this.fn_callback = function(result) {
        	this.alert("일괄부여가 완료되었습니다.");
        }
        this.Div01_btnSearch_onclick = function(obj,e)
        {
        	var empCode = this.Div01.form.editEmpCode.value;
        	var dept = this.Div01.form.comboDept.value;
        	var pos = this.Div01.form.comboPos.value;
        	var name = this.Div01.form.editName.value;
        	var year = this.Div01.form.editYear.value;

        	var filterCon = "";
        	if(empCode != null){
        		if(filterCon != ""){
        			filterCon = filterCon + " && ";
        		}
        		filterCon = filterCon + "code=='" + empCode + "'";
        	}
        	if(dept != '0'){
        		if(filterCon != ""){
        			filterCon = filterCon + " && ";
        		}
        		filterCon = filterCon + "deptCode=='" + dept + "'";
        	}
        	if(pos != '0'){
        		if(filterCon != ""){
        			filterCon = filterCon + " && ";
        		}
        		filterCon = filterCon + "posCode=='" + pos + "'";
        	}
        	if(name != null){
        		if(filterCon != ""){
        			filterCon = filterCon + " && ";
        		}
        		filterCon = filterCon + "name=='" + name + "'";
        	}
        	if(year != null){
        		if(filterCon != ""){
        			filterCon = filterCon + " && ";
        		}
        		filterCon = filterCon + "year=='" + year + "'";
        	}

        	trace("filterCon : " + filterCon);
        	this.ds_employee.filter(filterCon);
        };

        this.Div01_btnReset_onclick = function(obj,e)
        {
        	this.ds_employee.filter("");

        	this.Div01.form.editEmpCode.set_value("");
        	this.Div01.form.comboDept.set_value(0);
        	this.Div01.form.comboPos.set_value(0);
        	this.Div01.form.editName.set_value("");
        	this.Div01.form.editYear.set_value("");
        };

        this.btnAdd_onclick = function(obj,e)
        {
        	var check = 0;
        	for(var i=0; i<this.ds_employee.rowcount; i++){
        		var leaveCount = this.ds_employee.getColumn(i, "addLeave");
        		if(leaveCount > 0){
        			check++;
        		}
        	}
        	if(check > 0){
        		this.transaction(
        				"updateLeave", // 1. strSvcID
        				"/ltuN/addLeave.ltuN", // 2. strURL
        				"in_ds=ds_employee:U", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        				"ds_employee=out_employee", // 4. strOutDatasets -select Fds=Sds
        				"", // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        				"" // 6. strCallbackFunc
        			);
        	}else{
        		alert("입력된 추가정보가 없습니다.");
        	}
        };

        this.fn_callback2 = function(){
        	this.alert("추가 성공");
        }

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M32_approveVaction_onload,this);
            this.Div01.form.btnSearch.addEventHandler("onclick",this.Div01_btnSearch_onclick,this);
            this.Div01.form.editName.addEventHandler("onchanged",this.Edit_onchanged,this);
            this.Div01.form.editYear.addEventHandler("onchanged",this.Edit_onchanged,this);
            this.Div01.form.btnReset.addEventHandler("onclick",this.Div01_btnReset_onclick,this);
            this.btnInsert.addEventHandler("onclick",this.btnInsert_onclick,this);
            this.btnAdd.addEventHandler("onclick",this.btnAdd_onclick,this);
        };

        this.loadIncludeScript("M32_approveVaction.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
