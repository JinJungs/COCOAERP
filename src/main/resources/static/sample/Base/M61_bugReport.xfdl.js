(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M61_bugReport");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("버그리포트 전송");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Static("infor_static","11.93%","29.85%","14.95%","44.92%",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text(" (1) 필수 첨부 내용\r\n\r\n  - 보내는 사람 소속 \r\n    ex) 회사명, 부서명, 이름\r\n  - 문제점\r\n    ex) 어떤 경우에 생기는 문제\r\n      인지 상세하게 기입하세요\r\n \r\n (2) 회신및 문제 해결 기간\r\n\r\n  - 회신 : 최대 3-4일 \r\n  - 문제 해결 기간은 회신 이메\r\n    일에 자세히 안내 될 예정\r\n\r\n (3) Contact Detail\r\n\r\n - 회사명 : 올바른데이터\r\n  - 회사 번호 : (02)1231-1231\r\n ");
            obj.set_border("1px double #0052a6");
            obj.set_padding("0px");
            this.addChild(obj.name, obj);

            obj = new Static("Infor_title_static","12.94%","23.85%","12.94%","4.00%",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("버그리포트 전송 안내");
            obj.set_textAlign("center");
            obj.set_font("bold italic 13px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            obj.set_border("0px none,0px none,1px solid #0052a6");
            this.addChild(obj.name, obj);

            obj = new Div("bugReport_div","24.50%","17.08%","52.57%","70.00%",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("");
            this.addChild(obj.name, obj);

            obj = new Static("contents_edt_box","11.17%","27.69%","73.8%","55%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("0");
            obj.set_cssclass("sta_cm_box02L");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("receiver_edt_box00","25%","18%","60%","10%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("1");
            obj.set_cssclass("sta_cm_box02L");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("title_edt_box00","25%","8%","60%","10%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("2");
            obj.set_cssclass("sta_cm_box02L");
            obj.set_text("");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("title_nm_box00","11%","8%","15%","10%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("3");
            obj.set_text("제목");
            obj.set_cssclass("sta_cm_box01R");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("receiver_nm_box00","11%","18%","15%","10%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("4");
            obj.set_text("받는 사람");
            obj.set_cssclass("sta_cm_box01R");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Edit("title_edt00","26.70%","10.11%","55.85%","5.49%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("5");
            obj.set_displaynulltext("제목을 입력하세요.");
            obj.set_border("0px none");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new TextArea("contents_textarea","12.91%","29.45%","69.98%","50%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("6");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Button("btn_send","63.70%","85%","20.77%","8.13%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("7");
            obj.set_text("전송");
            obj.set_font("normal 15px/normal \"Arial\"");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("receiver_static","27.4%","19.56%","30.54%","5.93%",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("8");
            obj.set_text("cocoasemiproject@gmail.com");
            this.bugReport_div.addChild(obj.name, obj);

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

        
        // Regist UI Components Event
        this.on_initEvent = function()
        {

        };

        this.loadIncludeScript("M61_bugReport.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
