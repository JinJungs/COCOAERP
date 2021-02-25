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
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","600",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("부서 / 팀 관리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_tree","10","40","280",null,null,"148",null,null,null,null,this);
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

            obj = new Static("sta_msg","310","181","270","90",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("구현 : \r\n- 트랜잭션을 통해 컨트롤러까지 값 전달 \r\n- 트리 더블클릭시 이름 변경\r\n미구현 : \r\n- 매퍼와 dao를 통한 디비 적용 미구현");
            obj.set_background("#f8d8fd");
            obj.set_textAlign("left");
            this.addChild(obj.name, obj);

            obj = new Button("btn_add","316","40","64","39",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("추가");
            this.addChild(obj.name, obj);

            obj = new Button("btn_reset","396","91","64","39",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("리셋");
            this.addChild(obj.name, obj);

            obj = new Button("btn_save","316","90","64","39",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("저장");
            this.addChild(obj.name, obj);

            obj = new Button("btn_reset00","396","40","64","39",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("삭제");
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
        			, "ds_org=out_org_list" //strOutDatasets - select Fds = Sds
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
        	let level=0;
        	if(p_level==0){
        		level=1
        	}else{
        		level=2
        	}
        	let addedRow = this.ds_org.insertRow(row+1);
        	this.ds_org.setColumn(addedRow,2,p_org_cd);
        	this.ds_org.setColumn(addedRow,3,level);
        	trace("추가된 로우 부모코드 : ", this.ds_org.getColumn(addedRow, "p_org_cd"))
        };
        //삭제
        this.btn_del = function(obj,e)
        {
        	let row = this.grd_tree.currentrow;
        	trace(row);
        	this.ds_org.deleteRow(row);
        };

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

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M12_deptTeam_onload,this);
            this.grd_tree.addEventHandler("oncelldblclick",this.grd_tree_oncelldblclick,this);
            this.grd_tree.addEventHandler("onselectchanged",this.grd_tree_onselectchanged,this);
            this.sta_msg.addEventHandler("onclick",this.sta_msg_onclick,this);
            this.btn_add.addEventHandler("onclick",this.btn_add_onclick,this);
            this.btn_reset.addEventHandler("onclick",this.btn_reset_onclick,this);
            this.btn_save.addEventHandler("onclick",this.btn_save_onclick,this);
            this.btn_reset00.addEventHandler("onclick",this.btn_del,this);
        };

        this.loadIncludeScript("M12_deptTeam.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
