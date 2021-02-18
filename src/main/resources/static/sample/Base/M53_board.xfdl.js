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
            obj._setContents("<ColumnInfo><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"type\" type=\"STRING\" size=\"256\"/><Column id=\"chk\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","6",null,"34","10",null,null,null,null,null,this);
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

            obj = new Div("board_div","8.26%","21.08%","65.23%","60.31%",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);

            obj = new Grid("board_mn_list_Grd","-1.41%","13.27%","53.45%","69.90%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_board_menu");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"48\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell displaytype=\"checkboxcontrol\" edittype=\"checkbox\" text=\"0\"/><Cell col=\"1\" text=\"seq\"/><Cell col=\"2\" text=\"name\"/><Cell col=\"3\" text=\"type\"/></Band><Band id=\"body\"><Cell displaytype=\"checkboxcontrol\" edittype=\"checkbox\" text=\"bind:chk\"/><Cell col=\"1\" text=\"bind:seq\"/><Cell col=\"2\" text=\"bind:name\"/><Cell col=\"3\" text=\"bind:type\"/></Band></Format></Formats>");
            this.board_div.addChild(obj.name, obj);

            obj = new Button("btn_modify","88.61%","77.30%","7.88%","6.38%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("1");
            obj.set_text("수정");
            this.board_div.addChild(obj.name, obj);

            obj = new Button("btn_add","61.04%","77.30%","7.88%","6.38%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("2");
            obj.set_text("추가");
            this.board_div.addChild(obj.name, obj);

            obj = new Button("btn_del","75.25%","77.30%","7.88%","6.38%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("3");
            obj.set_text("삭제");
            this.board_div.addChild(obj.name, obj);

            obj = new Static("Static00","60.34%","47.70%","9.14%","8.93%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("4");
            obj.set_text("게시판 이름");
            this.board_div.addChild(obj.name, obj);

            obj = new Static("Static01","70.89%","18.37%","15.89%","5.87%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("5");
            obj.set_text("게시판 정보");
            obj.set_textAlign("center");
            obj.set_font("bold 12px/normal \"Arial\",\"Malgun Gothic\",\"Gulim\"");
            this.board_div.addChild(obj.name, obj);

            obj = new Static("Static00_00","60.34%","62.24%","9.14%","8.93%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("6");
            obj.set_text("게시판 종류");
            this.board_div.addChild(obj.name, obj);

            obj = new Edit("edtBoardNm","74.40%","48.72%","20.11%","8.93%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("7");
            obj.getSetter("onclick").set("Common_onclick");
            this.board_div.addChild(obj.name, obj);

            obj = new Radio("rdoType","74.40%","63.52%",null,"7.40%","21",null,null,null,null,null,this.board_div.form);
            obj.set_taborder("8");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("2");
            obj.set_readonly("true");
            obj.set_innerdataset("board_type_radio");
            this.board_div.addChild(obj.name, obj);

            obj = new Static("stcSeq","60.62%","35.46%","8.72%","8.93%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("9");
            obj.set_text("게시판 번호");
            this.board_div.addChild(obj.name, obj);

            obj = new MaskEdit("mskSeq","74.54%","35.71%","6.47%","8.42%",null,null,null,null,null,null,this.board_div.form);
            obj.set_taborder("10");
            this.board_div.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item0","board_div.form.edtBoardNm","value","ds_board_menu","name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","board_div.form.rdoType","value","ds_board_menu","type");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","board_div.form.mskSeq","value","ds_board_menu","seq");
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
        	trace("도착");
        	this.transaction(
          		"board_Menu_list" // id
          		, "/NecBoard/getBoardMenuList.nc" // url
        		, "" // inData
          		, "ds_board_menu=out_board_menu" // outData
         		, ""// strArg
          		, "fn_callback_mnList" // callback
          	);
        };
        this.fn_callback_mnList = function(result)
        {
        	trace("리스트 불러옴!");
        }
        //추가 버튼
        this.board_div_btn_add_onclick = function(obj,e)
        {
        	trace("눌린거지");
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
        	if (type=="1"){
        		type = "Album";
        	trace(type);
        	}
        	if (type=="2"){
        		type = "List";
        	trace(type);
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

        this.fn_callback = function(result)
        {
        	trace("추가 완료!");
        	this.M53_board_onload();
        }
        //삭제 버튼
        this.board_div_btn_del_onclick = function(obj,e)
        {
        	let arr = this.ds_board_menu.extractRows("chk==1");
        	if(arr.length == 0 || arr == -1) {alert("선택된 항목이 없습니다.");return}
        	trace("arr은?"+arr);

         	this.ds_board_menu.deleteMultiRows(arr);
        	this.transaction(
          		"boardDelete" // id
          		, "/NecBoard/delBoard.nc" // url
        		, "ds_delBoard = ds_board_menu:D" // inData
          		, "" // outData
         		, ""// strArg
          		, "fn_callback_del" // callback
          	);
        };
        this.fn_callback_del = function(result)
        {
        	trace("삭제 완료!");
        	this.alert("삭제 되었습니다.");
        }
        //수정 버튼
        this.board_div_btn_modify_onclick = function(obj,e)
        {
        	var seq = this.board_div.form.mskSeq.value;
        	var name = this.board_div.form.edtBoardNm.value;
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
        	this.alert("수정 되었습니다.");
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
        	//var objDs = obj.getBindDataset();
        	if(strColID == "chk"){
        		var sheadValue = obj.getCellProperty("head", e.cell, "text"); //head에서 선택한 행의 text 값 가져오기
        		sheadValue = (sheadValue == "1" ? "0" : "1");
        		trace("sheadValue "+sheadValue);

        		this.ds_board_menu.set_enableevent(false);
        		for(var i=0; i<this.ds_board_menu.getRowCount(); i++){
        			this.ds_board_menu.setColumn(i,"chk",sheadValue);
        			//objDs.setColumn(i, "chk", sheadValue);
        		}
        		obj.setCellProperty("head", e.cell, "text", sheadValue);//변경될 걸 head에도 주겠다 (Cell의 특정 속성 값을 설정하는 메소드입니다.)
        		this.ds_board_menu.set_enableevent(true);
        		//objDs.set_enableevent(true);
        		}
        };
        //
        // this.board_div_board_mn_list_Grd_oncellclick = function(obj:nexacro.Grid,e:nexacro.GridClickEventInfo)
        // {
        // 	trace("여긴 찍히니");
        // 	if(e.col == this.board_div.form.board_mn_list_Grd.getBindCellIndex("body", "chk")) { // 체크박스 선택했을 경우
        // 		for(var i = 0; i<this.board_div.form.board_mn_list_Grd.rowcount; i++) { // 데이터셋 전체 확인
        // 			if(e.row == i) {// 현재 행의 체크박스를 눌렀을 경우
        // 				// 무반응 (체크 해제 안함)
        // 			} else {
        // 				this.board_div.form.board_mn_list_Grd.setColumn(i,"CHK","0");
        //                 		// 클릭한 행의 체크박스를 제외한 나머지 체크박스는 체크 해제
        // 			}
        // 		}
        // 	}
        // };

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
            this.board_div.form.Static00.addEventHandler("onclick",this.Common_onclick,this);
            this.board_div.form.Static01.addEventHandler("onclick",this.Common_onclick,this);
            this.board_div.form.Static00_00.addEventHandler("onclick",this.Common_onclick,this);
            this.board_div.form.stcSeq.addEventHandler("onclick",this.Common_onclick,this);
        };

        this.loadIncludeScript("M53_board.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
