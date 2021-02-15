(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("work01");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("Dataset00", this);
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/><Column id=\"Column3\" type=\"STRING\" size=\"256\"/><Column id=\"Column4\" type=\"STRING\" size=\"256\"/><Column id=\"Column5\" type=\"STRING\" size=\"256\"/><Column id=\"Column6\" type=\"STRING\" size=\"256\"/><Column id=\"Column7\" type=\"STRING\" size=\"256\"/><Column id=\"Column8\" type=\"STRING\" size=\"256\"/><Column id=\"Column9\" type=\"STRING\" size=\"256\"/><Column id=\"Column10\" type=\"STRING\" size=\"256\"/><Column id=\"Column11\" type=\"STRING\" size=\"256\"/><Column id=\"Column12\" type=\"STRING\" size=\"256\"/><Column id=\"Column13\" type=\"STRING\" size=\"256\"/><Column id=\"Column14\" type=\"STRING\" size=\"256\"/><Column id=\"Column15\" type=\"STRING\" size=\"256\"/><Column id=\"Column16\" type=\"STRING\" size=\"256\"/><Column id=\"Column17\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row><Row><Col id=\"Column5\">홍길동</Col><Col id=\"Column6\">버튼</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("Dataset01", this);
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">여성</Col><Col id=\"Column1\">사무직</Col></Row><Row><Col id=\"Column0\">남성</Col><Col id=\"Column1\">기술직</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("수정이 되나요");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Tab("Tab00","0","44",null,"308","10",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_tabindex("0");
            this.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage1",this.Tab00);
            obj.set_text("Tabpage1");
            this.Tab00.addChild(obj.name, obj);

            obj = new Grid("Grid00","10","13",null,"228","10",null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("0");
            obj.set_binddataset("Dataset00");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"40\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"30\" band=\"head\"/><Row size=\"30\"/><Row size=\"30\" band=\"summ\"/></Rows><Band id=\"head\"><Cell text=\"Column0\"/><Cell col=\"1\" text=\"Column1\"/><Cell col=\"2\" text=\"Column2\"/><Cell col=\"3\" text=\"Column3\"/><Cell col=\"4\" text=\"Column4\"/><Cell col=\"5\" text=\"Column5\"/><Cell col=\"6\" text=\"Column6\"/><Cell col=\"7\" text=\"Column7\"/><Cell col=\"8\" text=\"Column8\"/><Cell col=\"9\" text=\"Column9\"/><Cell col=\"10\" text=\"Column10\"/><Cell col=\"11\" text=\"Column11\"/><Cell col=\"12\" text=\"Column12\"/><Cell col=\"13\" text=\"Column13\"/><Cell col=\"14\" text=\"Column14\"/><Cell col=\"15\" text=\"Column15\"/><Cell col=\"16\" text=\"Column16\"/><Cell col=\"17\" text=\"Column17\"/></Band><Band id=\"body\"><Cell text=\"bind:Column0\" displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"bind:Column1\" displaytype=\"editcontrol\" edittype=\"text\"/><Cell col=\"2\" text=\"bind:Column2\" displaytype=\"combocontrol\" edittype=\"combo\" combodataset=\"Dataset01\" combodatacol=\"Column0\" combocodecol=\"Column0\"/><Cell col=\"3\" text=\"bind:Column3\" displaytype=\"calendarcontrol\" edittype=\"date\"/><Cell col=\"4\" text=\"bind:Column4\" displaytype=\"maskeditcontrol\" edittype=\"text\"/><Cell col=\"5\" text=\"bind:Column5\" progressbarblocksize=\"50\" cssclass=\"cellCenter\"/><Cell col=\"6\" text=\"bind:Column6\" displaytype=\"buttoncontrol\" edittype=\"button\"/><Cell col=\"7\" text=\"bind:Column7\"/><Cell col=\"8\" text=\"bind:Column8\"/><Cell col=\"9\" text=\"bind:Column9\"/><Cell col=\"10\" text=\"bind:Column10\"/><Cell col=\"11\" text=\"bind:Column11\"/><Cell col=\"12\" text=\"bind:Column12\"/><Cell col=\"13\" text=\"bind:Column13\"/><Cell col=\"14\" text=\"bind:Column14\"/><Cell col=\"15\" text=\"bind:Column15\"/><Cell col=\"16\" text=\"bind:Column16\"/><Cell col=\"17\" text=\"bind:Column17\"/></Band><Band id=\"summary\"><Cell/><Cell col=\"1\"/><Cell col=\"2\"/><Cell col=\"3\"/><Cell col=\"4\"/><Cell col=\"5\"/><Cell col=\"6\"/><Cell col=\"7\"/><Cell col=\"8\"/><Cell col=\"9\"/><Cell col=\"10\"/><Cell col=\"11\"/><Cell col=\"12\"/><Cell col=\"13\"/><Cell col=\"14\"/><Cell col=\"15\"/><Cell col=\"16\"/><Cell col=\"17\"/></Band></Format></Formats>");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static00","10","240",null,"30","10",null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("1");
            obj.set_cssclass("sta_WF_pagingBox");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Button("Button00",null,"240","30","30","10",null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("2");
            obj.set_cssclass("btn_WF_pagingLast");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Button("Button01",null,"240","30","30","39",null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("3");
            obj.set_cssclass("btn_WF_pagingNext");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Button("Button02","10","240","30","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("4");
            obj.set_cssclass("btn_WF_pagingFirst");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Button("Button03","39","240","30","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("5");
            obj.set_cssclass("btn_WF_pagingPrev");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static01","328","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("6");
            obj.set_text("1");
            obj.set_cssclass("sta_WF_pagingNum");
            obj.set_enable("false");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static02","367","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("7");
            obj.set_text("2");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static03","406","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("8");
            obj.set_text("3");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static04","445","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("9");
            obj.set_text("4");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static05","484","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("10");
            obj.set_text("5");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static06","523","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("11");
            obj.set_text("6");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static07","562","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("12");
            obj.set_text("7");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static08","601","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("13");
            obj.set_text("8");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static09","640","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("14");
            obj.set_text("9");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Static("Static10","679","240","40","30",null,null,null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("15");
            obj.set_text("10");
            obj.set_cssclass("sta_WF_pagingNum");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage2",this.Tab00);
            obj.set_text("Tabpage2");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage3",this.Tab00);
            obj.set_text("Tabpage3");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage4",this.Tab00);
            obj.set_text("Tabpage4");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage5",this.Tab00);
            obj.set_text("Tabpage5");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage6",this.Tab00);
            obj.set_text("Tabpage6");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage7",this.Tab00);
            obj.set_text("Tabpage7");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage8",this.Tab00);
            obj.set_text("Tabpage8");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage9",this.Tab00);
            obj.set_text("Tabpage9");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage10",this.Tab00);
            obj.set_text("Tabpage10");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage11",this.Tab00);
            obj.set_text("Tabpage11");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage12",this.Tab00);
            obj.set_text("Tabpage12");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage13",this.Tab00);
            obj.set_text("Tabpage13");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage14",this.Tab00);
            obj.set_text("Tabpage14");
            this.Tab00.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage15",this.Tab00);
            obj.set_text("Tabpage15");
            this.Tab00.addChild(obj.name, obj);

            obj = new Static("Static20",null,"0","263","34","10",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("· Home > Middle title > navi");
            obj.set_cssclass("sta_WF_navi");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","0","396","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static08","109","396","271","32",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","0","362",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("중간 타이틀 입니다.");
            obj.set_cssclass("sta_WF_title02");
            this.addChild(obj.name, obj);

            obj = new Static("Static03","379","396","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static04","488","396","321","32",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static05","808","396","90","32",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static06","897","396",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("9");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static07","0","427","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("10");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static09","109","427","271","32",null,null,null,null,null,null,this);
            obj.set_taborder("11");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static10","379","427","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("12");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static11","488","427",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("13");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static14","0","458","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("14");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static15","109","458","271","32",null,null,null,null,null,null,this);
            obj.set_taborder("15");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static16","379","458","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("16");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static17","488","458","321","32",null,null,null,null,null,null,this);
            obj.set_taborder("17");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static18","808","458","90","32",null,null,null,null,null,null,this);
            obj.set_taborder("18");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static19","897","458",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("19");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static21","0","489","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("20");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static22","109","489","271","32",null,null,null,null,null,null,this);
            obj.set_taborder("21");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static23","379","489","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("22");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static24","488","489","321","32",null,null,null,null,null,null,this);
            obj.set_taborder("23");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static25","808","489","90","32",null,null,null,null,null,null,this);
            obj.set_taborder("24");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static26","897","489",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("25");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static27","0","520","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("26");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static28","109","520","271","32",null,null,null,null,null,null,this);
            obj.set_taborder("27");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static29","379","520","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("28");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static30","488","520","321","32",null,null,null,null,null,null,this);
            obj.set_taborder("29");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static31","808","520","90","32",null,null,null,null,null,null,this);
            obj.set_taborder("30");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static32","897","520",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("31");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00","119","400","70","24",null,null,null,null,null,null,this);
            obj.set_taborder("32");
            this.addChild(obj.name, obj);

            obj = new Button("Button00","189","400","24","24",null,null,null,null,null,null,this);
            obj.set_taborder("33");
            obj.set_cssclass("btn_WF_search02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01","223","400","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("34");
            this.addChild(obj.name, obj);

            obj = new Spin("Spin00","119","431","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("35");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00","498","400","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("36");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01","655","400","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("37");
            this.addChild(obj.name, obj);

            obj = new Static("Static33","641","400","9","24",null,null,null,null,null,null,this);
            obj.set_taborder("38");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit02","907","400","100","24",null,null,null,null,null,null,this);
            obj.set_taborder("39");
            this.addChild(obj.name, obj);

            obj = new CheckBox("CheckBox00","1011","400","50","24",null,null,null,null,null,null,this);
            obj.set_taborder("40");
            obj.set_text("확인");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit03","498","431","80","24",null,null,null,null,null,null,this);
            obj.set_taborder("41");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit04","583","431","80","24",null,null,null,null,null,null,this);
            obj.set_taborder("42");
            this.addChild(obj.name, obj);

            obj = new Button("Button01","663","431","24","24",null,null,null,null,null,null,this);
            obj.set_taborder("43");
            obj.set_cssclass("btn_WF_search02");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit05","704","431","303","24",null,null,null,null,null,null,this);
            obj.set_taborder("44");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit06","119","462","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("45");
            this.addChild(obj.name, obj);

            obj = new Button("Button02","264","462","70","24",null,null,null,null,null,null,this);
            obj.set_taborder("46");
            obj.set_text("공통확인");
            obj.set_cssclass("btn_cm_basic01");
            this.addChild(obj.name, obj);

            obj = new Radio("Radio00","119","493","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("47");
            obj.set_innerdataset("Dataset01");
            obj.set_codecolumn("Column0");
            obj.set_datacolumn("Column0");
            obj.set_direction("vertical");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit07","119","524","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("48");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00","498","462","200","24",null,null,null,null,null,null,this);
            obj.set_taborder("49");
            obj.set_text("Combo00");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo01","498","493","100","24",null,null,null,null,null,null,this);
            obj.set_taborder("50");
            obj.set_text("Combo00");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit08","603","493","180","24",null,null,null,null,null,null,this);
            obj.set_taborder("51");
            this.addChild(obj.name, obj);

            obj = new Radio("Radio01","498","524","200","24",null,null,null,null,null,null,this);
            obj.set_taborder("52");
            obj.set_innerdataset("Dataset01");
            obj.set_codecolumn("Column1");
            obj.set_datacolumn("Column1");
            obj.set_direction("vertical");
            this.addChild(obj.name, obj);

            obj = new CheckBox("CheckBox01","907","462","100","24",null,null,null,null,null,null,this);
            obj.set_taborder("53");
            obj.set_text("CheckBox01");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit09","907","493","100","24",null,null,null,null,null,null,this);
            obj.set_taborder("54");
            obj.set_readonly("true");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit00","907","524","100","24",null,null,null,null,null,null,this);
            obj.set_taborder("55");
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

        
        // Regist UI Components Event
        this.on_initEvent = function()
        {

        };

        this.loadIncludeScript("work02.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
