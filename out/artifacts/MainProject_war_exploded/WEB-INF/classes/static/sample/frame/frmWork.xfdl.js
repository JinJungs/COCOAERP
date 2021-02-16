(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("frmWork");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1280,720);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Div("divWork","10","0",null,null,"0","0",null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1280,720,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("frmWork.xfdl", function() {
        this.application = null;
        this.fvWinId = null;
        this.fvMenuNM = null;
        this.fvFormURL = null;

        this.frmWork_onload = function(obj,e)
        {
        	this.application = nexacro.getApplication();

        	var objOwnerFrame = this.getOwnerFrame();

        	this.fvWinId   = objOwnerFrame.param.FORM_ID;
        	this.fvMenuNM = objOwnerFrame.param.MENU_NM;
        	this.fvFormURL = objOwnerFrame.param.FORM_URL;

        	this.divWork.set_url(this.fvFormURL);
        	this.divWork.form.resetScroll();
        };

        this.frmWork_onactivate = function(obj,e)
        {
        	this.application.MdiFrame.form.fn_ActiveTabPage(this.fvWinId);
            this.divWork.form.resetScroll();
        	return;
        };

        this.frmWork_onclose = function(obj,e)
        {
        	this.application.MdiFrame.form.fn_DeleteTabpage(this.fvWinId);
        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.frmWork_onload,this);
            this.addEventHandler("onactivate",this.frmWork_onactivate,this);
            this.addEventHandler("onclose",this.frmWork_onclose,this);
        };

        this.loadIncludeScript("frmWork.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
