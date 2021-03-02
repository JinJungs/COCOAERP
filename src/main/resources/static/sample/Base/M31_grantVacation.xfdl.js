(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M32_grantVacation");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_document", this);
            obj._setContents("<ColumnInfo><Column id=\"seq\" type=\"INT\" size=\"256\"/><Column id=\"title\" type=\"STRING\" size=\"256\"/><Column id=\"contents\" type=\"STRING\" size=\"256\"/><Column id=\"write_date\" type=\"DATETIME\" size=\"256\"/><Column id=\"final_date\" type=\"DATETIME\" size=\"256\"/><Column id=\"writer_code\" type=\"INT\" size=\"256\"/><Column id=\"dept_code\" type=\"INT\" size=\"256\"/><Column id=\"temp_code\" type=\"INT\" size=\"256\"/><Column id=\"leave_start\" type=\"DATE\" size=\"256\"/><Column id=\"leave_end\" type=\"DATE\" size=\"256\"/><Column id=\"leave_type\" type=\"STRING\" size=\"256\"/><Column id=\"status\" type=\"STRING\" size=\"256\"/><Column id=\"process\" type=\"STRING\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"seq\">1001</Col><Col id=\"title\">조퇴</Col><Col id=\"contents\">3시에 먼저 갑니다</Col><Col id=\"write_date\">2021-02-16</Col><Col id=\"final_date\">2021-02-16</Col><Col id=\"writer_code\">1004</Col><Col id=\"leave_start\">2021-02-16</Col><Col id=\"leave_end\"/><Col id=\"leave_type\">조퇴</Col><Col id=\"status\">CONFIRM</Col><Col id=\"process\">N</Col></Row><Row><Col id=\"seq\">1002</Col><Col id=\"title\">기타</Col><Col id=\"contents\">일주일만 쉴게여</Col><Col id=\"write_date\">2021-02-17</Col><Col id=\"final_date\">2021-02-17</Col><Col id=\"writer_code\">1004</Col><Col id=\"leave_start\">2021-02-20</Col><Col id=\"leave_end\">2021-02-27</Col><Col id=\"leave_type\">기타</Col><Col id=\"status\">CONFIRM</Col><Col id=\"process\">Y</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("휴가 사용처리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Div("Div00","10","100",null,null,"660","50","380",null,"470",null,this);
            obj.set_taborder("1");
            obj.set_text("Div00");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","0","0.00%",null,null,"0","0",null,null,null,null,this.Div00.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_document");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"61\"/><Column size=\"129\"/><Column size=\"93\"/><Column size=\"51\"/></Columns><Rows><Row size=\"35\" band=\"head\"/><Row size=\"30\"/></Rows><Band id=\"head\"><Cell text=\"문서번호\"/><Cell col=\"1\" text=\"제목\"/><Cell col=\"2\" text=\"승인날짜\" autosizecol=\"default\"/><Cell col=\"3\" text=\"처리여부\"/></Band><Band id=\"body\"><Cell text=\"bind:seq\" textAlign=\"center\" displaytype=\"mask\" maskeditformat=\"####\"/><Cell col=\"1\" text=\"bind:title\" textAlign=\"center\"/><Cell col=\"2\" text=\"bind:final_date\" textAlign=\"center\" displaytype=\"calendarcontrol\" autosizerow=\"limitmin\" autosizecol=\"default\"/><Cell col=\"3\" text=\"bind:process\" textAlign=\"center\"/></Band></Format></Formats>");
            this.Div00.addChild(obj.name, obj);

            obj = new Div("divDocument","Div00:10","270","600",null,null,"50",null,null,"300",null,this);
            obj.set_taborder("2");
            obj.set_text("Div01");
            obj.set_border("1px solid #c9c9c9");
            obj.set_formscrollbartype("none");
            obj.set_formscrolltype("none");
            this.addChild(obj.name, obj);

            obj = new Static("Static00","20","65","80","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("0");
            obj.set_text("제목");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_00","20","170","80",null,null,"10",null,null,null,null,this.divDocument.form);
            obj.set_taborder("1");
            obj.set_text("내용");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new TextArea("TextArea00","110","175",null,null,"25","15",null,null,null,null,this.divDocument.form);
            obj.set_taborder("2");
            obj.set_enable("false");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01","300","30","80","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("3");
            obj.set_text("승인날짜");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_00","20","100","80","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("4");
            obj.set_text("종류");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_02","105","30","120","30",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("5");
            obj.set_text("문서번호");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_01","20","135","80","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("6");
            obj.set_text("시작 날짜");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_02","300","135","80","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("7");
            obj.set_text("마감 날짜");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_00","300","100","80","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("8");
            obj.set_text("작성자");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_02_00","0","0",null,"20","172",null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("9");
            obj.set_text("휴가 신청서");
            obj.set_cssclass("sta_WF_title01");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_03","20","30","80","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("10");
            obj.set_text("문서번호");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 5px");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("staticSeq","100","30","200","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("11");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_text("");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_03","380","30",null,"35","20",null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("12");
            obj.set_border("1px solid #c9c9c9,0px none,1px solid #c9c9c9,");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_04","100","65",null,"35","20",null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("13");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_01","100","100","200","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("14");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_01_00","380","100",null,"35","20",null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("15");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_01_00_00","380","135",null,"35","20",null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("16");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_01_00_00_00","100","135","200","35",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("17");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("Static00_00_00","100","170",null,null,"20","10",null,null,null,null,this.divDocument.form);
            obj.set_taborder("18");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("staticWriter","385","102","195","30",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("19");
            obj.set_text("writer");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("staticTitle","105","67","196","29",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("20");
            obj.set_text("Static02");
            this.divDocument.addChild(obj.name, obj);

            obj = new MaskEdit("maskStartDate","109","137","120","30",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("21");
            obj.set_border("none");
            obj.set_format("#### - ## - ##");
            obj.set_type("string");
            obj.set_enable("false");
            obj.set_background("#ffffff");
            obj.set_color("#000000");
            this.divDocument.addChild(obj.name, obj);

            obj = new MaskEdit("maskEndDate","385","137","120","30",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("22");
            obj.set_border("none");
            obj.set_format("#### - ## - ##");
            obj.set_type("string");
            obj.set_enable("false");
            obj.set_background("#ffffff");
            obj.set_color("#000000");
            this.divDocument.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit00_00_00","385","32","120","30",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("23");
            obj.set_border("none");
            obj.set_format("#### - ## - ##");
            obj.set_type("string");
            obj.set_enable("false");
            obj.set_background("#ffffff");
            obj.set_color("#000000");
            this.divDocument.addChild(obj.name, obj);

            obj = new Static("staticType","105","102","195","30",null,null,null,null,null,null,this.divDocument.form);
            obj.set_taborder("24");
            obj.set_text("Static02");
            this.divDocument.addChild(obj.name, obj);

            obj = new Div("divProcess","Div00:10","100","600","160",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("Div02");
            obj.set_border("1px solid #c9c9c9");
            obj.set_formscrollbartype("none");
            obj.set_formscrolltype("none");
            this.addChild(obj.name, obj);

            obj = new CheckBox("checkMinus","25","125","194","25",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("0");
            obj.set_text("휴가 차감 여부");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("seq","105","30","100","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("1");
            obj.set_text("문서번호");
            obj.set_border("1px solid #c9c9c9c,0px none,0px none");
            this.divProcess.addChild(obj.name, obj);

            obj = new Spin("spinTime","105","92","150","25",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("2");
            obj.set_min("1");
            obj.set_max("7");
            obj.set_value("");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static01","20","60","80","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("3");
            obj.set_text("종류");
            obj.set_padding("0px 0px 0px 5px");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static01_00","20","90","80","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("4");
            obj.set_text("시간");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            obj.set_padding("0px 0px 0px 5px");
            this.divProcess.addChild(obj.name, obj);

            obj = new Edit("editType","105","62","150","25",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("5");
            obj.set_enable("false");
            this.divProcess.addChild(obj.name, obj);

            obj = new Calendar("calStart","375","62","150","25",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("6");
            this.divProcess.addChild(obj.name, obj);

            obj = new Calendar("calEnd","375","92","150","25",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("7");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static00","80","60","200","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("8");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static00_00","80","90","200","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("9");
            obj.set_border("0px none,0px none,1px solid #c9c9c9,");
            obj.set_padding("0px 0px 0px 5px");
            obj.set_text("");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static00_01","370","60","210","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("10");
            obj.set_border("1px solid #c7c7c7,0px none");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static00_00_00","370","90","210","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("11");
            obj.set_border("0px none,0px none,1px solid #c9c9c9,");
            obj.set_padding("0px 0px 0px 5px");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static01_01","280","60","90","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("12");
            obj.set_text("시작 날짜");
            obj.set_border("1px solid #c7c7c7");
            obj.set_padding("0px 0px 0px 5px");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static01_00_00","280","90","90","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("13");
            obj.set_text("마감 날짜");
            obj.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c7c7c7");
            obj.set_padding("0px 0px 0px 5px");
            this.divProcess.addChild(obj.name, obj);

            obj = new Button("submitBtn00",null,"-42","69","25","-0.97%",null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("14");
            obj.set_text("등록");
            obj.set_background("linear-gradient(#23cccc,#1098d5)");
            obj.set_borderRadius("10px");
            obj.set_color("#ffffff");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static00_02","0","0",null,"20","172",null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("15");
            obj.set_text("휴가 사용 처리");
            obj.set_cssclass("sta_WF_title01");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static01_02","20","30","80","30",null,null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("16");
            obj.set_text("문서번호");
            obj.set_padding("0px 0px 0px 5px");
            obj.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static00_01_00","100","30",null,"30","20",null,null,null,null,null,this.divProcess.form);
            obj.set_taborder("17");
            obj.set_border("1px solid #c7c7c7,0px none");
            this.divProcess.addChild(obj.name, obj);

            obj = new Static("Static00_01_00_01","100","100","200","35",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_border("0px none,0px none,1px solid #c9c9c9");
            this.addChild(obj.name, obj);

            obj = new Div("Div01","20","50",null,"30","50",null,"990",null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("Div01");
            this.addChild(obj.name, obj);

            obj = new Button("submitBtn",null,"0","60","30","0",null,null,null,null,null,this.Div01.form);
            obj.set_taborder("0");
            obj.set_text("추가");
            obj.set_cssclass("btn_WF_add01");
            this.Div01.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,
            	//-- Layout function
            	function(p)
            	{
                var rootobj = p;


                // {{ this.Div00
                p = rootobj.Div00.form;

                p.Grid00.set_taborder("0");
                p.Grid00.set_binddataset("ds_document");
                p.Grid00.set_autofittype("col");
                p.Grid00.move("0","0.00%",null,null,"0","0");
                // this.Div00 }}


                // {{ this.divDocument
                p = rootobj.divDocument.form;

                p.Static00.set_taborder("0");
                p.Static00.set_text("제목");
                p.Static00.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static00.set_padding("0px 0px 0px 5px");
                p.Static00.move("20","65","80","35",null,null);

                p.Static00_00.set_taborder("1");
                p.Static00_00.set_text("내용");
                p.Static00_00.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static00_00.set_padding("0px 0px 0px 5px");
                p.Static00_00.move("20","170","80",null,null,"10");

                p.TextArea00.set_taborder("2");
                p.TextArea00.set_enable("false");
                p.TextArea00.set_maxheight("");
                p.TextArea00.move("110","175",null,null,"25","15");

                p.Static00_01.set_taborder("3");
                p.Static00_01.set_text("승인날짜");
                p.Static00_01.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static00_01.set_padding("0px 0px 0px 5px");
                p.Static00_01.move("300","30","80","35",null,null);

                p.Static00_01_00.set_taborder("4");
                p.Static00_01_00.set_text("종류");
                p.Static00_01_00.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static00_01_00.set_padding("0px 0px 0px 5px");
                p.Static00_01_00.move("20","100","80","35",null,null);

                p.Static00_02.set_taborder("5");
                p.Static00_02.set_text("문서번호");
                p.Static00_02.move("105","30","120","30",null,null);

                p.Static00_01_01.set_taborder("6");
                p.Static00_01_01.set_text("시작 날짜");
                p.Static00_01_01.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static00_01_01.set_padding("0px 0px 0px 5px");
                p.Static00_01_01.move("20","135","80","35",null,null);

                p.Static00_01_02.set_taborder("7");
                p.Static00_01_02.set_text("마감 날짜");
                p.Static00_01_02.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9");
                p.Static00_01_02.set_padding("0px 0px 0px 5px");
                p.Static00_01_02.move("300","135","80","35",null,null);

                p.Static00_01_00_00.set_taborder("8");
                p.Static00_01_00_00.set_text("작성자");
                p.Static00_01_00_00.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9");
                p.Static00_01_00_00.set_padding("0px 0px 0px 5px");
                p.Static00_01_00_00.move("300","100","80","35",null,null);

                p.Static00_02_00.set_taborder("9");
                p.Static00_02_00.set_text("휴가 신청서");
                p.Static00_02_00.set_cssclass("sta_WF_title01");
                p.Static00_02_00.move("0","0",null,"20","172",null);

                p.Static00_03.set_taborder("10");
                p.Static00_03.set_text("문서번호");
                p.Static00_03.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static00_03.set_padding("0px 0px 0px 5px");
                p.Static00_03.move("20","30","80","35",null,null);

                p.staticSeq.set_taborder("11");
                p.staticSeq.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.staticSeq.set_text("");
                p.staticSeq.move("100","30","200","35",null,null);

                p.Static00_01_03.set_taborder("12");
                p.Static00_01_03.set_border("1px solid #c9c9c9,0px none,1px solid #c9c9c9,");
                p.Static00_01_03.move("380","30",null,"35","20",null);

                p.Static00_04.set_taborder("13");
                p.Static00_04.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00_04.move("100","65",null,"35","20",null);

                p.Static00_01_00_01.set_taborder("14");
                p.Static00_01_00_01.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00_01_00_01.move("100","100","200","35",null,null);

                p.Static00_01_00_01_00.set_taborder("15");
                p.Static00_01_00_01_00.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00_01_00_01_00.move("380","100",null,"35","20",null);

                p.Static00_01_00_01_00_00.set_taborder("16");
                p.Static00_01_00_01_00_00.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00_01_00_01_00_00.move("380","135",null,"35","20",null);

                p.Static00_01_00_01_00_00_00.set_taborder("17");
                p.Static00_01_00_01_00_00_00.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00_01_00_01_00_00_00.move("100","135","200","35",null,null);

                p.Static00_00_00.set_taborder("18");
                p.Static00_00_00.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00_00_00.move("100","170",null,null,"20","10");

                p.staticWriter.set_taborder("19");
                p.staticWriter.set_text("writer");
                p.staticWriter.move("385","102","195","30",null,null);

                p.staticTitle.set_taborder("20");
                p.staticTitle.set_text("Static02");
                p.staticTitle.move("105","67","196","29",null,null);

                p.maskStartDate.set_taborder("21");
                p.maskStartDate.set_border("none");
                p.maskStartDate.set_format("#### - ## - ##");
                p.maskStartDate.set_type("string");
                p.maskStartDate.set_enable("false");
                p.maskStartDate.set_background("#ffffff");
                p.maskStartDate.set_color("#000000");
                p.maskStartDate.move("109","137","120","30",null,null);

                p.maskEndDate.set_taborder("22");
                p.maskEndDate.set_border("none");
                p.maskEndDate.set_format("#### - ## - ##");
                p.maskEndDate.set_type("string");
                p.maskEndDate.set_enable("false");
                p.maskEndDate.set_background("#ffffff");
                p.maskEndDate.set_color("#000000");
                p.maskEndDate.move("385","137","120","30",null,null);

                p.MaskEdit00_00_00.set_taborder("23");
                p.MaskEdit00_00_00.set_border("none");
                p.MaskEdit00_00_00.set_format("#### - ## - ##");
                p.MaskEdit00_00_00.set_type("string");
                p.MaskEdit00_00_00.set_enable("false");
                p.MaskEdit00_00_00.set_background("#ffffff");
                p.MaskEdit00_00_00.set_color("#000000");
                p.MaskEdit00_00_00.move("385","32","120","30",null,null);

                p.staticType.set_taborder("24");
                p.staticType.set_text("Static02");
                p.staticType.move("105","102","195","30",null,null);
                // this.divDocument }}


                // {{ this.divProcess
                p = rootobj.divProcess.form;

                p.checkMinus.set_taborder("0");
                p.checkMinus.set_text("휴가 차감 여부");
                p.checkMinus.move("25","125","194","25",null,null);

                p.seq.set_taborder("1");
                p.seq.set_text("문서번호");
                p.seq.set_border("1px solid #c9c9c9c,0px none,0px none");
                p.seq.move("105","30","100","30",null,null);

                p.spinTime.set_taborder("2");
                p.spinTime.set_min("1");
                p.spinTime.set_max("7");
                p.spinTime.set_value("");
                p.spinTime.move("105","92","150","25",null,null);

                p.Static01.set_taborder("3");
                p.Static01.set_text("종류");
                p.Static01.set_padding("0px 0px 0px 5px");
                p.Static01.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static01.move("20","60","80","30",null,null);

                p.Static01_00.set_taborder("4");
                p.Static01_00.set_text("시간");
                p.Static01_00.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static01_00.set_padding("0px 0px 0px 5px");
                p.Static01_00.move("20","90","80","30",null,null);

                p.editType.set_taborder("5");
                p.editType.set_enable("false");
                p.editType.move("105","62","150","25",null,null);

                p.calStart.set_taborder("6");
                p.calStart.move("375","62","150","25",null,null);

                p.calEnd.set_taborder("7");
                p.calEnd.move("375","92","150","25",null,null);

                p.Static00.set_taborder("8");
                p.Static00.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00.move("80","60","200","30",null,null);

                p.Static00_00.set_taborder("9");
                p.Static00_00.set_border("0px none,0px none,1px solid #c9c9c9,");
                p.Static00_00.set_padding("0px 0px 0px 5px");
                p.Static00_00.set_text("");
                p.Static00_00.move("80","90","200","30",null,null);

                p.Static00_01.set_taborder("10");
                p.Static00_01.set_border("1px solid #c7c7c7,0px none");
                p.Static00_01.move("370","60","210","30",null,null);

                p.Static00_00_00.set_taborder("11");
                p.Static00_00_00.set_border("0px none,0px none,1px solid #c9c9c9,");
                p.Static00_00_00.set_padding("0px 0px 0px 5px");
                p.Static00_00_00.move("370","90","210","30",null,null);

                p.Static01_01.set_taborder("12");
                p.Static01_01.set_text("시작 날짜");
                p.Static01_01.set_border("1px solid #c7c7c7");
                p.Static01_01.set_padding("0px 0px 0px 5px");
                p.Static01_01.move("280","60","90","30",null,null);

                p.Static01_00_00.set_taborder("13");
                p.Static01_00_00.set_text("마감 날짜");
                p.Static01_00_00.set_border("0px none,1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c7c7c7");
                p.Static01_00_00.set_padding("0px 0px 0px 5px");
                p.Static01_00_00.move("280","90","90","30",null,null);

                p.submitBtn00.set_taborder("14");
                p.submitBtn00.set_text("등록");
                p.submitBtn00.set_background("linear-gradient(#23cccc,#1098d5)");
                p.submitBtn00.set_borderRadius("10px");
                p.submitBtn00.set_color("#ffffff");
                p.submitBtn00.move(null,"-42","69","25","-0.97%",null);

                p.Static00_02.set_taborder("15");
                p.Static00_02.set_text("휴가 사용 처리");
                p.Static00_02.set_cssclass("sta_WF_title01");
                p.Static00_02.move("0","0",null,"20","172",null);

                p.Static01_02.set_taborder("16");
                p.Static01_02.set_text("문서번호");
                p.Static01_02.set_padding("0px 0px 0px 5px");
                p.Static01_02.set_border("1px solid #c9c9c9,1px solid #c9c9c9,1px solid #c9c9c9,0px none");
                p.Static01_02.move("20","30","80","30",null,null);

                p.Static00_01_00.set_taborder("17");
                p.Static00_01_00.set_border("1px solid #c7c7c7,0px none");
                p.Static00_01_00.move("100","30",null,"30","20",null);
                // this.divProcess }}


                // {{ this.Div01
                p = rootobj.Div01.form;

                p.submitBtn.set_taborder("0");
                p.submitBtn.set_text("추가");
                p.submitBtn.set_cssclass("btn_WF_add01");
                p.submitBtn.move(null,"0","60","30","0",null);
                // this.Div01 }}
                p = rootobj;
                p.set_titletext("New Form");

                p.Static00.set_taborder("0");
                p.Static00.set_text("휴가 사용처리");
                p.Static00.set_cssclass("sta_WF_title01");
                p.Static00.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
                p.Static00.move("0","0",null,"34","10",null);

                p.Div00.set_taborder("1");
                p.Div00.set_text("Div00");
                p.Div00.set_minheight("470");
                p.Div00.set_maxheight("");
                p.Div00.set_minwidth("380");
                p.Div00.set_maxwidth("");
                p.Div00.move("10","100",null,null,"660","50");

                p.divDocument.set_taborder("2");
                p.divDocument.set_text("Div01");
                p.divDocument.set_border("1px solid #c9c9c9");
                p.divDocument.set_formscrollbartype("none");
                p.divDocument.set_formscrolltype("none");
                p.divDocument.set_minheight("300");
                p.divDocument.set_maxheight("");
                p.divDocument.move("Div00:10","270","600",null,null,"50");

                p.divProcess.set_taborder("3");
                p.divProcess.set_text("Div02");
                p.divProcess.set_border("1px solid #c9c9c9");
                p.divProcess.set_formscrollbartype("none");
                p.divProcess.set_formscrolltype("none");
                p.divProcess.move("Div00:10","100","600","160",null,null);

                p.Static00_01_00_01.set_taborder("4");
                p.Static00_01_00_01.set_border("0px none,0px none,1px solid #c9c9c9");
                p.Static00_01_00_01.move("100","100","200","35",null,null);

                p.Div01.set_taborder("5");
                p.Div01.set_text("Div01");
                p.Div01.set_minwidth("990");
                p.Div01.set_maxwidth("");
                p.Div01.move("20","50",null,"30","50",null);
            	}
            );
            this.addLayout(obj.name, obj);

            //-- Normal Layout : this
            obj = new Layout("default0","",1090,650,this,
            	//-- Layout function
            	function(p)
            	{
                var rootobj = p;


                // {{ this.Div00
                p = rootobj.Div00.form;

                p.Grid00.set_taborder("0");
                p.Grid00.set_binddataset("ds_document");
                p.Grid00.set_autofittype("col");
                p.Grid00.move("1%","1%","99%","99%",null,null);
                // this.Div00 }}


                // {{ this.divDocument
                p = rootobj.divDocument.form;

                p.Static00.set_taborder("0");
                p.Static00.set_text("제목");
                p.Static00.move("285","19","40","30",null,null);

                p.Static00_00.set_taborder("1");
                p.Static00_00.set_text("내용");
                p.Static00_00.move("285","58","40","30",null,null);

                p.TextArea00.set_taborder("2");
                p.TextArea00.move("335","59","300","220",null,null);
                // this.divDocument }}
                p = rootobj;
                p.Static00.set_taborder("0");
                p.Static00.set_text("휴가 부여");
                p.Static00.set_cssclass("sta_WF_title01");
                p.Static00.move("0","0",null,"34","10",null);

                p.Div00.set_taborder("2");
                p.Div00.set_text("Div00");
                p.Div00.set_border("1px solid black");
                p.Div00.move("2%","100","35%","500",null,null);

                p.divDocument.set_taborder("1");
                p.divDocument.set_text("Div01");
                p.divDocument.set_border("1px solid black");
                p.divDocument.move("39%","100",null,"300","2%",null);
            	}
            );
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item0","divDocument.form.Static00_02","text","ds_document","seq");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item9","divProcess.form.seq","text","ds_document","seq");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item11","divProcess.form.editType","value","ds_document","leave_type");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item12","divProcess.form.calStart","value","ds_document","leave_start");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item13","divProcess.form.calEnd","value","ds_document","leave_end");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","divDocument.form.TextArea00","value","ds_document","contents");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item14","divDocument.form.staticTitle","text","ds_document","title");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item16","divDocument.form.maskStartDate","value","ds_document","leave_start");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","divDocument.form.MaskEdit00_00_00","value","ds_document","final_date");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item3","divDocument.form.maskEndDate","value","ds_document","leave_end");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item4","divDocument.form.staticType","text","ds_document","title");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item5","divDocument.form.staticWriter","text","ds_document","name");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M31_grantVacation.xfdl", function() {


        this.M31_grantVacation_onload = function(obj,e)
        {
        	this.transaction(
        			"documentList", // 1. strSvcID
        			"/documentN/getEarlyList.documentN", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"ds_document=out_document", // 4. strOutDatasets -select Fds=Sds
        			"" , // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"" // 6. strCallbackFunc
        		);
        };
        this.fn_callback = function(result)
        {
        	this.ds_document_onrowposchanged();
        }

        this.Div02_submitBtn_onclick = function(obj,e)
        {
        	var seq = this.divDocument.form.staticSeq.value;
        	var type = this.divDocument.form.staticType.value;
        	var startDate = this.divProcess.form.startCalendar.value;
        	var endDate = this.divProcess.form.endCalendar.value;
        	var time = this.divProcess.form.timeSpin.value;
        	var empCode = this.ds_employee.getColumn(this.ds_employee.rowposition, "code");
        	var check = this.divProcess.form.checkMinus.value;


        	//ds_document 가져오기
        	this.transaction(
        			"insertLeave", // 1. strSvcID
        			"/leaveN/insert.leaveN", // 2. strURL
        			"", // 3. strIndatasets - Insert,Delete,Update  Sds = Fds :U ,:A ,:N
        			"", // 4. strOutDatasets -select Fds=Sds
        			"seq=" +seq + " type=" + type + " startDate=" + startDate + " endDate=" + endDate + " time=" + time + " empCode=" + empCode + " check=" + check, // 5. strArgument 화면에서 서버로 보내는 변수값 (구분자는 띄어쓰기로' ')
        			"" // 6. strCallbackFunc
        		);
        	this.M31_grantVacation_onload();

        };

        this.ds_document_onrowposchanged = function(obj,e)
        {
        	//처리상태 Y일때 처리 못하게 막기
        	var process = this.ds_document.getColumn(e.newrow, "process");
        	if(process == "Y"){
        		this.divProcess.form.spinTime.set_enable(false);
        		this.divProcess.form.calStart.set_enable(false);
        		this.divProcess.form.calEnd.set_enable(false);
        		this.submitBtn.set_enable(false);
        	}else {
        		this.submitBtn.set_enable(true);
        		//조퇴인지 기타인지에 따라 입력가능창 바꿔주기
        		var type = this.ds_document.getColumn(e.newrow, "leave_type");
        		if (type == "조퇴"){
        			this.divProcess.form.spinTime.set_enable(true);
        			this.divProcess.form.calEnd.set_enable(false);
        		}else if (type == "기타"){
        			this.divProcess.form.spinTime.set_enable(false);
        			this.divProcess.form.calEnd.set_enable(true);
        		}
        	}

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M31_grantVacation_onload,this);
            this.divDocument.form.Static00_04.addEventHandler("onclick",this.Div01_Static00_04_onclick,this);
            this.divDocument.form.maskStartDate.addEventHandler("onchanged",this.divDocument_maskStartDate_onchanged,this);
            this.divProcess.form.checkMinus.addEventHandler("onclick",this.Div02_CheckBox00_onclick,this);
            this.divProcess.form.Static00_00.addEventHandler("onclick",this.Div02_Static00_00_onclick,this);
            this.divProcess.form.submitBtn00.addEventHandler("onclick",this.Div02_submitBtn_onclick,this);
            this.Div01.form.submitBtn.addEventHandler("onclick",this.Div02_submitBtn_onclick,this);
            this.ds_document.addEventHandler("onrowposchanged",this.ds_document_onrowposchanged,this);
        };

        this.loadIncludeScript("M31_grantVacation.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
