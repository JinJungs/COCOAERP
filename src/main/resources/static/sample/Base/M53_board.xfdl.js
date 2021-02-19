(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M53_board");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize

            obj = new Dataset("ds_board_menu", this);
            obj._setContents("<ColumnInfo><Column id=\"chk\" type=\"STRING\" size=\"256\"/><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"type\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("게시판 관리");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Grid("Main_Grid","4%","13%","74%","77%",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj._setContents("");
            this.addChild(obj.name, obj);

            obj = new Static("Static00_00","7%","15%","15%","5%",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("새 게시판 생성");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("normal 13px/normal");
            this.addChild(obj.name, obj);

            obj = new Div("board_div","10.09%","20.62%","65.23%","60.31%",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);

            obj = new Grid("board_mn_list_Grd","0.14%","8.93%","49.09%","76.79%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_board_menu");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"50\"/><Column size=\"53\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"0\" displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"게시판 번호\"/><Cell col=\"2\" text=\"게시판 이름\"/><Cell col=\"3\" text=\"게시판 종류\"/></Band><Band id=\"body\"><Cell text=\"bind:chk\" displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"bind:seq\" textAlign=\"center\"/><Cell col=\"2\" text=\"bind:name\"/><Cell col=\"3\" text=\"bind:type\"/></Band></Format></Formats>");
            this.board_div.addChild(obj.name, obj);

            obj = new Button("btn_modify","79.04%","77.55%","7.88%","6.38%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("1");
            obj.set_text("수정");
            this.board_div.addChild(obj.name, obj);

            obj = new Button("btn_add","60.76%","77.55%","7.88%","6.38%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("2");
            obj.set_text("추가");
            this.board_div.addChild(obj.name, obj);

            obj = new Button("btn_del","69.76%","77.55%","7.88%","6.38%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("3");
            obj.set_text("삭제");
            this.board_div.addChild(obj.name, obj);

            obj = new Static("Static01","63.01%","11.48%","21.38%","5.87%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("4");
            obj.set_text("게시판 정보안내 및 수정");
            obj.set_textAlign("center");
            obj.set_font("bold 13px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            this.board_div.addChild(obj.name, obj);

            obj = new Div("Div00","52.04%","21.94%","43.60%","51.02%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("5");
            obj.set_border("1px groove #0052a6");
            this.board_div.addChild(obj.name, obj);

            obj = new Static("stcSeq","28","16.74%","21.36%","18.03%",null,null,null,null,null,null,this.board_div.form.Div00.form);
            obj.set_taborder("0");
            obj.set_text("게시판 번호");
            this.board_div.form.Div00.addChild(obj.name, obj);

            obj = new Static("Static00","8.09%","37.77%","22.01%","18.03%",null,null,null,null,null,null,this.board_div.form.Div00.form);
            obj.set_taborder("1");
            obj.set_text("게시판 이름");
            this.board_div.form.Div00.addChild(obj.name, obj);

            obj = new MaskEdit("mskSeq","35.60%","16.31%","10%","13%",null,null,null,null,null,null,this.board_div.form.Div00.form);
            obj.set_taborder("2");
            obj.set_border("0px none,0px none,1px groove #0052a6");
            obj.set_textAlign("center");
            this.board_div.form.Div00.addChild(obj.name, obj);

            obj = new Radio("rdoType","35.60%","58.37%",null,"18.03%","19",null,null,null,null,null,this.board_div.form.Div00.form);
            obj.set_taborder("3");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("2");
            obj.set_readonly("true");
            obj.set_innerdataset("board_type_radio");
            this.board_div.form.Div00.addChild(obj.name, obj);

            obj = new Static("Static00_00","8.09%","59.23%","22.01%","16.31%",null,null,null,null,null,null,this.board_div.form.Div00.form);
            obj.set_taborder("4");
            obj.set_text("게시판 종류");
            this.board_div.form.Div00.addChild(obj.name, obj);

            obj = new Edit("edtBoardNm","35.60%","37.34%","49.84%","16.31%",null,null,null,null,null,null,this.board_div.form.Div00.form);
            obj.set_taborder("5");
            obj.getSetter("onclick").set("Common_onclick");
            obj.set_border("0px none,0px none,1px groove #0052a6");
            this.board_div.form.Div00.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item2","board_div.form.Div00.form.mskSeq","value","ds_board_menu","seq");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","board_div.form.Div00.form.rdoType","value","ds_board_menu","type");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item0","board_div.form.Div00.form.edtBoardNm","value","ds_board_menu","name");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script

        	var arrRtn = sRtn.split("|");
        	var type = arrRtn[0];
        	var name = arrRtn[1];
        	if (type=="1"){
        		type = "Album";
        	}
        	if (type=="2"){
        		type = "List";
        	}

        	trace("여기"+type);
        	trace("여기"+name);
         	this.transaction(
           		"boardPop" // id
           		, "/NecBoard/addBoard.nc" // url
         		, "" // inData
           		, "" // outData
          		, "type="+type+" name="+name// strArg
           		, "fn_callback" // callback
           	);
        };

        this.fn_callback = function(result)
        {
        	trace("추가 완료!");
        	this.M53_board_onload();
        }

        //수정 버튼
        this.board_div_btn_modify_onclick = function(obj,e)
        {
        	let arr = this.ds_board_menu.extractRows("chk==1");
         	this.ds_board_menu.deleteMultiRows(arr);

        	var seq = this.board_div.form.Div00.form.mskSeq.value;
        	var name = this.board_div.form.Div00.form.edtBoardNm.value;
        	trace("변경할 이름 : "+name);
        	trace("번호 : "+seq);
        	this.transaction(
          		"boardUpdate" // id
          		, "/NecBoard/uptBoard.nc" // url
        		, "ds_uptBoard = ds_board_menu:U" // inData
          		, "" // outData
         		, "name=" + name + " seq=" + seq// strArg
          		, "fn_callback_upt" // callback
          	);
        };
        this.fn_callback_upt = function(result)
        {
        	trace("수정 완료!");
        	this.M53_board_onload();
        }
        //Grid 체크박스

        this.board_div_board_mn_list_Grd_onheadclick = function(obj,e)
        {
        	trace("여기가 어디니..");
        	if(e.cell == 0)
        	{
        		this.gf_setCheckAll(obj, e);
        	}
        };

        this.gf_setCheckAll = function(obj, e)
        {
        	trace("박스가 눌리니..");
        	var strColID = obj.getCellProperty("body", e.cell, "text").replace("bind:", ""); //Cell의 특정 속성 값을 반환하는 메소드입니다.
        	var sheadValue = obj.getCellProperty("head", e.cell, "text"); //head에서 선택한 행의 text 값 가져오기
        	//var objDs = obj.getBindDataset();

        		trace("strColID 값은?"+strColID);
        		trace("sheadValue 값은?"+sheadValue);

        		trace("아닐때");
        		sheadValue = (sheadValue == "0" ? "1" : "0");
        		obj.setCellProperty("head",e.cell,"text",sheadValue);
        		obj.setCellProperty("body",e.cell,"text",sheadValue);
        		trace("sheadValue "+sheadValue);

        		//this.ds_board_menu.set_enableevent(false);
        		for(var i=0; i<this.ds_board_menu.getRowCount(); i++){
        			this.ds_board_menu.setColumn(i, "chk", sheadValue);
        		}
        		//this.ds_board_menu.set_enableevent(true);
        };
        //삭제 버튼
        this.board_div_btn_del_onclick = function(obj,e)
        {
        	let arr = this.ds_board_menu.extractRows("chk==1");
        	var seq = this.board_div.form.Div00.form.mskSeq.value;
        	if(arr.length == 0 || arr == -1) {alert("선택된 항목이 없습니다.");return}
        	trace("arr은?"+arr);

         	this.ds_board_menu.deleteMultiRows(arr);

        	this.transaction(
          		"boardDelete" // id
          		, "/NecBoard/delBoard.nc" // url
        		, "ds_delBoard = ds_board_menu:D" // inData
          		, "" // outData
         		, "seq="+seq// strArg
          		, "fn_callback_del" // callback
          	);
        };
        this.fn_callback_del = function(result)
        {
        	trace("삭제 완료!");
        	this.alert("삭제 되었습니다.");
        }
        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M53_board_onload,this);
            this.board_div.form.board_mn_list_Grd.addEventHandler("onheadclick",this.board_div_board_mn_list_Grd_onheadclick,this);
            this.board_div.form.board_mn_list_Grd.addEventHandler("oncellclick",this.board_div_board_mn_list_Grd_oncellclick,this);
            this.board_div.form.btn_modify.addEventHandler("onclick",this.board_div_btn_modify_onclick,this);
            this.board_div.form.btn_add.addEventHandler("onclick",this.board_div_btn_add_onclick,this);
            this.board_div.form.btn_del.addEventHandler("onclick",this.board_div_btn_del_onclick,this);
            this.board_div.form.Static01.addEventHandler("onclick",this.Common_onclick,this);
            this.board_div.form.Div00.form.stcSeq.addEventHandler("onclick",this.Common_onclick,this);
            this.board_div.form.Div00.form.Static00.addEventHandler("onclick",this.Common_onclick,this);
            this.board_div.form.Div00.form.Static00_00.addEventHandler("onclick",this.Common_onclick,this);
        };

        this.loadIncludeScript("M53_board.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
