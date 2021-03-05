(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("M11_users");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_employee", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"password\" type=\"STRING\" size=\"256\"/><Column id=\"phone\" type=\"STRING\" size=\"256\"/><Column id=\"office_phone\" type=\"STRING\" size=\"256\"/><Column id=\"address\" type=\"STRING\" size=\"256\"/><Column id=\"email\" type=\"STRING\" size=\"256\"/><Column id=\"b_email\" type=\"STRING\" size=\"256\"/><Column id=\"gender\" type=\"STRING\" size=\"256\"/><Column id=\"hire_date\" type=\"DATE\" size=\"256\"/><Column id=\"withdraw\" type=\"STRING\" size=\"256\"/><Column id=\"dept_code\" type=\"INT\" size=\"256\"/><Column id=\"pos_code\" type=\"INT\" size=\"256\"/><Column id=\"team_code\" type=\"INT\" size=\"256\"/><Column id=\"deptname\" type=\"STRING\" size=\"256\"/><Column id=\"teamname\" type=\"STRING\" size=\"256\"/><Column id=\"posname\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_position", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">1</Col><Col id=\"name\">대표</Col></Row><Row><Col id=\"code\">2</Col><Col id=\"name\">부장</Col></Row><Row><Col id=\"code\">3</Col><Col id=\"name\">팀장</Col></Row><Row><Col id=\"code\">4</Col><Col id=\"name\">사원</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_departments", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"location_code\" type=\"INT\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">1</Col><Col id=\"name\">개발부</Col><Col id=\"location_code\">1</Col></Row><Row><Col id=\"code\">2</Col><Col id=\"name\">행정부</Col><Col id=\"location_code\">2</Col></Row><Row><Col id=\"code\">3</Col><Col id=\"name\">마케팅부</Col><Col id=\"location_code\">3</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_team", this);
            obj._setContents("<ColumnInfo><Column id=\"code\" type=\"INT\" size=\"256\"/><Column id=\"name\" type=\"STRING\" size=\"256\"/><Column id=\"dept_code\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"code\">11</Col><Col id=\"name\">개발1팀</Col><Col id=\"dept_code\">1</Col></Row><Row><Col id=\"code\">12</Col><Col id=\"name\">개발2팀</Col><Col id=\"dept_code\">1</Col></Row><Row><Col id=\"code\">13</Col><Col id=\"name\">개발3팀</Col><Col id=\"dept_code\">1</Col></Row><Row><Col id=\"code\">21</Col><Col id=\"name\">행정1팀</Col><Col id=\"dept_code\">2</Col></Row><Row><Col id=\"code\">31</Col><Col id=\"name\">마케팅1팀</Col><Col id=\"dept_code\">3</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_search", this);
            obj._setContents("<ColumnInfo><Column id=\"dept_code\" type=\"INT\" size=\"256\"/><Column id=\"team_code\" type=\"INT\" size=\"256\"/><Column id=\"pos_code\" type=\"INT\" size=\"256\"/><Column id=\"search\" type=\"STRING\" size=\"256\"/><Column id=\"searchWhat\" type=\"STRING\" size=\"256\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("sta_title","20","10",null,"30","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("사용자 관리");
            obj.set_cssclass("sta_WF_title01");
            obj.set_font("bold 18px/normal \"Malgun gothic\",\"Arial\",\"Gulim\"");
            this.addChild(obj.name, obj);

            obj = new Grid("grd_emp_list","20","175",null,null,"499","50","425",null,null,null,this);
            obj.set_taborder("1");
            obj.set_binddataset("ds_employee");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"26\"/><Column size=\"100\"/><Column size=\"80\"/><Column size=\"140\"/><Column size=\"140\"/><Column size=\"140\"/><Column size=\"80\"/><Column size=\"26\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"사번\"/><Cell col=\"1\" text=\"이름\"/><Cell col=\"2\" text=\"부서\"/><Cell col=\"3\" text=\"팀\"/><Cell col=\"4\" text=\"직책\"/><Cell col=\"5\" text=\"성\"/><Cell col=\"6\" text=\"연락처\"/><Cell col=\"7\" text=\"내선번호\"/><Cell col=\"8\" text=\"주소\"/><Cell col=\"9\" text=\"이메일\"/><Cell col=\"10\" text=\"내부 메일\"/><Cell col=\"11\" text=\"고용일\"/><Cell col=\"12\" text=\"퇴사\"/></Band><Band id=\"body\"><Cell text=\"bind:code\"/><Cell col=\"1\" text=\"bind:name\"/><Cell col=\"2\" text=\"bind:dept_code\" displaytype=\"combotext\" edittype=\"combo\" combodataset=\"ds_departments\" combodatacol=\"name\" combocodecol=\"code\"/><Cell col=\"3\" text=\"bind:team_code\" displaytype=\"combotext\" edittype=\"combo\" combodataset=\"ds_team\" combocodecol=\"code\" combodatacol=\"name\"/><Cell col=\"4\" text=\"bind:pos_code\" combodataset=\"ds_position\" combodatacol=\"name\" combocodecol=\"code\" displaytype=\"combotext\" edittype=\"combo\"/><Cell col=\"5\" text=\"bind:gender\"/><Cell col=\"6\" text=\"bind:phone\"/><Cell col=\"7\" text=\"bind:office_phone\"/><Cell col=\"8\" text=\"bind:address\"/><Cell col=\"9\" text=\"bind:email\"/><Cell col=\"10\" text=\"bind:b_email\"/><Cell col=\"11\" text=\"bind:hire_date\"/><Cell col=\"12\" text=\"bind:withdraw\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Div("div_info","grd_emp_list:10","175","389",null,null,"50","425",null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("");
            obj.getSetter("leftbase").set("");
            obj.getSetter("bottombase").set("");
            obj.getSetter("rightbase").set("");
            obj.getSetter("widthbase").set("");
            obj.getSetter("heightbase").set("");
            obj.set_formscrolltype("vertical");
            obj.set_formscrollbartype("auto");
            obj.set_border("1px solid #c7c7c7");
            obj.set_borderRadius("2px");
            this.addChild(obj.name, obj);

            obj = new Static("sta_name","8","86","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("1");
            obj.set_text("이름");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("Static12","8","194","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("2");
            obj.set_text("입사일");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_gender","8","162","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("3");
            obj.set_text("성");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_tablelabel");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_salary","201","161","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("4");
            obj.set_text("연봉");
            obj.set_background("");
            obj.set_padding("");
            obj.set_cssclass("sta_WF_tablelabel");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_code","8","48","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("5");
            obj.set_text("사번");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_salary","270","167","100","24",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("0");
            obj.set_type("number");
            obj.set_format("#,###");
            obj.set_enable("false");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_pass","8","124","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("6");
            obj.set_text("비밀번호");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_phone","201","199","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("7");
            obj.set_text("연락처");
            obj.set_background("");
            obj.set_padding("");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_phone","270","205","100","24",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("8");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_localphone","201","237","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("9");
            obj.set_text("사내 전화");
            obj.set_background("");
            obj.set_padding("");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_office_phone","270","243","100","24",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("10");
            this.div_info.addChild(obj.name, obj);

            obj = new CheckBox("ckb_withdraw","8","238","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("11");
            obj.set_text("퇴직");
            obj.set_truevalue("Y");
            obj.set_falsevalue("N");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            obj.set_padding("0px");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_mail","8","276","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("12");
            obj.set_text("메일");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_email","76","282","289","23",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("13");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_dept","201","47","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("14");
            obj.set_text("부서");
            obj.set_background("");
            obj.set_padding("");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_team","201","85","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("15");
            obj.set_text("팀");
            obj.set_background("");
            obj.set_padding("");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_pos","201","123","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("16");
            obj.set_text("직급");
            obj.set_background("");
            obj.set_padding("");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_b_email","76","320","289","23",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("17");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_b_mail","8","314","58","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("18");
            obj.set_text("사내 메일");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_address","76","358","293","56",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("19");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_address","8","358","58","66",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("20");
            obj.set_text("주소");
            obj.set_background("");
            obj.set_padding("0px");
            obj.set_cssclass("sta_WF_table_required");
            obj.set_border("0px none,1px solid #c9c9c9,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Button("btn_reset",null,"8","25","25","10",null,null,null,null,null,this.div_info.form);
            obj.set_taborder("23");
            obj.set_text("");
            obj.set_cssclass("btn_WF_reset01");
            this.div_info.addChild(obj.name, obj);

            obj = new Button("btn_del",null,"8","55","24","btn_reset:10",null,null,null,null,null,this.div_info.form);
            obj.set_taborder("32");
            obj.set_text("삭제");
            obj.set_cssclass("btn_WF_delete01");
            this.div_info.addChild(obj.name, obj);

            obj = new Button("btn_add",null,"8","55","24","btn_del:10",null,null,null,null,null,this.div_info.form);
            obj.set_taborder("21");
            obj.set_text("추가");
            obj.set_cssclass("btn_WF_add01");
            this.div_info.addChild(obj.name, obj);

            obj = new CheckBox("chk_notaem","224","86","56","34",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("22");
            obj.set_text("무소속");
            obj.set_font("normal 8px/normal \"Arial\"");
            obj.set_border("0px none,1px solid #c7c7c7,0px none,0px none");
            obj.set_padding("0px 3px 0px 0px");
            this.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_password","76","129","100","24",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("24");
            obj.set_type("string");
            obj.set_enable("false");
            obj.set_visible("false");
            this.div_info.addChild(obj.name, obj);

            obj = new Edit("edt_name","76","91","100","24",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("25");
            obj.getSetter("onclick").set("div_info_edt_name_onclick");
            this.div_info.addChild(obj.name, obj);

            obj = new Combo("cmb_dept","270","53","100","25",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("26");
            obj.set_innerdataset("ds_departments");
            obj.set_datacolumn("name");
            obj.set_codecolumn("code");
            obj.set_text("Combo00");
            obj.set_index("-1");
            this.div_info.addChild(obj.name, obj);

            obj = new Combo("cmb_team","285","92","85","22",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("27");
            obj.set_innerdataset("ds_team");
            obj.set_datacolumn("name");
            obj.set_codecolumn("code");
            obj.set_text("Combo00");
            this.div_info.addChild(obj.name, obj);

            obj = new Radio("rad_gender","76","169","100","20",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("28");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("2");
            var div_info_form_rad_gender_innerdataset = new nexacro.NormalDataset("div_info_form_rad_gender_innerdataset", obj);
            div_info_form_rad_gender_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">M</Col><Col id=\"datacolumn\">남</Col></Row><Row><Col id=\"codecolumn\">W</Col><Col id=\"datacolumn\">여</Col></Row></Rows>");
            obj.set_innerdataset(div_info_form_rad_gender_innerdataset);
            this.div_info.addChild(obj.name, obj);

            obj = new Calendar("cal_hire_date","76","204","100","26",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("29");
            this.div_info.addChild(obj.name, obj);

            obj = new Calendar("cal_withdraw_date","76","242","100","26",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("30");
            obj.set_enable("false");
            this.div_info.addChild(obj.name, obj);

            obj = new MaskEdit("msk_code","76","53","100","25",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("31");
            obj.set_format("######");
            obj.set_enable("false");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line","10","46","369","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("33");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00","10","84","369","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("34");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00_00","10","160","369","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("36");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00","10","122","369","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("35");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00_00_00","10","198","369","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("37");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00_00_00_00","66","236","313","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("38");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00_00_00_00_00","10","274","369","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("39");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_line00_00_00_00_00_00_00","10","312","369","8",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("40");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7,0px none,0px none");
            this.div_info.addChild(obj.name, obj);

            obj = new Static("sta_subtitle","0","0",null,"34","299",null,null,null,null,null,this.div_info.form);
            obj.set_taborder("41");
            obj.set_text("사원 정보");
            obj.set_cssclass("sta_WF_title01");
            this.div_info.addChild(obj.name, obj);

            obj = new Combo("cmb_pos","270","128","100","25",null,null,null,null,null,null,this.div_info.form);
            obj.set_taborder("42");
            obj.set_innerdataset("ds_position");
            obj.set_codecolumn("code");
            obj.set_datacolumn("name");
            obj.set_text("Combo00");
            this.div_info.addChild(obj.name, obj);

            obj = new Div("div_search","20","100",null,"50","100",null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("");
            obj.set_border("1px solid #c7c7c7");
            obj.set_background("#eeeeee");
            obj.set_formscrolltype("none");
            obj.set_formscrollbartype("none");
            this.addChild(obj.name, obj);

            obj = new Static("Static00_00","407","11","19","26",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("0");
            obj.set_text("팀");
            obj.getSetter("leftbase").set("");
            obj.getSetter("topbase").set("");
            obj.getSetter("bottombase").set("");
            obj.getSetter("rightbase").set("");
            obj.getSetter("widthbase").set("");
            obj.getSetter("heightbase").set("");
            this.div_search.addChild(obj.name, obj);

            obj = new Static("Static00_00_00","546","12","28","24",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("1");
            obj.set_text("직급");
            obj.getSetter("leftbase").set("");
            obj.getSetter("topbase").set("");
            obj.getSetter("bottombase").set("");
            obj.getSetter("rightbase").set("");
            obj.getSetter("widthbase").set("");
            obj.getSetter("heightbase").set("");
            this.div_search.addChild(obj.name, obj);

            obj = new Edit("edt_search","138","12","100","25",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("2");
            this.div_search.addChild(obj.name, obj);

            obj = new Static("Static00_00_01","257","11","30","26",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("3");
            obj.set_text("부서");
            obj.getSetter("leftbase").set("");
            obj.getSetter("topbase").set("");
            obj.getSetter("bottombase").set("");
            obj.getSetter("rightbase").set("");
            obj.getSetter("widthbase").set("");
            obj.getSetter("heightbase").set("");
            this.div_search.addChild(obj.name, obj);

            obj = new Button("btn_searchReset",null,"11","25","25","10",null,null,null,null,null,this.div_search.form);
            obj.set_taborder("6");
            obj.set_text("");
            obj.set_cssclass("btn_WF_reset01");
            this.div_search.addChild(obj.name, obj);

            obj = new Button("btn_search",null,"11","60","24","btn_searchReset:10",null,null,null,null,null,this.div_search.form);
            obj.set_taborder("4");
            obj.set_text("검색");
            obj.set_cssclass("btn_WF_search01");
            this.div_search.addChild(obj.name, obj);

            obj = new Radio("rdo_search","13","11","152","26",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("5");
            obj.set_codecolumn("codecolumn");
            obj.set_datacolumn("datacolumn");
            obj.set_columncount("2");
            var div_search_form_rdo_search_innerdataset = new nexacro.NormalDataset("div_search_form_rdo_search_innerdataset", obj);
            div_search_form_rdo_search_innerdataset._setContents("<ColumnInfo><Column id=\"codecolumn\" size=\"256\"/><Column id=\"datacolumn\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"codecolumn\">code</Col><Col id=\"datacolumn\">사원번호</Col></Row><Row><Col id=\"codecolumn\">name</Col><Col id=\"datacolumn\">이름</Col></Row></Rows>");
            obj.set_innerdataset(div_search_form_rdo_search_innerdataset);
            obj.set_text("");
            obj.set_value("code");
            obj.set_index("-1");
            this.div_search.addChild(obj.name, obj);

            obj = new Combo("cmb_searchDept","289","12","100","25",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("7");
            obj.set_innerdataset("ds_departments");
            obj.set_datacolumn("name");
            obj.set_codecolumn("code");
            obj.set_text("");
            obj.set_value("");
            this.div_search.addChild(obj.name, obj);

            obj = new Combo("cmb_searchTeam","436","12","100","25",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("8");
            obj.set_innerdataset("ds_team");
            obj.set_datacolumn("name");
            obj.set_codecolumn("code");
            obj.set_text("");
            obj.set_value("");
            this.div_search.addChild(obj.name, obj);

            obj = new Combo("cmb_pos","584","12","100","25",null,null,null,null,null,null,this.div_search.form);
            obj.set_taborder("9");
            obj.set_innerdataset("ds_position");
            obj.set_datacolumn("name");
            obj.set_codecolumn("code");
            obj.set_text("");
            obj.set_value("");
            this.div_search.addChild(obj.name, obj);

            obj = new Button("btn_save",null,"55","53","35","190",null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_text("저장");
            obj.set_cssclass("btn_WF_save01");
            this.addChild(obj.name, obj);

            obj = new Button("btn_cancel",null,"55","80","35","100",null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("작업 취소");
            obj.set_cssclass("btn_WF_delete01");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","230","8","563","78",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_text("팀 무소속 바인딩 안됨 : \r\n0일때 체크, 그 외에 체크 안되야 하는데 반대로...ㅠㅠㅠ\r\n퇴직날짜, 연봉 컬럼 추가 안됨: 했다가 어디서 오류날까봐 무섭네요. \r\n그냥 뺄까요");
            obj.set_background("#fcd3f2");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            this.addLayout(obj.name, obj);
            
            // BindItem Information
            obj = new BindItem("item3","div_info.form.msk_salary","value","ds_emp","SALARY");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item5","div_search.form.rdo_search","value","ds_emp","GENDER");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item16","div_info.form.edt_phone","value","ds_employee","phone");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item17","div_info.form.edt_email","value","ds_employee","email");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item18","div_info.form.edt_b_email","value","ds_employee","b_email");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item19","div_info.form.edt_address","value","ds_employee","address");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item20","div_info.form.edt_office_phone","value","ds_employee","office_phone");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item0","div_info.form.edt_name","value","ds_employee","name");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item6","div_info.form.cmb_dept","value","ds_employee","dept_code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item7","div_info.form.rad_gender","value","ds_employee","gender");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item2","div_info.form.cal_hire_date","value","ds_employee","hire_date");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item1","div_info.form.msk_code","value","ds_employee","code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item4","div_info.form.ckb_withdraw","value","ds_employee","withdraw");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item8","div_info.form.cmb_team","value","ds_employee","team_code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item9","div_info.form.chk_notaem","value","ds_employee","team_code");
            this.addChild(obj.name, obj);
            obj.bind();

            obj = new BindItem("item10","div_info.form.cmb_pos","value","ds_employee","pos_code");
            this.addChild(obj.name, obj);
            obj.bind();
        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("M11_users.xfdl", function() {

        //=======콜백==========
        this.fn_callback = function(id, ErrCode, ErrMsg)
        {
        	trace(ErrMsg);
        }

        this.fn_empsave = function(resultAdd, resultModif)
        {

        	trace("resultAdd : ", nexacro.getApplication().resultAdd);
        	trace("resultModif : ", nexacro.getApplication().resultModif);
        }

        //트랜잭션 START ====================================================
        //불러오기
        this.M11_users_onload = function(obj,e)
        {
        	trace("M11 도착");
        				this.transaction(
        			"EmpList" //strSvcID
        			, "/nexEmployee/nexEmpList.nex" //strURL
        			, "" //strInDatasets Sds=Fds:U, A, N
        			, "ds_employee=out_emp_list ds_departments=out_dept_list ds_position=out_pos_list ds_team=out_team_list" //strOutDatasets - select Fds = Sds
        			, "" //strArgument
        			,  "fn_callback" //strCallbackFunc
        			);
        };

        //저장
        this.btn_save_onclick = function(obj,e)
        {
        	trace("M11 저장");


        	for(var i=0; i < this.ds_employee.rowcount; i++)
        	{
        		let rowType = this.ds_employee.getRowType(i);

        		let code = this.ds_employee.getColumn(i,"code");
        		let name = this.ds_employee.getColumn(i,"name");
        		let phone = this.ds_employee.getColumn(i,"phone");
        		let office_phone = this.ds_employee.getColumn(i,"office_phone");
        		let address = this.ds_employee.getColumn(i,"address");
        		let email = this.ds_employee.getColumn(i,"email");
        		let b_email = this.ds_employee.getColumn(i,"b_email");
        		let gender = this.ds_employee.getColumn(i,"gender");
        		let hire_date = this.ds_employee.getColumn(i,"hire_date");
        		let withdraw = this.ds_employee.getColumn(i,"withdraw");
        		let dept_code = this.ds_employee.getColumn(i,"dept_code");
        		let pos_code = this.ds_employee.getColumn(i,"pos_code");
        		//let team_code = this.ds_employee.getColumn(i,"team_code");


        		//2: 추가 4:수정
        		if(rowType==2){
        			if(name==null||phone==null||office_phone==null||address==null||email==null||b_email==null||gender==null||hire_date==null||dept_code==null||pos_code==null){
        				alert("추가된 사원의 정보가 누락되었습니다. 확인 후 다시 저장하십시오.");
        				this.ds_employee.set_rowposition(i);
        				return;
        			}
        		}else if (rowType==4){
        			trace("수정된 사원 이름 : ",name);
        			if(name==""||phone==""||office_phone==""||address==""||email==""||b_email==""||gender==""||hire_date==""||dept_code==""||pos_code==""){
        				alert("수정된 사원의 정보가 누락되었습니다. 확인 후 다시 저장하십시오.");
        				this.ds_employee.set_rowposition(i);
        				return;
        			}
        		}else{
        			this.transaction(
        				"empSave" //strSvcID
        				, "/nexEmployee/nexSave.nex" //strURL
        				, "in_ds_employee=ds_employee:U" //strInDatasets Sds=Fds:U, A, N
        				, "" //strOutDatasets - select Fds = Sds
        				, "" //strArgument
        				,  "fn_empsave" //strCallbackFunc
        			);
        		}
        	}
        };
        //취소
        this.btn_cancel_onclick = function(obj,e)
        {
        	let cancel = confirm("저장하지 않은 모든 작업이 삭제됩니다. 취소하시겠습니까?");
        	if(cancel){
        	//온로드 다시하기
        		trace("다시 온로드");
        		this.transaction(
        			"EmpList" //strSvcID
        			, "/nexEmployee/nexEmpList.nex" //strURL
        			, "" //strInDatasets Sds=Fds:U, A, N
        			, "ds_employee=out_emp_list ds_departments=out_dept_list ds_position=out_pos_list ds_team=out_team_list" //strOutDatasets - select Fds = Sds
        			, "" //strArgument
        			,  "fn_callback" //strCallbackFunc
        		);
        	}else{
        		return;
        	}
        };

        //트랜잭션 END====================================================


        //ds_employee 업데이트 START====================================================
        //사원추가
        this.div_info_btn_add_onclick = function(obj,e)
        {
        	let row = this.ds_employee.addRow();
        	this.ds_employee.setColumn(row, "withdraw", "N");
        };
        //행 제거(아직 디비에 저장 안됨 행만 가능)
        this.div_info_btn_del_onclick = function(obj,e)
        {
        	let row = this.grd_emp_list.currentrow;
        	let rowType = this.ds_employee.getRowType(row);
        	trace("삭제 전 로우타입 체크 : ",rowType);
        	if(rowType==2){
        		this.ds_employee.deleteRow(row);
        	}else{
        		alert("이미 저장된 사원정보는 삭제할 수 없습니다.");
        	}

        };
        //부서콤보제한
        this.div_info_cmb_dept_onitemchanged = function(obj,e)
        {
        	this.div_info.form.cmb_team.set_value(null);
        	let dept_code = this.div_info.form.cmb_dept.value;
        	if(dept_code!=-10){
        		this.ds_team.filter("dept_code == "+dept_code);
        	}
        };
        //팀 콤보 제한
        this.div_info_cmb_searchTeam_onitemchanged = function(obj,e)
        {
        	let team_code = this.div_info.form.cmb_team.value;
        	let row = this.ds_team.findRow("code",team_code);
        	let dept_code = this.ds_team.getColumn(row,"dept_code");
        	trace(dept_code);
        	this.div_info.form.cmb_dept.set_value(dept_code);
        };


        //퇴사 체크시 무든 수정입력 불가능&값지우기
        this.div_info_ckb_withdraw_onchanged = function(obj,e)
        {
        	let withdraw = obj.value;
        	if(withdraw=='Y'){
        		let check = confirm("퇴사한 사원의 이름을 제외한 개인정보는 모두 삭제됩니다. 계속하시겠습니까 ?");
        		if(check){
        			this.div_info.form.cmb_dept.set_enable(false);
        			this.div_info.form.edt_name.set_enable(false);
        			this.div_info.form.cmb_team.set_enable(false);
        			this.div_info.form.chk_notaem.set_enable(false);
        			//this.div_info.form.msk_password.set_enable(false);
        			this.div_info.form.cmb_pos.set_enable(false);
        			this.div_info.form.rad_gender.set_enable(false);
        			this.div_info.form.cal_hire_date.set_enable(false);
        			this.div_info.form.edt_phone.set_enable(false);
        			this.div_info.form.edt_office_phone.set_enable(false);
        			this.div_info.form.edt_email.set_enable(false);
        			this.div_info.form.edt_b_email.set_enable(false);
        			this.div_info.form.edt_address.set_enable(false);
        			//값 지우기
        			this.div_info.form.msk_password.set_value(null);
        			this.div_info.form.rad_gender.set_value(null);
        			this.div_info.form.msk_salary.set_value(null);
        			this.div_info.form.edt_phone.set_value(null);
        			this.div_info.form.edt_office_phone.set_value(null);
        			this.div_info.form.edt_email.set_value(null);
        			this.div_info.form.edt_b_email.set_value(null);
        			this.div_info.form.edt_address.set_value(null);
        		}else{
        			obj.set_value("N");
        			return;
        		}

        	}else{
        			this.div_info.form.cmb_dept.set_enable(true);
        			this.div_info.form.edt_name.set_enable(true);
        			this.div_info.form.cmb_team.set_enable(true);
        			this.div_info.form.chk_notaem.set_enable(true);
        			//this.div_info.form.msk_password.set_enable(true);
        			this.div_info.form.cmb_pos.set_enable(true);
        			this.div_info.form.rad_gender.set_enable(true);
        			this.div_info.form.cal_hire_date.set_enable(true);
        			this.div_info.form.edt_phone.set_enable(true);
        			this.div_info.form.edt_office_phone.set_enable(true);
        			this.div_info.form.edt_email.set_enable(true);
        			this.div_info.form.edt_b_email.set_enable(true);
        			this.div_info.form.edt_address.set_enable(true);
        	}
        };
        //팀 무소속 : 팀 선택 콤보 비활성화, 팀 값 null
        this.div_info_chk_notaem_onchanged = function(obj,e)
        {
        	let noteam = obj.value;
        	if(noteam){
        		this.div_info.form.cmb_team.set_value(null);
        		this.div_info.form.cmb_team.set_enable(false);
        	}
        };

        ////ds_employee 업데이트 END====================================================


        //검색 ==============================================================
        // Retrieve Button
        this.div_search_btn_search_onclick = function(obj,e)
        {
        	trace("검색 도착");
        	//선택 안할 경우 값 : all
        	let dept_code = this.div_search.form.cmb_searchDept.value;
        	let team_code = this.div_search.form.cmb_searchTeam.value;
        	let pos_code = this.div_search.form.cmb_pos.value;
        	let search = this.div_search.form.edt_search.value;
        	//code 혹은 name
        	let searchWhat = this.div_search.form.rdo_search.value;
        	if(this.ds_search.getRowCount()==0){
        		this.ds_search.addRow();
        	}
        	this.ds_search.setColumn(0, "dept_code", dept_code);
        	this.ds_search.setColumn(0, "team_code", team_code);
        	this.ds_search.setColumn(0, "pos_code", pos_code);
        	this.ds_search.setColumn(0, "search", search);
        	this.ds_search.setColumn(0, "searchWhat", searchWhat);

        	trace(this.ds_search.getColumn(0,"dept_code"));
        	trace(this.ds_search.getColumnInfo());

        	//
        	this.transaction(
        			"EmpSearch" //strSvcID
        			, "/nexEmployee/nexEmpSearch.nex" //strURL
        			, "in_ds_search=ds_search:A" //strInDatasets Sds=Fds:U, A, N
        			, "ds_employee=out_emp_list" //strOutDatasets - select Fds = Sds
        			, "" //strArgument
        			,  "fn_callback" //strCallbackFunc
        		);
        };

        //부서 선택시 팀 콤보 목록 재설정
        this.div_search_cmb_searchDept_onitemchanged = function(obj,e)
        {
        	this.setDeptCombo();
        };

        //팀 선택시 부서 콤보 재설정
        this.div_search_cmb_searchTeam_onitemchanged = function(obj,e)
        {
        	this.setTeamCombo();
        };
        //직급이 대표일 경우 부서, 팀 값 없애기
        this.div_search_cmb_pos_onitemchanged = function(obj,e)
        {
        	let pos_code = this.div_search.form.cmb_pos.value;
        	if(pos_code==1){
        		this.div_search.form.cmb_searchDept.set_value(null);
        		this.div_search.form.cmb_searchTeam.set_value(null);
        	}
        };

        //검색 초기화
        this.div_search_btn_searchReset_onclick = function(obj,e)
        {
        	this.div_search.form.cmb_searchDept.set_value(null);
        	this.div_search.form.cmb_searchTeam.set_value(null);
        	this.div_search.form.cmb_pos.set_value(null);
        	this.div_search.form.edt_search.set_value(null);
        };

        //검색 끝 ==============================================================



        //================================================================
        //부서콤보 제한
        this.setDeptCombo = function(){
        	this.div_search.form.cmb_searchTeam.set_value(null);
        	let dept_code = this.div_search.form.cmb_searchDept.value;
        	if(dept_code!=-10){
        		this.ds_team.filter("dept_code == "+dept_code);
        	}
        }
        //팀 콤보 제한
        this.setTeamCombo = function(){
        	let team_code = this.div_search.form.cmb_searchTeam.value;
        	let row = this.ds_team.findRow("code",team_code);
        	let dept_code = this.ds_team.getColumn(row,"dept_code");
        	trace(dept_code);
        	this.div_search.form.cmb_searchDept.set_value(dept_code);
        }
        //============================================

        //그리드 포커스 이동마다 퇴직인지 아닌지 체크 -> 인풋창들 활성화 or 비활성화
        this.grd_emp_list_oncellposchanged = function(obj,e)
        {
        	let row = obj.currentrow;
        	let withdraw = this.ds_employee.getColumn(row, "withdraw");
        	trace("셀포스 변경, withdraw 체크 : ",withdraw);
        	if(withdraw=="Y"){
        			this.div_info.form.cmb_dept.set_enable(false);
        			this.div_info.form.edt_name.set_enable(false);
        			this.div_info.form.cmb_team.set_enable(false);
        			this.div_info.form.chk_notaem.set_enable(false);
        			//this.div_info.form.msk_password.set_enable(false);
        			this.div_info.form.cmb_pos.set_enable(false);
        			this.div_info.form.rad_gender.set_enable(false);
        			this.div_info.form.cal_hire_date.set_enable(false);
        			this.div_info.form.edt_phone.set_enable(false);
        			this.div_info.form.edt_office_phone.set_enable(false);
        			this.div_info.form.edt_email.set_enable(false);
        			this.div_info.form.edt_b_email.set_enable(false);
        			this.div_info.form.edt_address.set_enable(false);
        	}else{
        			this.div_info.form.cmb_dept.set_enable(true);
        			this.div_info.form.edt_name.set_enable(true);
        			this.div_info.form.cmb_team.set_enable(true);
        			this.div_info.form.chk_notaem.set_enable(true);
        			//this.div_info.form.msk_password.set_enable(true);
        			this.div_info.form.cmb_pos.set_enable(true);
        			this.div_info.form.rad_gender.set_enable(true);
        			this.div_info.form.cal_hire_date.set_enable(true);
        			this.div_info.form.edt_phone.set_enable(true);
        			this.div_info.form.edt_office_phone.set_enable(true);
        			this.div_info.form.edt_email.set_enable(true);
        			this.div_info.form.edt_b_email.set_enable(true);
        			this.div_info.form.edt_address.set_enable(true);
        	}
        };



        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.M11_users_onload,this);
            this.grd_emp_list.addEventHandler("oncellposchanged",this.grd_emp_list_oncellposchanged,this);
            this.div_info.form.sta_name.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_salary.addEventHandler("onclick",this.div_detail_Static19_onclick,this);
            this.div_info.form.sta_code.addEventHandler("onclick",this.div_detail_Static00_onclick,this);
            this.div_info.form.sta_pass.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_phone.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_localphone.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.ckb_withdraw.addEventHandler("onchanged",this.div_info_ckb_withdraw_onchanged,this);
            this.div_info.form.sta_mail.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_dept.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_team.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_pos.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_b_mail.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.sta_address.addEventHandler("onclick",this.div_detail_Static10_onclick,this);
            this.div_info.form.btn_del.addEventHandler("onclick",this.div_info_btn_del_onclick,this);
            this.div_info.form.btn_add.addEventHandler("onclick",this.div_info_btn_add_onclick,this);
            this.div_info.form.chk_notaem.addEventHandler("onchanged",this.div_info_chk_notaem_onchanged,this);
            this.div_info.form.cmb_dept.addEventHandler("onitemchanged",this.div_info_cmb_dept_onitemchanged,this);
            this.div_info.form.cmb_team.addEventHandler("onitemchanged",this.div_info_cmb_searchTeam_onitemchanged,this);
            this.div_info.form.cmb_team.addEventHandler("onsetfocus",this.div_info_cmb_team_onsetfocus,this);
            this.div_search.form.btn_searchReset.addEventHandler("onclick",this.div_search_btn_searchReset_onclick,this);
            this.div_search.form.btn_search.addEventHandler("onclick",this.div_search_btn_search_onclick,this);
            this.div_search.form.rdo_search.addEventHandler("onitemchanged",this.Div00_rdo_gender_onitemchanged,this);
            this.div_search.form.cmb_searchDept.addEventHandler("onitemchanged",this.div_search_cmb_searchDept_onitemchanged,this);
            this.div_search.form.cmb_searchTeam.addEventHandler("onitemchanged",this.div_search_cmb_searchTeam_onitemchanged,this);
            this.div_search.form.cmb_pos.addEventHandler("onitemchanged",this.div_search_cmb_pos_onitemchanged,this);
            this.btn_save.addEventHandler("onclick",this.btn_save_onclick,this);
            this.btn_cancel.addEventHandler("onclick",this.btn_cancel_onclick,this);
            this.Static02.addEventHandler("onclick",this.Static02_onclick,this);
        };

        this.loadIncludeScript("M11_users.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
