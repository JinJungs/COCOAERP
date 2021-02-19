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
<<<<<<< HEAD
            obj = new Dataset("ds_employee", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"deptname\" type=\"STRING\" size=\"256\"/><Column id=\"teamname\" type=\"STRING\" size=\"256\"/><Column id=\"posname\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"hire_date\" type=\"STRING\" size=\"256\"/><Column id=\"office_phone\" type=\"STRING\" size=\"256\"/><Column id=\"year\" type=\"INT\" size=\"256\"/><Column id=\"leave_got\" type=\"INT\" size=\"256\"/><Column id=\"leave_used\" type=\"INT\" size=\"256\"/><Column id=\"deptCode\" type=\"INT\" size=\"256\"/><Column id=\"teamCode\" type=\"INT\" size=\"256\"/><Column id=\"posCode\" type=\"INT\" size=\"256\"/><Column id=\"addLeave\" type=\"INT\" size=\"256\"/></ColumnInfo><Rows><Row/></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_departments", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">01</Col><Col id=\"name\">개발부</Col></Row><Row><Col id=\"code\">02</Col><Col id=\"name\">영업부</Col></Row><Row><Col id=\"code\">03</Col><Col id=\"name\">부우부</Col></Row><Row><Col id=\"code\">04</Col><Col id=\"name\">말리부</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_position", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">01</Col><Col id=\"name\">대표</Col></Row><Row><Col id=\"code\">02</Col><Col id=\"name\">사장</Col></Row><Row><Col id=\"code\">03</Col><Col id=\"name\">부장</Col></Row><Row><Col id=\"code\">04</Col><Col id=\"name\">대리</Col></Row></Rows>");
            this.addChild(obj.name, obj);
=======

>>>>>>> abef99652206b238010e4156be61c300328d8e05
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("휴가 사용처리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

<<<<<<< HEAD
            obj = new Div("Div00","3%","160",null,null,"3%","10%",null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("Div00");
            obj.set_border("1px solid black");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","0.4%","1%",null,null,"0.4%","1%",null,null,null,null,this.Div00.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_employee");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"사번\"/><Cell col=\"1\" text=\"부서명\"/><Cell col=\"2\" text=\"팀명\"/><Cell col=\"3\" text=\"posname\"/><Cell col=\"4\" text=\"name\"/><Cell col=\"5\" text=\"hire_date\"/><Cell col=\"6\" text=\"office_phone\"/><Cell col=\"7\" text=\"year\"/><Cell col=\"8\" text=\"leave_got\"/><Cell col=\"9\" text=\"leave_used\"/><Cell col=\"10\" text=\"addLeave\"/></Band><Band id=\"body\"><Cell text=\"bind:code\"/><Cell col=\"1\" text=\"bind:deptname\"/><Cell col=\"2\" text=\"bind:teamname\"/><Cell col=\"3\" text=\"bind:posname\"/><Cell col=\"4\" text=\"bind:name\"/><Cell col=\"5\" text=\"bind:hire_date\"/><Cell col=\"6\" text=\"bind:office_phone\"/><Cell col=\"7\" text=\"bind:year\"/><Cell col=\"8\" text=\"bind:leave_got\"/><Cell col=\"9\" text=\"bind:leave_used\"/><Cell col=\"10\" text=\"bind:addLeave\" edittype=\"mask\" maskeditformat=\"###\" displaytype=\"editcontrol\" autosizerow=\"limitmin\"/></Band></Format></Formats>");
            this.Div00.addChild(obj.name, obj);

            obj = new Div("Div01","3%","100",null,"50","14%",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("Div01");
            obj.set_border("1px solid black");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","2%","13",null,"25","85%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("0");
            obj.set_text("사번");
            this.Div01.addChild(obj.name, obj);

            obj = new Button("btnSearch","92%","12",null,"25","2%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("1");
            obj.set_text("검색");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_00","47%","13",null,"25","40%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("2");
            obj.set_text("이름");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("editName","51.00%","13",null,"25","38%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("3");
            this.Div01.addChild(obj.name, obj);

            obj = new Combo("comboDept","19%","13",null,"25","70%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("4");
            obj.set_innerdataset("ds_departments");
            obj.set_codecolumn("code");
            obj.set_datacolumn("name");
            obj.set_text("");
            obj.set_value("0");
            obj.set_index("-1");
            this.Div01.addChild(obj.name, obj);

            obj = new Combo("comboPos","32%","13",null,"25","57%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("5");
            obj.set_innerdataset("ds_position");
            obj.set_codecolumn("code");
            obj.set_datacolumn("name");
            obj.set_text("");
            obj.set_value("0");
            obj.set_index("-1");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("editYear","69%","14",null,"25","20%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("6");
            obj.set_text("d");
            this.Div01.addChild(obj.name, obj);

            obj = new Static("Static00_00_00","65%","13",null,"25","28%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("7");
            obj.set_text("년도");
            this.Div01.addChild(obj.name, obj);

            obj = new Button("btnReset","84%","12",null,"25","10%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("8");
            obj.set_text("초기화");
            this.Div01.addChild(obj.name, obj);

            obj = new Edit("editEmpCode","5.97%","13",null,"25","82.96%",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("9");
            this.Div01.addChild(obj.name, obj);

            obj = new Button("btnInsert","88%","105",null,"35","4%",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("일괄부여");
            this.addChild(obj.name, obj);

            obj = new Button("btnAdd",null,"92%","120","25","4%",null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("추가휴가 입력");
            this.addChild(obj.name, obj);

=======
>>>>>>> abef99652206b238010e4156be61c300328d8e05
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

<<<<<<< HEAD
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
=======
>>>>>>> abef99652206b238010e4156be61c300328d8e05
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {

        };

        this.loadIncludeScript("M32_approveVaction.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
