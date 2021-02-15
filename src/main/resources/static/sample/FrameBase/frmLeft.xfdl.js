(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("fm_left");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(190,700);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Grid("grdLeft","0","40","190",null,null,"75",null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_binddataset("gdsLeftMenu");
            obj.set_autofittype("col");
            obj.set_treeusecheckbox("false");
            obj.set_cssclass("grd_LF_treeMenu");
            obj.set_treeinitstatus("expand,all");
            obj.set_border("0px solid #c7c7c7,1px solid #c7c7c7");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"180\"/></Columns><Rows><Row size=\"32\"/></Rows><Band id=\"body\"><Cell text=\"bind:MENU_NM\" displaytype=\"treeitemcontrol\" edittype=\"tree\" treelevel=\"bind:MENU_LVL\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","0","0","190","40",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("Main Title Menu");
            obj.set_cssclass("sta_LF_title01");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",190,700,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("frmLeft.xfdl", function() {
        this.application = null;

        this.fm_left_onload = function(obj,e)
        {
        	this.application = nexacro.getApplication();
        };

        this.divLeft_grdLeft_oncellclick = function(obj,e)
        {
        	var sMenuId = this.application.gdsLeftMenu.getColumn(e.row, "MENU_CD");

        	this.fn_openMenu(sMenuId);
        };

        this.fn_openMenu = function(sMenuId)
        {
        	var objMdiFrame = this.application.MdiFrame;
        	var objWorkFrame = this.application.WorkFrame;

        	var nFRow;
        	var sPGMPATH;
        	var sPGMID;

        	var nFRowOpen;
        	var sWinId;
        	var sMenuNm;
        	var sMenuNavi;

        	var objMenuDs = this.application.gdsLeftMenu;
        	var objOpenMenuDs = this.application.gdsOpenMenu;

        	nFRow 		= objMenuDs.findRow("MENU_CD", sMenuId);
        	sPGMPATH 	= objMenuDs.getColumn(nFRow, "PGM_PATH");
        	sPGMID 		= objMenuDs.getColumn(nFRow, "PGM_ID")
        	sMenuNm 	= objMenuDs.getColumn(nFRow, "MENU_NM");

        	nFRowOpen = objOpenMenuDs.findRow("MENU_CD", sMenuId);
        	sWinId = objOpenMenuDs.getColumn(nFRowOpen, "WINID");

        	if (nFRow==-1)
        	{
        		alert("Menu가 존재하지 않습니다.");
        		return;

        	}else if(this.gfnIsNull(sPGMPATH)==true)
        	{
        		return;
        	}

        	if(nFRowOpen>-1)
        	{
        		objMdiFrame.form.fn_ActiveTabPage(sWinId);
        		return;
        	}

        	if(objOpenMenuDs.rowcount > 12)
        	{
        		alert("메뉴는  8개이상 오픈할 수 없습니다.");
        		return;
        	}

        	sWinId = sMenuId + "_" + objOpenMenuDs.rowcount+ "_" + parseInt(Math.random() * 100);

        	var oParam = { FORM_ID : sWinId,
                           MENU_NM : sMenuNm,
                           FORM_URL : sPGMPATH+"::"+sPGMID
        				   };

        	var objChildFrame = new ChildFrame();
        	objChildFrame.init(sWinId, 0, 0, null, null, 0, 0);

        	objWorkFrame.addChild(objChildFrame.name, objChildFrame);
        	objChildFrame.param = oParam;
        	objChildFrame.set_resizable(true);
        	objChildFrame.set_showtitlebar(false);
         	objChildFrame.set_openstatus("maximize");
        	objChildFrame.set_formurl("FrameBase::frmWork.xfdl");
        	objChildFrame.show();

        	objMdiFrame.form.fn_AddTabPage(sWinId, sMenuNm);

        	this.fn_AddOpenMenu(sWinId, sMenuId, sMenuNm);

        	objMdiFrame.form.fn_ActiveTabPage(sWinId);
        }

        /*****************************************************************************
        함 수 명 칭 : gfnAddOpenMenu
        함 수 설 명 : 열린화면리스트 저장
        파 라 미 터 : pvWinId – 업무화면 ID
        			   pvMenuCd – 메뉴코드
        			   pvMenuNm – 메뉴명
        리 턴 내 용 : 없음
        *****************************************************************************/
        this.fn_AddOpenMenu = function(pvWinId, pvMenuCd, pvMenuNm)
        {
        	var objOpenMenuDs = this.application.gdsOpenMenu;

        	var nAddRow = objOpenMenuDs.addRow();
        	objOpenMenuDs.setColumn(nAddRow, "WINID", pvWinId);
        	objOpenMenuDs.setColumn(nAddRow, "MENU_CD", pvMenuCd);
        	objOpenMenuDs.setColumn(nAddRow, "MENU_NM", pvMenuNm);
        }

        /*****************************************************************************
        함 수 명 칭 : gfnDelOpenMenu
        함 수 설 명 : 열린화면리스트 삭제
        파 라 미 터 : pvWinId – 업무화면 ID
        리 턴 내 용 : 없음
        *****************************************************************************/
        this.fn_DelOpenMenu = function(pvWinId)
        {
        	var objOpenMenuDs = this.application.gdsOpenMenu;

        	var nRow = objOpenMenuDs.findRow("WINID", pvWinId);

        	objOpenMenuDs.deleteRow(nRow);
        }

        /*****************************************************************************
        함 수 명 칭 : gfnIsNull
        함 수 설 명 : 입력값 Null 체크 함수
        파 라 미 터 : pvVal – 입력값
        리 턴 내 용 : true/false 값이 Null일 경우 true
        *****************************************************************************/
        this.gfnIsNull = function (pvVal)
        {
        	if (new String(pvVal).valueOf() == "undefined")
        	{
        		return true;
        	}
        	if (pvVal == null)
        	{
        		return true;
        	}
        	if (("x" + pvVal == "xNaN") && (new String(pvVal.length).valueOf() == "undefined"))
        	{
        		return true;
        	}
        	if (pvVal.length == 0)
        	{
        		return true;
        	}

        	return false;
        }

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.fm_left_onload,this);
            this.grdLeft.addEventHandler("oncellclick",this.divLeft_grdLeft_oncellclick,this);
        };

        this.loadIncludeScript("frmLeft.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
