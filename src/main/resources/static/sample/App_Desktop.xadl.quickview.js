(function()
{
    return function()
    {
        this.on_loadAppVariables = function()
        {		
            var obj = null;
            
            // global dataset
            obj = new Dataset("gdsOpenList", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"caption\" type=\"STRING\" size=\"256\"/><Column id=\"BTN_ID\" type=\"STRING\" size=\"256\"/><Column id=\"BTN_EX_ID\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);


            obj = new Dataset("gdsLeftMenu", this);
            obj._setContents("<ColumnInfo><Column id=\"MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"UP_MENU_CD\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_NM\" type=\"STRING\" size=\"256\"/><Column id=\"MENU_LVL\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_PATH\" type=\"STRING\" size=\"256\"/><Column id=\"PGM_ID\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"MENU_CD\">0010</Col><Col id=\"UP_MENU_CD\">0</Col><Col id=\"MENU_NM\">조직 관리</Col><Col id=\"MENU_LVL\">0</Col></Row><Row><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_CD\">0011</Col><Col id=\"MENU_NM\">사용자 관리</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"PGM_ID\">M11_users.xfdl</Col></Row><Row><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_CD\">0012</Col><Col id=\"MENU_NM\">부서 / 팀 관리</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_ID\">M12_deptTeam.xfdl</Col></Row><Row><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_CD\">0013</Col><Col id=\"MENU_NM\">직급 관리</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_ID\">M13_position.xfdl</Col></Row><Row><Col id=\"MENU_NM\">회사 일정 관리</Col><Col id=\"MENU_CD\">0020</Col><Col id=\"UP_MENU_CD\">0</Col><Col id=\"MENU_LVL\">0</Col></Row><Row><Col id=\"MENU_NM\">회사 일정 관리</Col><Col id=\"MENU_CD\">0021</Col><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"PGM_ID\">M21_companySchedule.xfdl</Col></Row><Row><Col id=\"MENU_CD\">0030</Col><Col id=\"UP_MENU_CD\">0</Col><Col id=\"MENU_NM\">휴가 관리</Col><Col id=\"MENU_LVL\">0</Col></Row><Row><Col id=\"MENU_CD\">0031</Col><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_NM\">휴가 사용처리</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"PGM_ID\">M31_grantVacation.xfdl</Col></Row><Row><Col id=\"MENU_CD\">0032</Col><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_NM\">휴가 부여</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"PGM_ID\">M32_approveVaction.xfdl</Col></Row><Row><Col id=\"MENU_CD\">0040</Col><Col id=\"UP_MENU_CD\">0</Col><Col id=\"MENU_NM\">세부 양식 관리</Col><Col id=\"MENU_LVL\">0</Col></Row><Row><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_CD\">0041</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"MENU_NM\">파일 양식 관리</Col><Col id=\"PGM_ID\">M41_fileForm.xfdl</Col><Col id=\"PGM_PATH\">Base</Col></Row><Row><Col id=\"MENU_CD\">0050</Col><Col id=\"UP_MENU_CD\">0</Col><Col id=\"MENU_LVL\">0</Col><Col id=\"MENU_NM\">페이지 관리</Col></Row><Row><Col id=\"MENU_NM\">메뉴 관리</Col><Col id=\"MENU_CD\">0052</Col><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"PGM_ID\">M52_menu.xfdl</Col></Row><Row><Col id=\"MENU_CD\">0053</Col><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_NM\">게시판 관리</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"PGM_ID\">M53_board.xfdl</Col></Row><Row><Col id=\"MENU_CD\">0060</Col><Col id=\"UP_MENU_CD\">0</Col><Col id=\"MENU_NM\">버그리포트</Col><Col id=\"MENU_LVL\">0</Col></Row><Row><Col id=\"MENU_CD\">0061</Col><Col id=\"UP_MENU_CD\">0000</Col><Col id=\"MENU_NM\">버그리포트 전송</Col><Col id=\"MENU_LVL\">1</Col><Col id=\"PGM_PATH\">Base</Col><Col id=\"PGM_ID\">M61_bugReport.xfdl</Col></Row></Rows>");
            this._addDataset(obj.name, obj);


            obj = new Dataset("gdsOpenMenu", this);
            obj._setContents("<ColumnInfo><Column id=\"MENU_CD\" type=\"STRING\" size=\"8\"/><Column id=\"UP_MENU_CD\" type=\"STRING\" size=\"8\"/><Column id=\"MENU_NM\" type=\"STRING\" size=\"50\"/><Column id=\"MENU_LVL\" type=\"BIGDECIMAL\" size=\"22\"/><Column id=\"PGM_PATH\" type=\"STRING\" size=\"200\"/><Column id=\"PGM_ID\" type=\"STRING\" size=\"200\"/><Column id=\"WINID\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this._addDataset(obj.name, obj);
            
            // global variable
            this._addVariable("resultAdd","0");
            this._addVariable("resultModif","0");
            
            obj = null;
        };
        
        // property, event, createMainFrame
        this.on_initApplication = function()
        {
            // properties
            this.set_id("App_Desktop");
            this.set_screenid("Desktop_screen");

            if (this._is_attach_childframe)
            	return;
            
            // frame
            var mainframe = this.createMainFrame("mainframe","0","0","1280","720",null,null,this);
            mainframe.set_showtitlebar("true");
            mainframe.set_showstatusbar("false");
            mainframe.set_titletext("MDI (Frameset)");
            mainframe.on_createBodyFrame = this.mainframe_createBodyFrame;

            // tray

        };
        
        this.loadPreloadList = function()
        {

        };
        
        this.mainframe_createBodyFrame = function()
        {
            var obj = new ChildFrame("QuickViewFrame", null, null, null, null, null, null, "", this);
            
            obj.set_showtitlebar("false");
            obj.set_showstatusbar("false");
            obj.set_border("0px none");
			
            this.addChild(obj.name, obj);

            obj.set_formurl(nexacro._quickview_formurl);

            this.frame = obj;
            
            obj = null;
        };
        
        this.on_initEvent = function()
        {
        };

		// script Compiler
        this.registerScript("App_Desktop.xadl", function() {
        this.VFSet01;
        this.VFSet02;
        this.HFSet01;
        this.TopFrame;
        this.LeftFrame;
        this.MdiFrame;
        this.BottomFrame;
        this.WorkFrame;

        this.Application_onload = function(obj,e)
        {
        	this.VFSet01 = this.mainframe.VFSet01;
        	this.VFSet02 = this.mainframe.VFSet01.HFSet01.VFSet02;
        	this.HFSet01 = this.mainframe.VFSet01.HFSet01;
        	this.TopFrame = this.mainframe.VFSet01.TopFrame;
        	this.LeftFrame = this.mainframe.VFSet01.HFSet01.LeftFrame;
        	this.MdiFrame = this.mainframe.VFSet01.HFSet01.VFSet02.MdiFrame;
        	this.BottomFrame = this.mainframe.VFSet01.BottomFrame;
        	this.WorkFrame = this.mainframe.VFSet01.HFSet01.VFSet02.WorkFrame;
        };

        });
        
        this.loadPreloadList();
        this.loadCss("xcssrc::temp_main.xcss");
    };
}
)();
