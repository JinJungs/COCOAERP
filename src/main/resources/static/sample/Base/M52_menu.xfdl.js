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
            obj = new Div("div_search_input","20","100",null,"50","100",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("");
            obj.set_background("#eeeeee");
            obj.set_border("1px solid #c7c7c7");
            this.addChild(obj.name, obj);

            obj = new Static("Static03_00_00","538","10","50","25",null,null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("0");
            obj.set_text("이름");
            obj.set_cssclass("sta_cm_text12R");
            this.div_search_input.addChild(obj.name, obj);

            obj = new Edit("edt_name","598","10","100","25",null,null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("1");
            this.div_search_input.addChild(obj.name, obj);

            obj = new Radio("rds_status_search","278","10","230","27",null,null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("2");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("3");
            obj.getSetter("onclick").set("rds_status_search_onclick");
            var div_search_input_form_rds_status_search_innerdataset = new nexacro.NormalDataset("div_search_input_form_rds_status_search_innerdataset", obj);
            div_search_input_form_rds_status_search_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">A</Col><Col id=\"datacolumn\">전체</Col></Row><Row><Col id=\"codecolumn\">Y</Col><Col id=\"datacolumn\">보임</Col></Row><Row><Col id=\"datacolumn\">안보임</Col><Col id=\"codecolumn\">N</Col></Row></Rows>");
            obj.set_innerdataset(div_search_input_form_rds_status_search_innerdataset);
            this.div_search_input.addChild(obj.name, obj);

            obj = new Static("Static03_00","218","11","50","25",null,null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("3");
            obj.set_text("상태");
            obj.set_cssclass("sta_cm_text12R");
            this.div_search_input.addChild(obj.name, obj);

            obj = new Combo("combo_menu","60","11","110","25",null,null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("4");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_type("filterlike");
            var div_search_input_form_combo_menu_innerdataset = new nexacro.NormalDataset("div_search_input_form_combo_menu_innerdataset", obj);
            div_search_input_form_combo_menu_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">0</Col><Col id=\"datacolumn\">전체보기</Col></Row><Row><Col id=\"codecolumn\">1</Col><Col id=\"datacolumn\">업무일지</Col></Row><Row><Col id=\"codecolumn\">2</Col><Col id=\"datacolumn\">전자결재</Col></Row><Row><Col id=\"codecolumn\">3</Col><Col id=\"datacolumn\">일정관리</Col></Row><Row><Col id=\"codecolumn\">4</Col><Col id=\"datacolumn\">근태현황</Col></Row><Row><Col id=\"codecolumn\">5</Col><Col id=\"datacolumn\">전자우편</Col></Row><Row><Col id=\"codecolumn\">6</Col><Col id=\"datacolumn\">커뮤니티</Col></Row><Row><Col id=\"codecolumn\">7</Col><Col id=\"datacolumn\">개인정보</Col></Row><Row><Col id=\"codecolumn\">8</Col><Col id=\"datacolumn\">조직도</Col></Row><Row><Col id=\"codecolumn\">9</Col><Col id=\"datacolumn\">버그리포팅</Col></Row></Rows>");
            obj.set_innerdataset(div_search_input_form_combo_menu_innerdataset);
            this.div_search_input.addChild(obj.name, obj);

            obj = new Static("Static03","0","11","50","25",null,null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("5");
            obj.set_text("대분류");
            obj.set_cssclass("sta_cm_text12R");
            this.div_search_input.addChild(obj.name, obj);

            obj = new Button("btn_reset",null,"11","70","25","80",null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("6");
            obj.set_text("초기화");
            obj.set_cssclass("btn_WF_reset01");
            this.div_search_input.addChild(obj.name, obj);

            obj = new Button("btn_search",null,"11","60","25","10",null,null,null,null,null,this.div_search_input.form);
            obj.set_taborder("7");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_search01");
            this.div_search_input.addChild(obj.name, obj);

            obj = new Button("btn_update",null,"55","110","35","100",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("변경사항 적용");
            obj.set_cssclass("btn_WF_save01");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_menu_manage","20","170",null,null,"560","50","300",null,null,null,this);
            obj.set_taborder("1");
            obj.set_binddataset("ds_sidebar");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"61\"/><Column size=\"80\"/><Column size=\"142\"/><Column size=\"235\"/><Column size=\"223\"/><Column size=\"292\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell edittype=\"none\" text=\"chk\"/><Cell col=\"1\" text=\"번호\"/><Cell col=\"2\" text=\"대분류\"/><Cell col=\"3\" text=\"중분류\"/><Cell col=\"4\" text=\"소분류\"/><Cell col=\"5\" text=\"설명\"/><Cell col=\"6\" text=\"상태\"/></Band><Band id=\"body\"><Cell edittype=\"checkbox\" displaytype=\"checkboxcontrol\" text=\"bind:chk\" checkboxtruevalue=\"1\" checkboxfalsevalue=\"0\"/><Cell col=\"1\" text=\"bind:code\" textAlign=\"left\"/><Cell col=\"2\" text=\"bind:menu_name\"/><Cell col=\"3\" text=\"bind:mid_name\"/><Cell col=\"4\" text=\"bind:sub_name\"/><Cell col=\"5\" text=\"bind:contents\" edittype=\"normal\"/><Cell col=\"6\" text=\"bind:status\" edittype=\"mask\" maskedittype=\"string\" maskedittrimtype=\"both\" maskeditformat=\"A\" displaytype=\"mask\" textAlign=\"center\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","20","10",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("메뉴 관리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Div("Div00","grd_menu_manage:10","170","450",null,null,"50",null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","0","0",null,"34","0",null,null,null,null,null,this.Div00.form);
            obj.set_taborder("0");
            obj.set_text("메뉴 수정");
            obj.set_cssclass("sta_WF_title01");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_06_00","122","124",null,"46","20",null,null,null,null,null,this.Div00.form);
            obj.set_taborder("1");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_00","20","124","120","46",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("2");
            obj.set_text("중분류");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01","20","77","120","46",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("3");
            obj.set_text("대분류");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("sta_form","122","77",null,"46","20",null,null,null,null,null,this.Div00.form);
            obj.set_taborder("4");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_border("1px solid #c9c9c9,0px none");
            obj.set_text("");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_06_00_00","122","170",null,"46","21",null,null,null,null,null,this.Div00.form);
            obj.set_taborder("5");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_00_00","20","170","120","46",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("6");
            obj.set_text("소분류");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_00_00_00","20","216","120","46",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("7");
            obj.set_text("상태");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_06_00_00_00","122","216",null,"46","22",null,null,null,null,null,this.Div00.form);
            obj.set_taborder("8");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Radio("rds_status","150","226","185","27",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("9");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("2");
            var Div00_form_rds_status_innerdataset = new nexacro.NormalDataset("Div00_form_rds_status_innerdataset", obj);
            Div00_form_rds_status_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">Y</Col><Col id=\"datacolumn\">보임</Col></Row><Row><Col id=\"datacolumn\">안보임</Col><Col id=\"codecolumn\">N</Col></Row></Rows>");
            obj.set_innerdataset(Div00_form_rds_status_innerdataset);
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_00_00_00_00","20","262","120","137",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("10");
            obj.set_text("설명");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01_06_00_00_00_00","122","262",null,"137","22",null,null,null,null,null,this.Div00.form);
            obj.set_taborder("11");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new TextArea("TextArea00","150","272","268","117",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("12");
            obj.set_scrolltype("vertical");
            obj.set_wordWrap("char");
            this.Div00.addChild(obj.name, obj);

            obj = new Edit("Edit07","150","84","131","32",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("13");
            obj.set_readonly("true");
            this.Div00.addChild(obj.name, obj);

            obj = new Edit("Edit07_00","150","130","131","32",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("14");
            obj.set_readonly("true");
            this.Div00.addChild(obj.name, obj);

            obj = new Edit("Edit07_00_00","150","176","131","32",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("15");
            obj.set_readonly("true");
            this.Div00.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item3","Div00.form.sta_form","text","tp_title","title");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","Div00.form.rds_status","value","ds_sidebar","status");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item7","Div00.form.TextArea00","value","ds_sidebar","contents");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item5","Div00.form.Edit07","value","ds_sidebar","menu_name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","Div00.form.Edit07_00","value","ds_sidebar","mid_name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item6","Div00.form.Edit07_00_00","value","ds_sidebar","sub_name");
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

        // 검색 ?
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

        // 이름으로 검색
        this.edt_name_onchanged = function(obj,e)
        {

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M52_menu_onload,this);
            this.div_search_input.form.edt_name.addEventHandler("onchanged",this.edt_name_onchanged,this);
            this.div_search_input.form.rds_status_search.addEventHandler("onitemchanged",this.search_rdo_status,this);
            this.div_search_input.form.combo_menu.addEventHandler("onitemchanged",this.search_combo_menu_seq,this);
            this.div_search_input.form.btn_reset.addEventHandler("onclick",this.btn_reset_onclick,this);
            this.div_search_input.form.btn_search.addEventHandler("onclick",this.btn_search_onclick,this);
            this.btn_update.addEventHandler("onclick",this.btn_update_onclick,this);
        };

        this.loadIncludeScript("M52_menu.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
