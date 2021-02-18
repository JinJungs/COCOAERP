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
            obj._setContents("<ColumnInfo><Column id=\"org_nm\" type=\"STRING\" size=\"256\"/><Column id=\"org_cd\" type=\"INT\" size=\"256\"/><Column id=\"p_org_cd\" type=\"INT\" size=\"256\"/><Column id=\"level\" type=\"INT\" size=\"256\"/></ColumnInfo>");
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

            obj = new Static("sta_msg","340","100","270","90",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("부서, 팀 추가, 삭제, 이름 수정 기능 미구현");
            obj.set_background("#cecece");
            obj.set_textAlign("center");
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
        	this.sta_org.set_text(sTreePath);

        	this.ds_emp.filter("ORG_CD == '" + this.ds_org.getColumn(e.row, "ORG_CD") + "'");
        	this.ds_emp.set_rowposition(0);
        };
        */

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M12_deptTeam_onload,this);
            this.grd_tree.addEventHandler("oncellclick",this.grd_tree_oncellclick,this);
            this.sta_msg.addEventHandler("onclick",this.sta_msg_onclick,this);
        };

        this.loadIncludeScript("M12_deptTeam.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
