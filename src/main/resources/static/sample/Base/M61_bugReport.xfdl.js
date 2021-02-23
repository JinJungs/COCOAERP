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
            obj = new Dataset("Dataset00", this);
            obj._setContents("");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","20","10",null,"34","630",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("버그리포트 ");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Div("bugReport_div","240","100","750",null,null,"50",null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7");
            this.addChild(obj.name, obj);

            obj = new Static("contents_edt_box","13","104",null,"375","5",null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("0");
            obj.set_cssclass("sta_cm_box02L");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("receiver_edt_box00","124","56",null,"48","5",null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("1");
            obj.set_cssclass("sta_cm_box02L");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("title_edt_box00","124","9",null,"48","5",null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("2");
            obj.set_cssclass("sta_cm_box02L");
            obj.set_text("");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("title_nm_box00","13","9","112","48",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("3");
            obj.set_text("제목");
            obj.set_cssclass("sta_cm_box01R");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("receiver_nm_box00","13","56","113","48",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("4");
            obj.set_text("받는 사람");
            obj.set_cssclass("sta_cm_box01R");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Edit("title_edt00","141","19",null,"30","10",null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("5");
            obj.set_displaynulltext("제목을 입력하세요.");
            obj.set_border("0px none");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new TextArea("contents_textarea","30","115",null,"345","15",null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("6");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("receiver_static","146","67","169","27",null,null,null,null,null,null,this.bugReport_div.form);
            obj.set_taborder("7");
            obj.set_text("cocoasemiproject@gmail.com");
            this.bugReport_div.addChild(obj.name, obj);

            obj = new Static("Infor_title_static","45","100","140","24",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("버그리포트 전송 안내");
            obj.set_textAlign("center");
            obj.set_font("bold 13px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Static("infor_static","20","140","200",null,null,"50",null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text(" (1) 필수 첨부 내용\r\n\r\n  - 보내는 사람 소속 \r\n    ex) 회사명, 부서명, 이름\r\n  - 문제점\r\n    ex) 어떤 경우에 생기는 문제\r\n      인지 상세하게 기입하세요\r\n \r\n\r\n\r\n (2) 회신및 문제 해결 기간\r\n\r\n  - 회신 : 최대 3-4일 \r\n  - 문제 해결 기간은 회신 이메\r\n    일에 자세히 안내 될 예정\r\n\r\n\r\n\r\n (3) Contact Detail\r\n\r\n - 회사명 : 올바른데이터\r\n  - 회사 번호 : (02)1231-1231\r\n ");
            obj.set_border("1px solid #c7c7c7");
            obj.set_padding("0px");
            this.addChild(obj.name, obj);

            obj = new Button("btn_send","935","55","55","35",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("전송");
            obj.set_font("normal 15px/normal \"Arial\"");
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
        this.registerScript("M61_bugReport.xfdl", function() {

        //전송
        this.btn_send_onclick = function(obj,e)
        {
        	var title = this.bugReport_div.form.title_edt00.value;
        	var receiver_email = "cocoasemiproject@gmail.com";
        	var contents =  this.bugReport_div.form.contents_textarea.value;
        	if(title == null ){
        		title ="(제목없음)";
        	}
        	if(contents == null){
        		trace("이건 왜 ..?");
        		contents ="(내용없음)";
        	}
        	this.transaction(
        			"bug" //1.strSvcID (Transaction을 구분하기 위한  ID : Callback때 넣어주는 id)
        			,"/email/nexacroEmailSend.email"//2.strURL
        			,""//3.strInDatasets - I,U,D Sds=Fds:U, :A, :N
        			,""//4.strOutDatasets - select Fds=Sds
        			,"title=" + title + " receiver_email=" + receiver_email + " contents="+ contents//5.strArgument
        													//id앞에 항상 띄어쓰기 넣어야함
        			,"fn_callback"//6.strCallbackFunc
        		);

        };
        this.fn_callback = function(id, ErrCode, ErrMsg){
        	trace(result);
        	this.alert("버그리포트 전송 완료!");
        };
        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.bugReport_div.form.title_nm_box00.addEventHandler("onclick",this.Static01_onclick,this);
            this.bugReport_div.form.receiver_nm_box00.addEventHandler("onclick",this.Static01_onclick,this);
            this.infor_static.addEventHandler("onclick",this.infor_static_onclick,this);
            this.btn_send.addEventHandler("onclick",this.btn_send_onclick,this);
        };

        this.loadIncludeScript("M61_bugReport.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
