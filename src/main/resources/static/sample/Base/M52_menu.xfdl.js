(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M52_menu");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_sidebar", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"mid_code\" type=\"INT\" size=\"256\"/><Column id=\"mid_name\" type=\"STRING\" size=\"256\"/><Column id=\"sub_name\" type=\"STRING\" size=\"256\"/><Column id=\"menu_seq\" type=\"INT\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/><Column id=\"board_menu_seq\" type=\"INT\" size=\"256\"/><Column id=\"menu_name\" type=\"STRING\" size=\"256\"/><Column id=\"type\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"chk\" type=\"STRING\" size=\"1\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Div("div_detail","709","120","361","455",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("");
            obj.set_cssclass("sta_cm_box01L");
            obj.set_border("1px solid gray");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00","0","121","110","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("0");
            obj.set_text("상태");
            obj.set_cssclass("sta_cm_box01R");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static01_00_00","0","153","110","286",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("1");
            obj.set_text("설명");
            obj.set_cssclass("sta_cm_box01R");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static01_00_01","0","28","110","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("4");
            obj.set_text("대분류");
            obj.set_cssclass("sta_cm_box01R");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static28_00","110","28","240","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("5");
            obj.set_cssclass("sta_cm_box02L");
            this.div_detail.addChild(obj.name, obj);

            obj = new Edit("Edit07","120","32","140","24",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("6");
            obj.set_readonly("true");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static28_00_00","110","58","240","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("7");
            obj.set_cssclass("sta_cm_box02L");
            this.div_detail.addChild(obj.name, obj);

            obj = new Edit("Edit07_00","120","62","140","24",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("8");
            obj.set_readonly("true");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static01_00_01_00","0","58","110","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("9");
            obj.set_text("중분류");
            obj.set_cssclass("sta_cm_box01R");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static28_00_00_00","110","89","240","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("10");
            obj.set_cssclass("sta_cm_box02L");
            this.div_detail.addChild(obj.name, obj);

            obj = new Edit("Edit07_00_00","120","92","140","24",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("11");
            obj.set_readonly("true");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static01_00_01_00_00","0","89","110","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("12");
            obj.set_text("소분류");
            obj.set_cssclass("sta_cm_box01R");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static28_00_00_00_00","110","153","240","286",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("13");
            obj.set_cssclass("sta_cm_box02L");
            this.div_detail.addChild(obj.name, obj);

            obj = new TextArea("TextArea00","120","163","220","266",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("2");
            obj.set_scrolltype("vertical");
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static28_00_00_00_01","111","121","240","32",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("14");
            obj.set_cssclass("sta_cm_box02L");
            this.div_detail.addChild(obj.name, obj);

            obj = new Radio("rds_status","123","124","185","27",null,null,null,null,null,null,this.div_detail.form);
            obj.set_taborder("3");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("2");
            var div_detail_form_rds_status_innerdataset = new nexacro.NormalDataset("div_detail_form_rds_status_innerdataset", obj);
            div_detail_form_rds_status_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">Y</Col><Col id=\"datacolumn\">보임</Col></Row><Row><Col id=\"datacolumn\">안보임</Col><Col id=\"codecolumn\">N</Col></Row></Rows>");
            obj.set_innerdataset(div_detail_form_rds_status_innerdataset);
            this.div_detail.addChild(obj.name, obj);

            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("메뉴 관리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Div("div_sidebar","10","120","690","456",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("");
            obj.set_border("1px solid gray");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_menu_manage","19","26","654","393",null,null,null,null,null,null,this.div_sidebar.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_sidebar");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"61\"/><Column size=\"80\"/><Column size=\"142\"/><Column size=\"235\"/><Column size=\"223\"/><Column size=\"292\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell edittype=\"none\" text=\"chk\"/><Cell col=\"1\" text=\"번호\"/><Cell col=\"2\" text=\"대분류\"/><Cell col=\"3\" text=\"중분류\"/><Cell col=\"4\" text=\"소분류\"/><Cell col=\"5\" text=\"설명\"/><Cell col=\"6\" text=\"상태\"/></Band><Band id=\"body\"><Cell edittype=\"checkbox\" displaytype=\"checkboxcontrol\" text=\"bind:chk\" checkboxtruevalue=\"1\" checkboxfalsevalue=\"0\"/><Cell col=\"1\" text=\"bind:code\"/><Cell col=\"2\" text=\"bind:menu_name\"/><Cell col=\"3\" text=\"bind:mid_name\"/><Cell col=\"4\" text=\"bind:sub_name\"/><Cell col=\"5\" text=\"bind:contents\" edittype=\"normal\"/><Cell col=\"6\" text=\"bind:status\" edittype=\"mask\" maskedittype=\"string\" maskedittrimtype=\"both\" maskeditformat=\"A\" displaytype=\"mask\"/></Band></Format></Formats>");
            this.div_sidebar.addChild(obj.name, obj);

            obj = new Button("btn_update","960","585","110","30",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("변경사항 적용");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","10","60",null,"50","20",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_cssclass("sta_cm_box01L");
            obj.set_text("");
            this.addChild(obj.name, obj);

            obj = new Button("btn_reload","844","586","110","30",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("목록 불러오기");
            this.addChild(obj.name, obj);

            obj = new Button("btn_reset","763","586","70","30",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("초기화");
            this.addChild(obj.name, obj);

            obj = new Static("Static03","10","73","5.78%","25",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_text("대분류");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Combo("combo_menu","7.43%","73","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_type("filterlike");
            var combo_menu_innerdataset = new nexacro.NormalDataset("combo_menu_innerdataset", obj);
            combo_menu_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">0</Col><Col id=\"datacolumn\">전체보기</Col></Row><Row><Col id=\"codecolumn\">1</Col><Col id=\"datacolumn\">업무일지</Col></Row><Row><Col id=\"codecolumn\">2</Col><Col id=\"datacolumn\">전자결재</Col></Row><Row><Col id=\"codecolumn\">3</Col><Col id=\"datacolumn\">일정관리</Col></Row><Row><Col id=\"codecolumn\">4</Col><Col id=\"datacolumn\">근태현황</Col></Row><Row><Col id=\"codecolumn\">5</Col><Col id=\"datacolumn\">전자우편</Col></Row><Row><Col id=\"codecolumn\">6</Col><Col id=\"datacolumn\">커뮤니티</Col></Row><Row><Col id=\"codecolumn\">7</Col><Col id=\"datacolumn\">개인정보</Col></Row><Row><Col id=\"codecolumn\">8</Col><Col id=\"datacolumn\">조직도</Col></Row><Row><Col id=\"codecolumn\">9</Col><Col id=\"datacolumn\">버그리포팅</Col></Row></Rows>");
            obj.set_innerdataset(combo_menu_innerdataset);
            this.addChild(obj.name, obj);

            obj = new Static("Static06","18.72%","73","7.80%","25",null,null,null,null,null,null,this);
            obj.set_taborder("9");
            obj.set_text("상태");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Radio("rds_status_search","318","73","245","27",null,null,null,null,null,null,this);
            obj.set_taborder("10");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("3");
            var rds_status_search_innerdataset = new nexacro.NormalDataset("rds_status_search_innerdataset", obj);
            rds_status_search_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">A</Col><Col id=\"datacolumn\">전체</Col></Row><Row><Col id=\"codecolumn\">Y</Col><Col id=\"datacolumn\">보임</Col></Row><Row><Col id=\"datacolumn\">안보임</Col><Col id=\"codecolumn\">N</Col></Row></Rows>");
            obj.set_innerdataset(rds_status_search_innerdataset);
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item0","div_detail.form.TextArea00","value","ds_sidebar","contents");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","div_detail.form.rds_status","value","ds_sidebar","status");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item4","div_detail.form.Edit07_00","value","ds_sidebar","mid_name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item5","div_detail.form.Edit07","value","ds_sidebar","menu_name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item6","div_detail.form.Edit07_00_00","value","ds_sidebar","sub_name");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M52_menu.xfdl", function() {
        this.M52_menu_onload = function(obj,e)
        {
        	this.transaction(
        			"getSidebarList" // 1. strSvcID
        			,"/sidebar/getSidebarList.nex" // 2. strURL
        			,"" // 3. inData Sds=Fds:U,:A,:N
        			,"ds_sidebar=out_ds" // 4. utData - select Fds=Sds
        			,"" // 5. strArgument
        			,"fn_callback" // 6. strCallbackFunc
        		)
        };

        this.fn_callback = function(result)
        {
        	trace("도착성공!");
        }

        this.btn_update_onclick = function(obj,e)
        {
        	this.transaction(
        			"updateSidebar" // 1. strSvcID
        			,"/sidebar/updateSidebar.nex" // 2. strURL
        			,"in_ds=ds_sidebar:U" // 3. inData Sds=Fds:U,:A,:N
        			,"" // 4. utData - select Fds=Sds
        			,"" // 5. strArgument
        			,"fn_callback" // 6. strCallbackFunc
        		)
        	this.M52_menu.reload();
        };

        this.btn_reload_onclick = function(obj,e)
        {
        	this.M52_menu.reload();
        };


        this.btn_reset_onclick = function(obj,e)
        {
        	this.ds_sidebar.filter("");
        };


        this.btn_search_onclick = function(obj,e)
        {

        };

        this.div_search_rdo_gender_onitemchanged = function(obj,e)
        {
        	if(e.postvalue == "A")
        	{
        		this.ds_emp.filter("");
        	}
        	else
        	{
        		this.ds_emp.filter("GENDER == '" + e.postvalue + "'");
        	}
        };

        // status로 검색
        this.search_rdo_status = function(obj,e)
        {
        	if(e.postvalue == "A"){
        		this.ds_sidebar.filter("");
        	}else{
        		this.ds_sidebar.filter("status == '" + e.postvalue + "'");
        	}
        };

        // 대분류로 검색(menu_seq)
        this.search_combo_menu_seq = function(obj,e)
        {
        	if(e.postvalue == "0"){
        		this.ds_sidebar.filter("");
        	}else {
        		this.ds_sidebar.filter("menu_seq == '" + e.postvalue + "'");
        	}

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M52_menu_onload,this);
            this.btn_update.addEventHandler("onclick",this.btn_update_onclick,this);
            this.btn_reload.addEventHandler("onclick",this.btn_reload_onclick,this);
            this.btn_reset.addEventHandler("onclick",this.btn_reset_onclick,this);
            this.combo_menu.addEventHandler("onitemchanged",this.search_combo_menu_seq,this);
            this.rds_status_search.addEventHandler("onitemchanged",this.search_rdo_status,this);
        };

        this.loadIncludeScript("M52_menu.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
