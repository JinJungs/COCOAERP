(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("Form_Work");
            this.set_titletext("Form_Work");
            if (Form == this.constructor)
            {
                this._setFormPosition(500,500);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("person_ds", this);
            obj._setContents("<ColumnInfo><Column id=\"chk\" type=\"STRING\" size=\"256\"/><Column id=\"id\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"contact\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Grid("Grid00","21","16","457","294",null,null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_binddataset("person_ds");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"bind:chk\" displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"id\"/><Cell col=\"2\" text=\"name\"/><Cell col=\"3\" text=\"contact\"/></Band><Band id=\"body\"><Cell text=\"bind:chk\" displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"bind:id\"/><Cell col=\"2\" text=\"bind:name\" edittype=\"text\"/><Cell col=\"3\" text=\"bind:contact\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btnAdd","21","335","120","50",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("ADD");
            this.addChild(obj.name, obj);

            obj = new Button("btnDel","151","335","120","50",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("DEL");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","Desktop_screen",500,500,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("Form_Work.xfdl", function() {

        this.Form_Work_onload = function(obj,e)
        {
        		this.transaction(
        		"get_person" //1. strsvcid
        		,"/get_person.nex" //2.strurl
        		,"" //3.strInDatasets Sds=Fds:U :A :
        		,"person_ds=out_Ds" //4.strOutDatasets
        		,"" //5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        		);
        };

        this.fn_callback= function (error,errormsg,etc)
        {
        	trace(error)
        	trace(errormsg);
        	trace(etc);
        };

        this.btnAdd_onclick = function(obj,e)
        {
        	let x = this.width/2 - 150;
        	let y = this.height/2 - 150;
        	let objCF = new ChildFrame();
        	objCF.init("popAdd",x,y,300,300,0,0,"FrameBase::Form_Add_Pop.xfdl");
        	objCF.showModal(this.getOwnerFrame(),{},this,"fn_pop_callback");
        };

        this.fn_pop_callback=function(strid,rtnVal){
        	if(rtnVal==null){
        		return;
        	}
        	let rtnArr = rtnVal.split("|");
        	let id = rtnArr[0];
        	let name = rtnArr[1];
        	let contact =rtnArr[2];
        	let row = this.person_ds.addRow();
        	trace(id+":"+name+":"+contact);
        	this.person_ds.setColumn(row,"id",id);
        	this.person_ds.setColumn(row,"name",name);
        	this.person_ds.setColumn(row,"contact",contact);
        	this.fn_update_person("dsAdd","/dsAdd.nex");
        }

        this.btnDel_onclick = function(obj,e)
        {
        // 	this.person_ds.deleteRow(this.person_ds.rowposition);
        // 	this.fn_update_person("dsDel","/dsDel.nex");
        	let arr = this.person_ds.extractRows("chk==1");
        	if(arr.length==0|| arr==-1){this.alert("선택된 항목이 없습니다."); return;}
        	this.person_ds.deleteMultiRows(arr);
        	this.fn_update_person("dsDel","/dsDel.nex");
        };


        this.person_ds_oncolumnchanged = function(obj,e)
        {
        	if(e.col!=0){
        	this.fn_update_person("dsUpd","/dsUpd.nex");
        	}
        };


        this.fn_update_person=function(id,url){

        this.transaction(
        		id//1. strsvcid
        		,url //2.strurl
        		,"in_ds=person_ds:U" //3.strInDatasets Sds=Fds:U :A :
        		,"" //4.strOutDatasets
        		,"" //5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        		);
        }


        this.Grid00_onheadclick = function(obj,e)
        {
        	if(e.cell == 0){
        	let flag = obj.getCellProperty("Head",0,"text");
        	let check = flag==0?1:0;
        	obj.setCellProperty("Head",0,"text",check);
        		for(var i =0;i<this.person_ds.rowcount;i++){
        			this.person_ds.setColumn(i,0,check);
        		}
        	}
        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.Form_Work_onload,this);
            this.Grid00.addEventHandler("onheadclick",this.Grid00_onheadclick,this);
            this.btnAdd.addEventHandler("onclick",this.btnAdd_onclick,this);
            this.btnDel.addEventHandler("onclick",this.btnDel_onclick,this);
            this.person_ds.addEventHandler("oncolumnchanged",this.person_ds_oncolumnchanged,this);
        };

        this.loadIncludeScript("Form_Work.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
