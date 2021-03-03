(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M12_deptTeam");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_org", this);
            obj._setContents("<ColumnInfo><Column id=\"org_nm\" type=\"STRING\" size=\"256\"/><Column id=\"org_cd\" type=\"INT\" size=\"256\"/><Column id=\"p_org_cd\" type=\"INT\" size=\"256\"/><Column id=\"level\" type=\"INT\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"org_nm\">코코아</Col><Col id=\"org_cd\">10</Col><Col id=\"level\">0</Col></Row><Row><Col id=\"org_nm\">개발부</Col><Col id=\"org_cd\">100</Col><Col id=\"level\">1</Col><Col id=\"p_org_cd\">10</Col></Row><Row><Col id=\"org_nm\">개발1팀</Col><Col id=\"org_cd\">1000</Col><Col id=\"p_org_cd\">100</Col><Col id=\"level\">2</Col></Row><Row><Col id=\"org_nm\">인사부</Col><Col id=\"org_cd\">200</Col><Col id=\"p_org_cd\">10</Col><Col id=\"level\">1</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_position", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">1</Col><Col id=\"name\">대표</Col></Row><Row><Col id=\"code\">2</Col><Col id=\"name\">부장</Col></Row><Row><Col id=\"code\">3</Col><Col id=\"name\">팀장</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_employee", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"password\" type=\"STRING\" size=\"256\"/><Column id=\"phone\" type=\"STRING\" size=\"256\"/><Column id=\"office_phone\" type=\"STRING\" size=\"256\"/><Column id=\"address\" type=\"STRING\" size=\"256\"/><Column id=\"email\" type=\"STRING\" size=\"256\"/><Column id=\"b_email\" type=\"STRING\" size=\"256\"/><Column id=\"gender\" type=\"STRING\" size=\"256\"/><Column id=\"hire_date\" type=\"DATE\" size=\"256\"/><Column id=\"withdraw\" type=\"STRING\" size=\"256\"/><Column id=\"dept_code\" type=\"INT\" size=\"256\"/><Column id=\"pos_code\" type=\"INT\" size=\"256\"/><Column id=\"team_code\" type=\"INT\" size=\"256\"/><Column id=\"deptname\" type=\"STRING\" size=\"256\"/><Column id=\"teamname\" type=\"STRING\" size=\"256\"/><Column id=\"posname\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("sta_title","0","0",null,"34","600",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("부서 / 팀 관리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Div("div_empList","300","100",null,null,"100","50","300",null,"300",null,this);
            obj.set_taborder("6");
            obj.set_border("1px solid #c7c7c7");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_emp","9","39",null,"450","10",null,null,null,null,null,this.div_empList.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_employee");
            obj.set_autofittype("col");
            obj.set_scrollbartype("indicator auto");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"100\"/><Column size=\"95\"/><Column size=\"80\"/><Column size=\"47\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"부서\"/><Cell col=\"1\" text=\"팀\"/><Cell col=\"2\" text=\"사번\"/><Cell col=\"3\" text=\"이름\"/><Cell col=\"4\" text=\"직위\"/><Cell col=\"5\" text=\"퇴직\"/></Band><Band id=\"body\"><Cell text=\"bind:deptname\"/><Cell col=\"1\" text=\"bind:teamname\"/><Cell col=\"2\" text=\"bind:code\"/><Cell col=\"3\" text=\"bind:name\"/><Cell col=\"4\" text=\"bind:posname\"/><Cell col=\"5\" text=\"bind:withdraw\"/></Band></Format></Formats>");
            this.div_empList.addChild(obj.name, obj);

            obj = new Static("sta_subtitle","-1","0",null,"40","18",null,null,null,null,null,this.div_empList.form);
            obj.set_taborder("1");
            obj.set_text("사원 목록");
            obj.set_cssclass("sta_WF_title01");
            this.div_empList.addChild(obj.name, obj);

            obj = new Grid("grd_tree","20","100",null,null,"div_empList:10","50",null,null,"300",null,this);
            obj.set_taborder("1");
            obj.getSetter("leftbase").set("");
            obj.getSetter("bottombase").set("");
            obj.getSetter("widthbase").set("");
            obj.getSetter("heightbase").set("");
            obj.set_binddataset("ds_org");
            obj.set_autofittype("col");
            obj.set_treeinitstatus("expand,all");
            obj.set_treeusecheckbox("false");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/></Columns><Rows><Row size=\"24\"/></Rows><Band id=\"body\"><Cell text=\"bind:org_nm\" displaytype=\"treeitemcontrol\" edittype=\"tree\" treelevel=\"bind:level\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_reset",null,"55","64","35","100",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("리셋");
            obj.set_cssclass("btn_WF_reset01");
            this.addChild(obj.name, obj);

            obj = new Button("btn_save",null,"55","64","35","btn_reset:10",null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_save01");
            this.addChild(obj.name, obj);

            obj = new Button("btn_del",null,"55","64","35","btn_save:10",null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("삭제");
            obj.set_cssclass("btn_WF_delete01");
            this.addChild(obj.name, obj);

            obj = new Button("btn_add",null,"55","64","35","btn_del:10",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("추가");
            obj.set_cssclass("btn_WF_add01");
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
        this.registerScript("M12_deptTeam.xfdl", function() {
        this.M12_deptTeam_onload = function(obj,e)
        {
        		trace("도착==============--================");
        		this.transaction(
        			"OrganDeptTeam" //strSvcID
        			, "/nexDeptTeam/nexOrganDept.nex" //strURL
        			, "" //strInDatasets Sds=Fds:U, A, N
        			, "ds_org=out_org_list ds_employee=out_emp_list" //strOutDatasets - select Fds = Sds
        			, "" //strArgument
        			,  "fn_callback" //strCallbackFunc
        		);
        };

        this.fn_callback = function(id, ErrCode, ErrMsg)
        {
        	trace(ErrMsg);
        }
        /*
        this.grd_tree_oncellclick = function(obj:nexacro.Grid,e:nexacro.GridClickEventInfo)
        {
        	var sTreePath = obj.getTreePath(e.row);
        	sTreePath = nexacro.replaceAll(sTreePath, ".", " > ");
        	//this.sta_org.set_text(sTreePath);

        	this.ds_emp.filter("ORG_CD == '" + this.ds_org.getColumn(e.row, "ORG_CD") + "'");
        	this.ds_emp.set_rowposition(0);
        };*/

        //추가
        this.btn_add_onclick = function(obj,e)
        {
        	//포커스 로우
        	let row = this.grd_tree.currentrow;
        	trace(row);
        	let p_org_cd = this.ds_org.getColumn(row, "org_cd");
        	let p_level = this.ds_org.getColumn(row,"level");
        	//대표에 포커스 : 부서추가 / 부서나 팀에 포커스 : 팀 추가
        	let set_level=0;
        	if(p_level==0){
        		set_level=1
        	}else{
        		set_level=2
        	}
        	let addedRow = this.ds_org.insertRow(row+1);
        	this.ds_org.setColumn(addedRow,"p_org_cd",p_org_cd);
        	this.ds_org.setColumn(addedRow,"level",set_level);
        	//null을 스프링 int로 못 받아서 -1 넣어줌
        	this.ds_org.setColumn(addedRow,"org_cd",-1);
        	trace("추가된 로우 부모코드 : ", this.ds_org.getColumn(addedRow, "p_org_cd"))
        	trace("추가된 로우 레벨 : ",set_level);
        };
        //삭제
        this.btn_del_onclick = function(obj,e)
        {
        	let row = this.grd_tree.currentrow;
        	let org_cd = this.ds_org.getColumn(row, "org_cd");
        	trace(row, " : ",org_cd);
        	//데이터셋에서 p_org_cd가 위의 org_cd인 값이 있는지 체크
        	//org_cd가 대표인지 체크
        	//둘다 아닐경우에만 딜리트
        	this.ds_org.deleteRow(row);
        };
        //저장
        this.btn_save_onclick = function(obj,e)
        {
        	//이름을 넣지 않은 값들은 delete해주기

        	//트랜잭션
        		this.transaction(
        			"OrganDeptTeam" //strSvcID
        			, "/nexDeptTeam/saveOrgan.nex" //strURL
        			, "in_ds_org=ds_org:U" //strInDatasets Sds=Fds:U, A, N
        			, "" //strOutDatasets - select Fds = Sds
        			, "" //strArgument
        			,  "fn_callback" //strCallbackFunc
        		);


        };

        //리셋
        this.btn_reset_onclick = function(obj,e)
        {
        		this.transaction(
        		"OrganDeptTeam" //strSvcID
        		, "/nexDeptTeam/nexOrganDept.nex" //strURL
        		, "" //strInDatasets Sds=Fds:U, A, N
        		, "ds_org=out_org_list" //strOutDatasets - select Fds = Sds
        		, "" //strArgument
        		,  "fn_callback" //strCallbackFunc
        	);
        };

        //더블클릭시 텍스트에디트
        this.grd_tree_oncelldblclick = function(obj,e)
        {
        	this.grd_tree.setCellProperty("body",0,"edittype","text");
        };
        //포커스 이동시 트리
        this.grd_tree_onselectchanged = function(obj,e)
        {
        	let status = this.grd_tree.getCellProperty("body",0,"edittype");
        	if(status != "tree"){
        		this.grd_tree.setCellProperty("body",0,"edittype","tree");
        	}
        };




        this.grd_tree_oncellclick = function(obj,e)
        {
        	let row = obj.currentrow;
        	let level = this.ds_org.getColumn(row,"level");
        	let org_cd = this.ds_org.getColumn(row,"org_cd");
        	trace("row : ",row,"level : ",level,"org_cd : ",org_cd );
        	if(level<2){
        		this.ds_employee.filter("dept_code == "+org_cd);
        	}else{
        		this.ds_employee.filter("team_code == "+org_cd);
        	}
        };

        this.div_search_btn_search_onclick = function(obj,e)
        {

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M12_deptTeam_onload,this);
            this.grd_tree.addEventHandler("oncelldblclick",this.grd_tree_oncelldblclick,this);
            this.grd_tree.addEventHandler("onselectchanged",this.grd_tree_onselectchanged,this);
            this.grd_tree.addEventHandler("oncellclick",this.grd_tree_oncellclick,this);
            this.btn_reset.addEventHandler("onclick",this.btn_reset_onclick,this);
            this.btn_save.addEventHandler("onclick",this.btn_save_onclick,this);
            this.btn_del.addEventHandler("onclick",this.btn_del_onclick,this);
            this.btn_add.addEventHandler("onclick",this.btn_add_onclick,this);
        };

        this.loadIncludeScript("M12_deptTeam.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
