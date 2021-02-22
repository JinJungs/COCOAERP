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
            obj = new Button("btn_save",null,"55","64","35","174",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_save01");
            this.addChild(obj.name, obj);

            obj = new Button("btn_reset",null,"55","64","35","100",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("리셋");
            obj.set_cssclass("btn_WF_reset01");
            this.addChild(obj.name, obj);

            obj = new Static("sta_title","20","10",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("사용자 관리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Static("sta_posName","696","109","149","43",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("직급명");
            this.addChild(obj.name, obj);

            obj = new Edit("edit_posName",null,"109","165","43","102",null,null,null,null,null,this);
            obj.set_taborder("4");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","20","92",null,"337","506",null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_binddataset("ds_position");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"56\"/><Column size=\"95\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"코드\"/><Cell col=\"1\" text=\"직급\"/></Band><Band id=\"body\"><Cell text=\"bind:code\"/><Cell col=\"1\" text=\"bind:name\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item0","edit_posName","value","ds_position","name");
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
            this.btn_reset.addEventHandler("onclick",this.btn_reset_onclick,this);
        };

        this.loadIncludeScript("M13_position.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
