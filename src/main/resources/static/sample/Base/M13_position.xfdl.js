(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M13_position");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_position", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">1</Col><Col id=\"name\">임시</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Button("btn_save",null,"55","64","35","100",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_save01");
            this.addChild(obj.name, obj);

            obj = new Static("sta_title","20","10",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("직급 관리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_position","20","100",null,null,"560","50","300",null,null,null,this);
            obj.set_taborder("2");
            obj.set_binddataset("ds_position");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"60\"/><Column size=\"450\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"코드\"/><Cell col=\"1\" text=\"직급\"/></Band><Band id=\"body\"><Cell text=\"bind:code\" textAlign=\"left\"/><Cell col=\"1\" text=\"bind:name\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Div("Div00","grd_position:10","100","450",null,null,"50",null,null,null,null,this);
            obj.set_taborder("3");
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
            obj.set_text("직급명");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("Static01","20","77","120","46",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("3");
            obj.set_text("코드");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.Div00.addChild(obj.name, obj);

            obj = new Static("sta_form","122","77",null,"46","20",null,null,null,null,null,this.Div00.form);
            obj.set_taborder("4");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_border("1px solid #c9c9c9,0px none");
            obj.set_text("");
            this.Div00.addChild(obj.name, obj);

            obj = new Edit("edt_code","150","84","131","32",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("5");
            obj.set_readonly("true");
            this.Div00.addChild(obj.name, obj);

            obj = new Edit("edt_name","150","130","131","32",null,null,null,null,null,null,this.Div00.form);
            obj.set_taborder("6");
            this.Div00.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item1","Div00.form.sta_form","text","tp_title","title");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item4","Div00.form.edt_code","value","ds_position","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item5","Div00.form.edt_name","value","ds_position","name");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M13_position.xfdl", function() {

        this.M13_position_onload = function(obj,e)
        {
        		trace("포스 도착==============--================");
        		this.transaction(
        			"loadPosList" //strSvcID
        			, "/nexPos/loadPosList.nex" //strURL
        			, "" //strInDatasets Sds=Fds:U, A, N
        			, "ds_position=out_pos_list" //strOutDatasets - select Fds = Sds
        			, "" //strArgument
        			,  "fn_callback" //strCallbackFunc
        		);
        };

        this.btn_save_onclick = function(obj,e)
        {
        	this.transaction(
        			"updatePosList" // 1. strSvcID
        			,"/nexPos/updatePosList.nex" // 2. strURL
        			,"in_ds=ds_position:U" // 3. strInDatasets Sds=Fds:U,:A,:N
        			,"" // 4. strOutDatasets - select Fds=Sds
        			,"" // 5. strArgument
        			,"fn_callback" // 6. strCallbackFunc
        		);
        };

        this.fn_callback = function(id, ErrCode, ErrMsg)
        {
        	trace(ErrMsg);
        }



        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M13_position_onload,this);
            this.btn_save.addEventHandler("onclick",this.btn_save_onclick,this);
        };

        this.loadIncludeScript("M13_position.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
