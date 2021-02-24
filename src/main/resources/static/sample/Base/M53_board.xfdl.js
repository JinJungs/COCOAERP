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
            obj = new Dataset("board_type_radio", this);
            obj._setContents("<ColumnInfo><Column id=\"codecolumn\" type=\"STRING\" size=\"256\"/><Column id=\"datacolumn\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">List</Col><Col id=\"datacolumn\">리스트형</Col></Row><Row><Col id=\"codecolumn\">Album</Col><Col id=\"datacolumn\">이미지형</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_board_menu", this);
            obj._setContents("<ColumnInfo><Column id=\"chk\" type=\"STRING\" size=\"256\"/><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"type\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","20","10",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("게시판 관리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Button("btn_modify",null,"55","55","35","100",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("수정");
            obj.set_cssclass("btn_WF_reset01");
            this.addChild(obj.name, obj);

            obj = new Button("btn_del",null,"55","55","35","172",null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("삭제");
            obj.set_cssclass("btn_WF_delete01");
            this.addChild(obj.name, obj);

            obj = new Button("btn_add",null,"55","55","35","250",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("추가");
            obj.set_cssclass("btn_WF_add01");
            this.addChild(obj.name, obj);

            obj = new Grid("board_mn_list_Grd","20","100",null,null,"500","50",null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_binddataset("ds_board_menu");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"50\"/><Column size=\"53\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"0\" displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"게시판 번호\"/><Cell col=\"2\" text=\"게시판 이름\"/><Cell col=\"3\" text=\"게시판 종류\"/></Band><Band id=\"body\"><Cell text=\"bind:chk\" displaytype=\"checkboxcontrol\" edittype=\"checkbox\"/><Cell col=\"1\" text=\"bind:seq\" textAlign=\"center\"/><Cell col=\"2\" text=\"bind:name\"/><Cell col=\"3\" text=\"bind:type\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Static("stcTitle",null,"100","192","35","204",null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("게시판 정보 및 수정");
            obj.set_font("bold 13px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            obj.set_textAlign("center");
            this.addChild(obj.name, obj);

            obj = new Div("divBoardInfor",null,"145","386",null,"100","50",null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7");
            this.addChild(obj.name, obj);

            obj = new Static("stcTypeForm","138","127","200","132",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("0");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_text("");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new Static("stcNmForm","138","80","200","46",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("1");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 10px");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new Static("stcSeqForm","138","33","200","46",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("2");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_border("1px solid #c9c9c9,0px none");
            obj.set_text("");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new Static("stcSeq","18","33","120","46",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("3");
            obj.set_text("게시판 번호");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new Static("stcNm","18","80","120","46",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("4");
            obj.set_text("게시판 명");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new Static("stcType","18","127","120","132",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("5");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 10px");
            obj.set_text("게시판 종류");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new MaskEdit("mskSeq","145","40","30","32",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("6");
            obj.set_textAlign("center");
            obj.set_border("0px none,0px none,1px solid #c7c7c7");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new Edit("edtBoardNm","144","86","151","34",null,null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("7");
            obj.getSetter("onclick").set("Common_onclick");
            obj.set_border("0px none,0px none,1px solid #c7c7c7");
            this.divBoardInfor.addChild(obj.name, obj);

            obj = new Radio("rdoType","148","136",null,"108","91",null,null,null,null,null,this.divBoardInfor.form);
            obj.set_taborder("8");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("1");
            obj.set_readonly("true");
            obj.set_innerdataset("board_type_radio");
            this.divBoardInfor.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item0","divBoardInfor.form.mskSeq","value","ds_board_menu","seq");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","divBoardInfor.form.edtBoardNm","value","ds_board_menu","name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","divBoardInfor.form.rdoType","value","ds_board_menu","type");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M53_board.xfdl", function() {
        //내용 불러오기
        this.M53_board_onload = function(obj,e)
        {
        	this.transaction(
          		"board_Menu_list" // id
          		, "/NecBoard/getBoardMenuList.nc" // url
        		, "" // inData
          		, "ds_board_menu=out_board_menu" // outData
         		, ""// strArg
          		, "fn_callback_mnList" // callback
          	);
        };
        this.fn_callback_mnList = function(id, ErrCode, ErrMsg)
        {
        }
        //추가 버튼
        this.board_div_btn_add_onclick = function(obj,e)
        {
        	var objCF = new ChildFrame();
        	objCF.set_openalign("center middle");
        	objCF.set_formurl("Base::M54_boardPop.xfdl");
        	objCF.showModal(
        		this.getOwnerFrame()
        		,{}
        		,this
        		, "fn_callback_boardPop"
        	);
        };
        this.fn_callback_boardPop = function(id,sRtn){

        	var arrRtn = sRtn.split("|");
        	var type = arrRtn[0];
        	var name = arrRtn[1];
        	trace("type"+type);

        	if (type=="1"){
        		type = "Album";
        	}
        	if (type=="2"){
        		type = "List";
        	}

         	this.transaction(
           		"boardPop" // id
           		, "/NecBoard/addBoard.nc" // url
         		, "" // inData
           		, "" // outData
          		, "type="+type+" name="+name// strArg
           		, "fn_callback" // callback
           	);
        };

        this.fn_callback =function(id, ErrCode, ErrMsg)
        {
        	this.M53_board_onload();
        }

        //수정 버튼
        this.board_div_btn_modify_onclick = function(obj,e)
        {
        	let arr = this.ds_board_menu.extractRows("chk==1");
         	this.ds_board_menu.deleteMultiRows(arr);

        	var seq = this.divBoardInfor.form.mskSeq.value;
        	var name = this.divBoardInfor.form.edtBoardNm.value;
        	this.transaction(
          		"boardUpdate" // id
          		, "/NecBoard/uptBoard.nc" // url
        		, "ds_uptBoard = ds_board_menu:U" // inData
          		, "" // outData
         		, "name=" + name + " seq=" + seq// strArg
          		, "fn_callback_upt" // callback
          	);
        };
        this.fn_callback_upt =function(id, ErrCode, ErrMsg)
        {
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
        	var strColID = obj.getCellProperty("body", e.cell, "text").replace("bind:", ""); //Cell의 특정 속성 값을 반환하는 메소드입니다.
        	var sheadValue = obj.getCellProperty("head", e.cell, "text"); //head에서 선택한 행의 text 값 가져오기
        	//var objDs = obj.getBindDataset();

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
        	var seq = this.divBoardInfor.form.mskSeq.value;
        	trace("seq값은? "+seq);
        	if(arr.length == 0 || arr == -1) {alert("선택된 항목이 없습니다.");return}

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
        this.fn_callback_del = function(id, ErrCode, ErrMsg)
        {
        	this.alert("삭제 되었습니다.");
        }

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M53_board_onload,this);
            this.btn_modify.addEventHandler("onclick",this.board_div_btn_modify_onclick,this);
            this.btn_del.addEventHandler("onclick",this.board_div_btn_del_onclick,this);
            this.btn_add.addEventHandler("onclick",this.board_div_btn_add_onclick,this);
            this.board_mn_list_Grd.addEventHandler("onheadclick",this.board_div_board_mn_list_Grd_onheadclick,this);
            this.board_mn_list_Grd.addEventHandler("oncellclick",this.board_div_board_mn_list_Grd_oncellclick,this);
            this.divBoardInfor.form.stcType.addEventHandler("onclick",this.Static01_01_onclick,this);
        };

        this.loadIncludeScript("M53_board.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
