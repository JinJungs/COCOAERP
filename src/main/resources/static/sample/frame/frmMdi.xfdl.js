(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("fm_mdi");
            this.set_titletext("New Form");
            this.set_scrollbartype("none");
            this.set_scrolltype("none");
            if (Form == this.constructor)
            {
                this._setFormPosition(1070,30);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize

            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"30","0",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_cssclass("sta_mdi_bg01");
            this.addChild(obj.name, obj);

            obj = new Tab("tabMdi","30","0",null,"100","100",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_tabindex("0");
            obj.set_cssclass("tab_mdi_menu");
            obj.set_showextrabutton("true");
            this.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage2",this.tabMdi);
            obj.set_text("Tabpage2");
            this.tabMdi.addChild(obj.name, obj);

            obj = new Button("btn_MdiPrev",null,"-1","30","31","58",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_cssclass("btn_mdi_prev");
            this.addChild(obj.name, obj);

            obj = new Button("btn_MdiNext",null,"-1","30","31","29",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_cssclass("btn_mdi_next");
            this.addChild(obj.name, obj);

            obj = new Button("btnCloseAll",null,"-1","30","31","0",null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_cssclass("btn_mdi_close");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","0","0","30","30",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_cssclass("sta_mdi_home");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1070,30,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("frmMdi.xfdl", function() {
        this.application = null;

        this.fm_mdi_onload = function(obj,e)
        {
        	this.application = nexacro.getApplication();
        	this.tabMdi.removeTabpage(0);
        };

        this.tabMdi_onchanged = function(obj,e)
        {
        	var sWinId = obj.tabpages[e.postindex].name;

        	this.application.WorkFrame[sWinId].form.setFocus();
        };

        this.tabMdi_onextrabuttonclick = function(obj,e)
        {
        	var sWinId = obj.tabpages[e.index].name;
        	obj.removeTabpage(e.index);

        	this.application.WorkFrame[sWinId].form.close();

        	this.application.LeftFrame.form.fn_DelOpenMenu(sWinId);
        };

        // 탭 추가
        this.fn_AddTabPage = function(pvWinId, pvMenuNm)
        {
        	this.tabMdi.insertTabpage(pvWinId, -1, "", pvMenuNm);
        }

        this.fn_DeleteTabpage = function(pvWinId)
        {
        	var nCnt = this.tabMdi.getTabpageCount();
        	for(var i=0; i<nCnt; i++)
        	{
        		if(this.tabMdi.tabpages[i].name == pvWinId)
        		{
        			this.tabMdi.removeTabpage(i);
        			this.application.LeftFrame.form.fn_DelOpenMenu(pvWinId);
        			return;
        		}
        	}
        }

        this.fn_ActiveTabPage = function(pvWinId)
        {
        	var nCnt = this.tabMdi.getTabpageCount();
        	for(var i=0; i<nCnt; i++)
        	{
        		if(this.tabMdi.tabpages[i].name == pvWinId)
        		{
        			this.tabMdi.set_tabindex(i);
        			return;
        		}
        	}
        }

        this.btnCloseAll_onclick = function(obj,e)
        {
        	var WorkFrame = this.application.WorkFrame.all;
        	for(var i=WorkFrame.length-1; i>=0; i--)
        	{
        		WorkFrame[i].form.close();
        		this.tabMdi.removeTabpage(i);
        	}
        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.fm_mdi_onload,this);
            this.tabMdi.addEventHandler("onchanged",this.tabMdi_onchanged,this);
            this.tabMdi.addEventHandler("onextrabuttonclick",this.tabMdi_onextrabuttonclick,this);
            this.btnCloseAll.addEventHandler("onclick",this.btnCloseAll_onclick,this);
        };

        this.loadIncludeScript("frmMdi.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
