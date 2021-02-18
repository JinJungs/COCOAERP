(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M41_fileForm");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
<<<<<<< HEAD
=======
            obj = new Dataset("tp_title", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"made_date\" type=\"STRING\" size=\"256\"/><Column id=\"mod_date\" type=\"STRING\" size=\"256\"/><Column id=\"emp_code\" type=\"INT\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            obj = new Dataset("tp_list", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/><Column id=\"explain\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"temp_code\" type=\"INT\" size=\"256\"/><Column id=\"form_code\" type=\"INT\" size=\"256\"/><Column id=\"writer_code\" type=\"INT\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            obj = new Dataset("tp_origin", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
>>>>>>> f3034fce3f0e496ed0318f1bf6ee2eca29ae609e

            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("파일 양식 관리");
            obj.set_cssclass("sta_WF_title01");
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
        this.registerScript("M41_fileForm.xfdl", function() {

        this.Static00_onclick = function(obj,e)
        {
<<<<<<< HEAD

        };

=======
        	var curRow = this.grid_form.currentrow;
        	this.tp_title.deleteRow(curRow);

        	this.fn_update_tpTitle("tp_titleRm","/nexTemp/tp_titleRm.nex");
        };

        this.M41_fileForm_onload = function(obj,e)
        {

        	this.transaction(
        		"ds_getUser" //1. strsvcid
        		,"/nexTemp/ds_user.nex" //2.strurl
        		,"" //3.strInDatasets Sds=Fds:U :A :
        		,"ds_user=out_ds" //4.strOutDatasets
        		,"" //5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        	);


        	this.transaction(
        		"tp_list" //1. strsvcid
        		,"/nexTemp/tp_origin.nex" //2.strurl
        		,"" //3.strInDatasets Sds=Fds:U :A :
        		,"tp_origin=out_ds" //4.strOutDatasets
        		,"" //5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        	);


        	this.transaction(
        		"tp_title" //1. strsvcid
        		,"/nexTemp/tp_title.nex" //2.strurl
        		,"" //3.strInDatasets Sds=Fds:U :A :
        		,"tp_title=out_ds" //4.strOutDatasets
        		,"" //5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        		);

        };

        this.fn_update_tpTitle=function(id,url){
        		this.transaction(
        		id //1. strsvcid
        		,url //2.strurl
        		,"in_ds=tp_title:U" //3.strInDatasets Sds=Fds:U :A :
        		,"" //4.strOutDatasets
        		,"" //5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        		);
        }


        this.fn_cbAddTitle=function(id,args){
        if(args=="cancel"){
        	return;
        }
        	var arr = args.split("|");
        	var arr1 = arr[0];
        	var arr2 = arr[1];
        	this.transaction(
        		"tp_titleAdd" //1. strsvcid
        		,"/nexTemp/tp_titleAdd.nex" //2.strurl
        		,"in_ds=tp_title:U" //3.strInDatasets Sds=Fds:U :A :
        		,"" //4.strOutDatasets
        		,"title='"+arr1+"' contents='"+arr2+"'"//5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        		);
        	this.setTimer("timer",200)
        	this.M41_fileForm_onload();

        }
        this.fn_cbModTitle=function(id,args){
        if(args=="cancel"){
        	return;
        }
        	var arr = args.split("|");
        	var getCurRowNum = this.grid_form.currentrow;
        	var arr1 = arr[0];
        	var arr2 = arr[1];
        	this.tp_title.setColumn(getCurRowNum,"title",arr1);
        	this.tp_title.setColumn(getCurRowNum,"contents",arr2);
        	this.fn_update_tpTitle("tp_titleAdd","/nexTemp/tp_titleMod");

        	this.setTimer("timer",200)
        	this.M41_fileForm_onload();

        }


        this.fn_callback=function(id,errmsg,etc){
        trace(id);
        trace(errmsg);
        }


        this.grid_form_oncellclick = function(obj,e)
        {
        	this.div_addListForm.set_visible(false);
        	var getCol = this.tp_title.getColumn(this.tp_title.rowposition,"code");
        		this.transaction(
        		"onclick_tp_title" //1. strsvcid
        		,"/nexTemp/onclick_tp_title.nex" //2.strurl
        		,"" //3.strInDatasets Sds=Fds:U :A :
        		,"tp_list=out_ds" //4.strOutDatasets
        		,"code="+getCol //5.strArgument
        		,"fn_callback" //6.strCallbackFunc
        		);
        };

        this.btn_listAdd_onclick = function(obj,e)
        {

        	this.div_addListForm.set_visible(true);
        	var form = this.tp_title.getColumn(this.tp_title.rowposition,"title");
        	this.div_addListForm.form.sta_form.set_text(form);
        	var user_name = this.ds_user.getColumn(0,"name");
        	var user_dept = this.ds_user.getColumn(0,"dept_name");
        	this.div_addListForm.form.sta_writer_code.set_text(user_name+" | "+user_dept);

        	this.div_addListForm.form.tp_listName.set_value("");
        	this.div_addListForm.form.tp_listExplain.set_value("");
        	this.div_addListForm.form.tp_listExplain.set_value("");
        	this.div_addListForm.form.tp_listContents.set_value("");
        	this.div_addListForm.form.tp_listTemp.set_index();

        };

        this.btn_addList_onclick = function(obj,e)
        {

        	var form_code = this.tp_title.getColumn(this.tp_title.rowposition,"code");
        	var name = this.div_addListForm.form.tp_listName.value;
        	var explain = this.div_addListForm.form.tp_listExplain.value;
        	var contents = this.div_addListForm.form.tp_listContents.value;
        	var status = this.div_addListForm.form.radio_status.value;
        	var temp_code = this.div_addListForm.form.tp_listTemp.value;
        	var writer_code=this.ds_user.getColumn(0,"code");
        	if(name==""){
        		this.div_addListForm.form.sta_nameErrMsg.set_text("양식명을 입력해주세요.");
        		this.div_addListForm.form.tp_listName.setFocus(true);
        		return;
        	}else{
        		this.div_addListForm.form.sta_nameErrMsg.set_text("");
        	}
        	if(explain==""){
        		this.div_addListForm.form.sta_explainErrMsg.set_text("설명을 입력해주세요.");
        		this.div_addListForm.form.tp_listExplain.setFocus(true);
        		return;
        	}else{
        		this.div_addListForm.form.sta_explainErrMsg.set_text("");
        	}

        	this.transaction(
        		"addList_onclick" //1. strsvcid
        		,"/nexTemp/addList_onclick.nex" //2.strurl
        		,"" //3.strInDatasets Sds=Fds:U :A :
        		,"tp_list=out_ds" //4.strOutDatasets
        		,"form_code="+form_code +" name='"+name+"' explain='"+contents+"' contents='"+contents
        		+"' status="+status+" temp_code="+temp_code+" writer_code="+writer_code
        		,"fn_callback" //6.strCallbackFunc
        		);

        	this.div_addListForm.form.tp_listName.set_value("");
        	this.div_addListForm.form.tp_listExplain.set_value("");
        	this.div_addListForm.form.tp_listExplain.set_value("");
        	this.div_addListForm.form.tp_listContents.set_value("");
        	this.div_addListForm.form.tp_listTemp.set_index();
        };

        this.div_addListForm_btn_reset_onclick = function(obj,e)
        {
        	this.div_addListForm.set_visible(false);
        	this.div_addListForm.form.tp_listName.set_value("");
        	this.div_addListForm.form.tp_listExplain.set_value("");
        	this.div_addListForm.form.tp_listExplain.set_value("");
        	this.div_addListForm.form.tp_listContents.set_value("");
        	this.div_addListForm.form.tp_listTemp.set_index();
        };

>>>>>>> f3034fce3f0e496ed0318f1bf6ee2eca29ae609e
        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
<<<<<<< HEAD

=======
            this.addEventHandler("onload",this.M41_fileForm_onload,this);
            this.grid_form.addEventHandler("oncellclick",this.grid_form_oncellclick,this);
            this.btn_titleAdd.addEventHandler("onclick",this.btn_titleAdd_onclick,this);
            this.btn_titleMod.addEventHandler("onclick",this.btn_titleMod_onclick,this);
            this.btn_titleRm.addEventHandler("onclick",this.btn_titleRm_onclick,this);
            this.btn_listAdd.addEventHandler("onclick",this.btn_listAdd_onclick,this);
            this.div_addListForm.form.Static01_01.addEventHandler("onclick",this.Static01_01_onclick,this);
            this.div_addListForm.form.tp_listTemp.addEventHandler("onitemchanged",this.Combo00_onitemchanged,this);
            this.div_addListForm.form.btn_addList.addEventHandler("onclick",this.btn_addList_onclick,this);
            this.div_addListForm.form.btn_reset.addEventHandler("onclick",this.div_addListForm_btn_reset_onclick,this);
            this.div_addListForm.form.radio_status.addEventHandler("onitemchanged",this.radio_addList_onitemchanged,this);
>>>>>>> f3034fce3f0e496ed0318f1bf6ee2eca29ae609e
        };

        this.loadIncludeScript("M41_fileForm.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
