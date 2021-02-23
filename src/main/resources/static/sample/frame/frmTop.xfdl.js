(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("fm_top");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1260,65);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_Popup", this);
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/><Column id=\"Column1\" type=\"STRING\" size=\"256\"/><Column id=\"Column2\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">하위메뉴_1</Col><Col id=\"Column1\">0</Col></Row><Row><Col id=\"Column0\">하위메뉴_2</Col><Col id=\"Column1\">0</Col></Row><Row><Col id=\"Column0\">하위메뉴_2_1</Col><Col id=\"Column1\">1</Col></Row><Row><Col id=\"Column0\">하위메뉴_2_2</Col><Col id=\"Column1\">1</Col></Row><Row><Col id=\"Column0\">하위메뉴_2_3</Col><Col id=\"Column1\">1</Col></Row><Row><Col id=\"Column0\">하위메뉴_3</Col><Col id=\"Column1\">0</Col></Row><Row><Col id=\"Column0\">하위메뉴_4</Col><Col id=\"Column1\">0</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"24","0",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_top_bg01");
            obj.set_background("linear-gradient(to right,cornflowerblue 12%,#684bb9 49%)");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","0","24",null,"41","0",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_cssclass("sta_top_bg02");
            this.addChild(obj.name, obj);

            obj = new Static("Static03","10","0","210","24",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("Hello! Hong Gil Dong");
            obj.set_cssclass("sta_top_textWht");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","0","24","164","41",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("COCOAERP");
            obj.set_padding("5px");
            obj.set_font("bold 24px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            obj.set_color("black");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1260,65,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("frmTop.xfdl", function() {

        this.Button00_onclick = function(obj,e)
        {
        	this.PopupMenu00.trackPopupByComponent(this.Button00,0,41);
        };

        this.fm_top_onload = function(obj,e)
        {

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.fm_top_onload,this);
        };

        this.loadIncludeScript("frmTop.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
