(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("work03");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("Dataset00", this);
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/><Column id=\"Column10\" type=\"STRING\" size=\"256\"/><Column id=\"Column11\" type=\"STRING\" size=\"256\"/><Column id=\"Column12\" type=\"STRING\" size=\"256\"/><Column id=\"Column13\" type=\"STRING\" size=\"256\"/><Column id=\"Column14\" type=\"STRING\" size=\"256\"/><Column id=\"Column15\" type=\"STRING\" size=\"256\"/><Column id=\"Column16\" type=\"STRING\" size=\"256\"/><Column id=\"Column17\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/><Row/></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("가장 큰 타이틀 입니다.");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","0","74",null,"105","10",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_cm_box01L");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","0","82","5.78%","25",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Static("Static03","0","115","5.78%","25",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Static("Static04","0","148","5.78%","25",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00","6.61%","82","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00","6.61%","115","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("Combo00");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo01","6.61%","148","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_text("Combo01");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01","19.91%","82","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            this.addChild(obj.name, obj);

            obj = new Static("Static05","18.35%","82","1.01%","25",null,null,null,null,null,null,this);
            obj.set_taborder("9");
            obj.set_text("~");
            obj.set_cssclass("sta_cm_text12C");
            this.addChild(obj.name, obj);

            obj = new CheckBox("CheckBox00","31.56%","82","120","25",null,null,null,null,null,null,this);
            obj.set_taborder("10");
            obj.set_text("선택여부");
            this.addChild(obj.name, obj);

            obj = new Static("Static06","18.35%","115","7.8%","25",null,null,null,null,null,null,this);
            obj.set_taborder("11");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Static("Static07","18.35%","148","7.8%","25",null,null,null,null,null,null,this);
            obj.set_taborder("12");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo02","26.88%","115","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("13");
            obj.set_text("Combo02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00","26.88%","148","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("14");
            this.addChild(obj.name, obj);

            obj = new Static("Static08","38.44%","82","7.71%","25",null,null,null,null,null,null,this);
            obj.set_taborder("15");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Static("Static09","38.44%","115","7.71%","25",null,null,null,null,null,null,this);
            obj.set_taborder("16");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Static("Static10","38.44%","148","7.71%","25",null,null,null,null,null,null,this);
            obj.set_taborder("17");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo03","46.88%","82","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("18");
            obj.set_text("Combo03");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo04","46.88%","115","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("19");
            obj.set_text("Combo04");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo05","46.88%","148","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("20");
            obj.set_text("Combo05");
            this.addChild(obj.name, obj);

            obj = new Static("Static11","58.44%","82","8.35%","25",null,null,null,null,null,null,this);
            obj.set_taborder("21");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Static("Static12","58.44%","115","8.35%","25",null,null,null,null,null,null,this);
            obj.set_taborder("22");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Static("Static13","58.44%","148","8.35%","25",null,null,null,null,null,null,this);
            obj.set_taborder("23");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_text12R");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo06","68.44%","82","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("24");
            obj.set_text("Combo06");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo07","68.44%","115","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("25");
            obj.set_text("Combo07");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo08","68.44%","148","10.92%","25",null,null,null,null,null,null,this);
            obj.set_taborder("26");
            obj.set_text("Combo08");
            this.addChild(obj.name, obj);

            obj = new Button("Button00",null,"39","60","25","130",null,null,null,null,null,this);
            obj.set_taborder("27");
            obj.set_text("조회");
            obj.set_cssclass("btn_WF_search01");
            this.addChild(obj.name, obj);

            obj = new Button("Button01",null,"39","55","25","70",null,null,null,null,null,this);
            obj.set_taborder("28");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_save01");
            this.addChild(obj.name, obj);

            obj = new Button("Button02",null,"39","55","25","10",null,null,null,null,null,this);
            obj.set_taborder("29");
            obj.set_text("엑셀");
            obj.set_cssclass("btn_WF_excel01");
            this.addChild(obj.name, obj);

            obj = new Static("Static15","0","190",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("30");
            obj.set_text("중간 타이틀 입니다.");
            obj.set_cssclass("sta_WF_title02");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","0","224",null,"296","10",null,null,null,null,null,this);
            obj.set_taborder("31");
            obj.set_binddataset("Dataset00");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"30\" band=\"head\"/><Row size=\"30\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\" text=\"Column3\"/><Cell col=\"4\" text=\"Column4\"/><Cell col=\"5\" text=\"Column5\"/><Cell col=\"6\" text=\"Column6\"/><Cell col=\"7\" text=\"Column7\"/><Cell col=\"8\" text=\"Column8\"/><Cell col=\"9\" text=\"Column9\"/><Cell col=\"10\" text=\"Column10\"/><Cell col=\"11\" text=\"Column11\"/><Cell col=\"12\" text=\"Column12\"/><Cell col=\"13\" text=\"Column13\"/><Cell col=\"14\" text=\"Column14\"/><Cell col=\"15\" text=\"Column15\"/><Cell col=\"16\" text=\"Column16\"/><Cell col=\"17\" text=\"Column17\"/></Band><Band id=\"body\"><Cell text=\"bind:Column0\"/><Cell col=\"1\" text=\"bind:Column1\"/><Cell col=\"2\" text=\"bind:Column2\"/><Cell col=\"3\" text=\"bind:Column3\"/><Cell col=\"4\" text=\"bind:Column4\"/><Cell col=\"5\" text=\"bind:Column5\"/><Cell col=\"6\" text=\"bind:Column6\"/><Cell col=\"7\" text=\"bind:Column7\"/><Cell col=\"8\" text=\"bind:Column8\"/><Cell col=\"9\" text=\"bind:Column9\"/><Cell col=\"10\" text=\"bind:Column10\"/><Cell col=\"11\" text=\"bind:Column11\"/><Cell col=\"12\" text=\"bind:Column12\"/><Cell col=\"13\" text=\"bind:Column13\"/><Cell col=\"14\" text=\"bind:Column14\"/><Cell col=\"15\" text=\"bind:Column15\"/><Cell col=\"16\" text=\"bind:Column16\"/><Cell col=\"17\" text=\"bind:Column17\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("Static17","0","520",null,"30","10",null,null,null,null,null,this);
            obj.set_taborder("32");
            obj.set_text("386건이 검색되었습니다.");
            obj.set_cssclass("sta_WF_notice01");
            this.addChild(obj.name, obj);

            obj = new Static("Static20",null,"0","263","34","10",null,null,null,null,null,this);
            obj.set_taborder("33");
            obj.set_text("· Home > Middle title > navi");
            obj.set_cssclass("sta_WF_navi");
            this.addChild(obj.name, obj);

            obj = new Button("Button04",null,"109","70","70","10",null,null,null,null,null,this);
            obj.set_taborder("34");
            obj.set_cssclass("btn_WF_search03");
            this.addChild(obj.name, obj);

            obj = new Button("Button05",null,"39","55","25","195",null,null,null,null,null,this);
            obj.set_taborder("35");
            obj.set_text("삭제");
            obj.set_cssclass("btn_WF_delete01");
            this.addChild(obj.name, obj);

            obj = new Button("Button06",null,"39","55","25","255",null,null,null,null,null,this);
            obj.set_taborder("36");
            obj.set_text("추가");
            obj.set_cssclass("btn_WF_add01");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("work03.xfdl", function() {
        this.Button06_onclick = function(obj,e)
        {
        	alert("추가");
        };

        this.Button05_onclick = function(obj,e)
        {
        	alert("삭제");
        };

        this.Button00_onclick = function(obj,e)
        {
        	alert("조회");
        };

        this.Button01_onclick = function(obj,e)
        {
        	alert("저장");
        };

        this.Button02_onclick = function(obj,e)
        {
        	alert("엑셀");
        };

        this.Calendar00_onchanged = function(obj,e)
        {

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.Calendar00.addEventHandler("onchanged",this.Calendar00_onchanged,this);
            this.Button00.addEventHandler("onclick",this.Button00_onclick,this);
            this.Button01.addEventHandler("onclick",this.Button01_onclick,this);
            this.Button02.addEventHandler("onclick",this.Button02_onclick,this);
            this.Button05.addEventHandler("onclick",this.Button05_onclick,this);
            this.Button06.addEventHandler("onclick",this.Button06_onclick,this);
        };

        this.loadIncludeScript("work03.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
