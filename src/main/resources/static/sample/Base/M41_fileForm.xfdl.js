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
                this._setFormPosition(1560,720);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("tp_title", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"made_date\" type=\"STRING\" size=\"256\"/><Column id=\"mod_date\" type=\"STRING\" size=\"256\"/><Column id=\"emp_code\" type=\"INT\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            obj = new Dataset("tp_list", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/><Column id=\"explain\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"temp_code\" type=\"INT\" size=\"256\"/><Column id=\"form_code\" type=\"INT\" size=\"256\"/><Column id=\"writer_code\" type=\"INT\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">0</Col><Col id=\"name\">321</Col><Col id=\"status\">321</Col><Col id=\"explain\">321</Col><Col id=\"temp_code\">321</Col><Col id=\"form_code\">321</Col><Col id=\"writer_code\">321</Col><Col id=\"contents\">321</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("tp_origin", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_user", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"team_name\" type=\"STRING\" size=\"256\"/><Column id=\"dept_name\" type=\"STRING\" size=\"256\"/><Column id=\"pos_name\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("기안 양식 관리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Grid("grid_form","10","90","180","546",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_binddataset("tp_title");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"- 양식함\"/></Band><Band id=\"body\"><Cell text=\"bind:title\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Grid("grid_temp","210","90","592","544",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_binddataset("tp_list");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"양식명\"/></Band><Band id=\"body\"><Cell text=\"bind:name\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("btn_titleAdd","10","54","43","26",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("추가");
            this.addChild(obj.name, obj);

            obj = new Button("btn_titleMod","60","54","43","26",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("수정");
            this.addChild(obj.name, obj);

            obj = new Button("btn_titleRm","110","54","43","26",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("삭제");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00","420","57","129","26",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            var Combo00_innerdataset = new nexacro.NormalDataset("Combo00_innerdataset", obj);
            Combo00_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">name</Col><Col id=\"datacolumn\">기안제목</Col></Row></Rows>");
            obj.set_innerdataset(Combo00_innerdataset);
            obj.set_text("");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00","556","57","196","26",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            this.addChild(obj.name, obj);

            obj = new Button("btn_listSearch","759","57","43","26",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_text("검색");
            this.addChild(obj.name, obj);

            obj = new Button("btn_listAdd","716","18","87","32",null,null,null,null,null,null,this);
            obj.set_taborder("9");
            obj.set_text("양식 추가");
            this.addChild(obj.name, obj);

            obj = new Div("div_addListForm","810","16","700","620",null,null,null,null,null,null,this);
            obj.set_taborder("10");
            obj.set_text("Div00");
            obj.set_formscrollbartype("none");
            obj.set_visible("false");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","0","0",null,"34","-502",null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("0");
            obj.set_text("양식 추가");
            obj.set_cssclass("sta_WF_title01");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01","53","77","120","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("1");
            obj.set_text("양식 분류");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_00","53","124","120","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("2");
            obj.set_text("기안 양식 명 *");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_01","53","171","120","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("3");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_text("양식 담당자");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_02","53","218","120","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("4");
            obj.set_text("설명 *");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_03","53","265","120","116",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("5");
            obj.set_text("내용");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_04","53","382","120","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("6");
            obj.set_text("공개여부");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_05","53","429","120","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("7");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_text("템플릿 설정");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("sta_form","173","77","498","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("8");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_border("1px solid #c9c9c9,0px none");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_06_00","173","124","498","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("9");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("sta_writer_code","173","171","498","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("10");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_text("");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_06_00_01","173","218","498","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("11");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_text("");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_06_00_02","173","265","498","116",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("12");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_06_00_03","173","382","498","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("13");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("Static01_06_00_04","173","429","498","46",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("14");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_text("");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Combo("tp_listTemp","181","435","193","35",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_innerdataset("tp_origin");
            obj.set_codecolumn("code");
            obj.set_datacolumn("name");
            obj.set_taborder("15");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Edit("tp_listName","181","131","193","32",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("16");
            obj.set_maxlength("10");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Edit("tp_listExplain","181","225","259","32",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("17");
            obj.set_maxlength("15");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new TextArea("tp_listContents","181","272","370","100",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("18");
            obj.set_maxlength("100");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Button("btn_addList","585","489","86","33",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("19");
            obj.set_text("추가");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Button("btn_reset","485","489","86","33",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("20");
            obj.set_text("취소");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Radio("radio_status","183","380","137","50",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("21");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_direction("vertical");
            var div_addListForm_form_radio_status_innerdataset = new nexacro.NormalDataset("div_addListForm_form_radio_status_innerdataset", obj);
            div_addListForm_form_radio_status_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">Y</Col><Col id=\"datacolumn\">공개</Col></Row><Row><Col id=\"codecolumn\">N</Col><Col id=\"datacolumn\">비공개</Col></Row></Rows>");
            obj.set_innerdataset(div_addListForm_form_radio_status_innerdataset);
            obj.set_text("공개");
            obj.set_value("Y");
            obj.set_index("0");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("sta_nameErrMsg","384","132","292","30",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("22");
            this.div_addListForm.addChild(obj.name, obj);

            obj = new Static("sta_explainErrMsg","453","227","234","30",null,null,null,null,null,null,this.div_addListForm.form);
            obj.set_taborder("23");
            this.div_addListForm.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1560,720,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item1","div_addListForm.form.radio_status","value","Dataset00","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item0","div_addListForm.form.tp_listTemp","value","tp_origin","code");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M41_fileForm.xfdl", function() {


        this.btn_titleAdd_onclick = function(obj,e)
        {
        	var cf = new ChildFrame();
        	cf.init("cf_addTtitle",0,0,310,400)

        	cf.set_formurl("popup::fileform_addTitle.xfdl");
        	cf.set_openalign("center middle");
        	cf.showModal(
        		this.getOwnerFrame(),
        		{},
        		this,
        		"fn_cbAddTitle"
        	);
        };



        this.btn_titleMod_onclick = function(obj,e)
        {
        	var cf = new ChildFrame();
        	cf.init("cf_modTtitle",0,0,310,400)
        		var curRow = this.grid_form.currentrow;
        	var title = this.tp_title.getColumn(curRow,"title");
        	var contents =this.tp_title.getColumn(curRow,"contents");
        	var made_date= this.tp_title.getColumn(curRow,"made_date");
        	var mod_date = this.tp_title.getColumn(curRow,"mod_date");
        	cf.set_formurl("popup::fileform_modTitle.xfdl");
        	cf.set_openalign("center middle");
        	cf.showModal(
        		this.getOwnerFrame(),{curRow:curRow,title:title,contents:contents,made_date:made_date,mod_date:mod_date},this,"fn_cbModTitle"
        	);
        };

        this.btn_titleRm_onclick = function(obj,e)
        {
        	var curRow = this.grid_form.currentrow;
        	trace(curRow)
        	if(curRow==0){
        		this.alert("삭제 불가능한 양식입니다.");
        		return;
        	}else{
        		this.tp_title.deleteRow(curRow);
        	}
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

        		user_name = this.ds_user.getColumn(0,"name");
        		user_dept = this.ds_user.getColumn(0,"dept_name");
        		user_team = this.ds_user.getColumn(0,"team_name");
        		user_pos = this.ds_user.getColumn(0,"pos_name");

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
        	var getAddRowNum = this.tp_title.addRow();
        	var arr1 = arr[0];
        	var arr2 = arr[1];
        	this.tp_title.setColumn(getAddRowNum,"title",arr1);
        	this.tp_title.setColumn(getAddRowNum,"contents",arr2);
        	this.fn_update_tpTitle("tp_titleAdd","/nexTemp/tp_titleAdd");


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

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M41_fileForm_onload,this);
            this.grid_form.addEventHandler("oncellclick",this.grid_form_oncellclick,this);
            this.btn_titleAdd.addEventHandler("onclick",this.btn_titleAdd_onclick,this);
            this.btn_titleMod.addEventHandler("onclick",this.btn_titleMod_onclick,this);
            this.btn_titleRm.addEventHandler("onclick",this.btn_titleRm_onclick,this);
            this.btn_listAdd.addEventHandler("onclick",this.btn_listAdd_onclick,this);
            this.div_addListForm.form.Static01_01.addEventHandler("onclick",this.Static01_01_onclick,this);
            this.div_addListForm.form.tp_listTemp.addEventHandler("onitemchanged",this.Combo00_onitemchanged,this);
            this.div_addListForm.form.btn_addList.addEventHandler("onclick",this.btn_addList_onclick,this);
            this.div_addListForm.form.radio_status.addEventHandler("onitemchanged",this.radio_addList_onitemchanged,this);
        };

        this.loadIncludeScript("M41_fileForm.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
