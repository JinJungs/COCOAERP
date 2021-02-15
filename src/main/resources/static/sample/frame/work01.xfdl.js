(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("work01");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1090,650);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("ds_Employee", this);
            obj._setContents("<ColumnInfo><Column id=\"Check\" type=\"STRING\" size=\"256\"/><Column id=\"이름\" type=\"STRING\" size=\"256\"/><Column id=\"나이\" type=\"STRING\" size=\"256\"/><Column id=\"핸드폰\" type=\"STRING\" size=\"256\"/><Column id=\"집전화\" type=\"STRING\" size=\"256\"/><Column id=\"집주소\" type=\"STRING\" size=\"256\"/><Column id=\"집우편번호\" type=\"STRING\" size=\"256\"/><Column id=\"성별\" type=\"STRING\" size=\"256\"/><Column id=\"직장주소\" type=\"STRING\" size=\"256\"/><Column id=\"직장우편번호\" type=\"STRING\" size=\"256\"/><Column id=\"직장전화\" type=\"STRING\" size=\"256\"/><Column id=\"직급\" type=\"STRING\" size=\"256\"/><Column id=\"입사일\" type=\"STRING\" size=\"256\"/><Column id=\"퇴사일\" type=\"STRING\" size=\"256\"/><Column id=\"비고\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"이름\">서동천</Col><Col id=\"나이\">66</Col><Col id=\"핸드폰\">010-1111-1111</Col><Col id=\"집전화\">02-1111-1111</Col><Col id=\"집주소\">서울시 강북구 미아동</Col><Col id=\"집우편번호\">05321</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 강동구 성내동</Col><Col id=\"직장우편번호\">05312</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">수석컨설턴트</Col><Col id=\"입사일\">2003-03-04</Col></Row><Row><Col id=\"이름\">모태강</Col><Col id=\"나이\">51</Col><Col id=\"핸드폰\">010-2222-2222</Col><Col id=\"집전화\">02-2222-2222</Col><Col id=\"집주소\">서울시 강남구 청담동</Col><Col id=\"집우편번호\">05312</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 강동구 성내동</Col><Col id=\"직장우편번호\">05485</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">수석컨설턴트</Col><Col id=\"입사일\">2003-03-05</Col></Row><Row><Col id=\"이름\">김이경</Col><Col id=\"나이\">25</Col><Col id=\"핸드폰\">010-3333-3333</Col><Col id=\"집전화\">02-3333-3333</Col><Col id=\"집주소\">서울시 강북구 수유동</Col><Col id=\"집우편번호\">05485</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 강동구 성내동</Col><Col id=\"직장우편번호\">05893</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2003-04-05</Col></Row><Row><Col id=\"이름\">지서영</Col><Col id=\"나이\">48</Col><Col id=\"핸드폰\">010-4444-4444</Col><Col id=\"집전화\">02-4444-4444</Col><Col id=\"집주소\">서울시 강남구 대치동</Col><Col id=\"집우편번호\">05893</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 강동구 성내동</Col><Col id=\"직장우편번호\">06523</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2005-12-11</Col></Row><Row><Col id=\"이름\">공수래</Col><Col id=\"나이\">60</Col><Col id=\"핸드폰\">010-5555-5555</Col><Col id=\"집전화\">02-5555-5555</Col><Col id=\"집주소\">서울시 강동구 천호동</Col><Col id=\"집우편번호\">06523</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 강동구 성내동</Col><Col id=\"직장우편번호\">02183</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2005-12-12</Col></Row><Row><Col id=\"이름\">차요한</Col><Col id=\"나이\">42</Col><Col id=\"핸드폰\">010-6666-6666</Col><Col id=\"집전화\">02-6666-6666</Col><Col id=\"집주소\">서울시 강남구 역삼동</Col><Col id=\"집우편번호\">02183</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 강남구 논현동</Col><Col id=\"직장우편번호\">02854</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2007-01-03</Col></Row><Row><Col id=\"이름\">강시영</Col><Col id=\"나이\">28</Col><Col id=\"핸드폰\">010-7777-7777</Col><Col id=\"집전화\">02-7777-7777</Col><Col id=\"집주소\">서울시 강남구 논현동</Col><Col id=\"집우편번호\">02854</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 강남구 논현동</Col><Col id=\"직장우편번호\">05985</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2009-05-30</Col></Row><Row><Col id=\"이름\">손석기</Col><Col id=\"나이\">43</Col><Col id=\"핸드폰\">010-8888-8888</Col><Col id=\"집전화\">02-8888-8888</Col><Col id=\"집주소\">서울시 강서구 여의도동</Col><Col id=\"집우편번호\">05985</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 서초구 서초동</Col><Col id=\"직장우편번호\">05327</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2009-11-12</Col></Row><Row><Col id=\"이름\">이유준</Col><Col id=\"나이\">34</Col><Col id=\"핸드폰\">010-9999-9999</Col><Col id=\"집전화\">02-9999-9999</Col><Col id=\"집주소\">서울시 강남구 논현동</Col><Col id=\"집우편번호\">05327</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 강남구 논현동</Col><Col id=\"직장우편번호\">05123</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2009-12-05</Col></Row><Row><Col id=\"이름\">강미래</Col><Col id=\"나이\">28</Col><Col id=\"핸드폰\">010-1111-2222</Col><Col id=\"집전화\">02-1111-2222</Col><Col id=\"집주소\">서울시 강남구 논현동</Col><Col id=\"집우편번호\">05123</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 강남구 논현동</Col><Col id=\"직장우편번호\">05952</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">선임컨설턴트</Col><Col id=\"입사일\">2010-01-22</Col></Row><Row><Col id=\"이름\">장만월</Col><Col id=\"나이\">30</Col><Col id=\"핸드폰\">010-3333-4444</Col><Col id=\"집전화\">02-3333-4444</Col><Col id=\"집주소\">서울시 중구 명동</Col><Col id=\"집우편번호\">05952</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 중구 명동</Col><Col id=\"직장우편번호\">05423</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">수석컨설턴트</Col><Col id=\"입사일\">2010-10-01</Col></Row><Row><Col id=\"이름\">구찬성</Col><Col id=\"나이\">30</Col><Col id=\"핸드폰\">010-5555-6666</Col><Col id=\"집전화\">02-5555-6666</Col><Col id=\"집주소\">서울시 강남구 개포동</Col><Col id=\"집우편번호\">05423</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 중구 명동</Col><Col id=\"직장우편번호\">04235</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">수석컨설턴트</Col><Col id=\"입사일\">2015-01-01</Col></Row><Row><Col id=\"이름\">산체스</Col><Col id=\"나이\">33</Col><Col id=\"핸드폰\">010-7777-8888</Col><Col id=\"집전화\">02-7777-8888</Col><Col id=\"집주소\">서울시 강남구 일원동</Col><Col id=\"집우편번호\">04235</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 강남구 삼성동</Col><Col id=\"직장우편번호\">05243</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2017-06-30</Col></Row><Row><Col id=\"이름\">지현중</Col><Col id=\"나이\">18</Col><Col id=\"핸드폰\">010-9999-0000</Col><Col id=\"집전화\">02-9999-0000</Col><Col id=\"집주소\">서울시 중구 명동</Col><Col id=\"집우편번호\">05243</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 중구 명동</Col><Col id=\"직장우편번호\">05886</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">책임컨설턴트</Col><Col id=\"입사일\">2017-08-20</Col></Row><Row><Col id=\"이름\">이재상</Col><Col id=\"나이\">37</Col><Col id=\"핸드폰\">010-0000-1111</Col><Col id=\"집전화\">02-0000-1111</Col><Col id=\"집주소\">서울시 강남구 도곡동</Col><Col id=\"집우편번호\">05886</Col><Col id=\"성별\">남</Col><Col id=\"직장주소\">서울시 서초구 서초동</Col><Col id=\"직장우편번호\">05412</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">선임컨설턴트</Col><Col id=\"입사일\">2019-02-01</Col></Row><Row><Col id=\"이름\">라시온</Col><Col id=\"나이\">33</Col><Col id=\"핸드폰\">010-2222-3333</Col><Col id=\"집전화\">02-2222-3333</Col><Col id=\"집주소\">서울시 강동구 명일동</Col><Col id=\"집우편번호\">05932</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 서초구 서초동</Col><Col id=\"직장우편번호\">05796</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">선임컨설턴트</Col><Col id=\"입사일\">2019-09-01</Col></Row><Row><Col id=\"이름\">제니장</Col><Col id=\"나이\">44</Col><Col id=\"핸드폰\">010-4444-5555</Col><Col id=\"집전화\">02-4444-5555</Col><Col id=\"집주소\">서울시 강남구 도곡동</Col><Col id=\"집우편번호\">05886</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 서초구 서초동</Col><Col id=\"직장우편번호\">05412</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">대표</Col><Col id=\"입사일\">2001-01-01</Col></Row><Row><Col id=\"이름\">김여옥</Col><Col id=\"나이\">58</Col><Col id=\"핸드폰\">010-6666-7777</Col><Col id=\"집전화\">02-6666-7777</Col><Col id=\"집주소\">서울시 강남구 도곡동</Col><Col id=\"집우편번호\">05886</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 서초구 서초동</Col><Col id=\"직장우편번호\">05412</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">회장</Col><Col id=\"입사일\">2001-01-01</Col></Row><Row><Col id=\"이름\">위예남</Col><Col id=\"나이\">35</Col><Col id=\"핸드폰\">010-8888-9999</Col><Col id=\"집전화\">02-8888-9999</Col><Col id=\"집주소\">서울시 강남구 개포동</Col><Col id=\"집우편번호\">05886</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 강남구 삼성동</Col><Col id=\"직장우편번호\">05243</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">전무</Col><Col id=\"입사일\">2001-01-01</Col></Row><Row><Col id=\"이름\">이현지</Col><Col id=\"나이\">30</Col><Col id=\"핸드폰\">010-1111-0000</Col><Col id=\"집전화\">02-1111-0000</Col><Col id=\"집주소\">서울시 강남구 논현동</Col><Col id=\"집우편번호\">05886</Col><Col id=\"성별\">여</Col><Col id=\"직장주소\">서울시 강남구 삼성동</Col><Col id=\"직장우편번호\">05243</Col><Col id=\"직장전화\">02-1234-5678</Col><Col id=\"직급\">이사</Col><Col id=\"입사일\">2001-01-01</Col></Row></Rows>");
            this.addChild(obj.name, obj);


            obj = new Dataset("ds_Gender", this);
            obj._setContents("<ColumnInfo><Column id=\"Column0\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"Column0\">여성</Col></Row><Row><Col id=\"Column0\">남성</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","0","0",null,"34","10",null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("테스트입니다");
            obj.set_cssclass("sta_WF_title01");
            this.addChild(obj.name, obj);

            obj = new Static("Static20",null,"0","263","34","10",null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_text("· Home > Middle title > navi");
            obj.set_cssclass("sta_WF_navi");
            this.addChild(obj.name, obj);

            obj = new Tab("Tab00","0","44","530","510",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_tabindex("0");
            this.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage1",this.Tab00);
            obj.set_text("Tabpage1");
            this.Tab00.addChild(obj.name, obj);

            obj = new Grid("Grid00","10","10",null,null,"10","49",null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("0");
            obj.set_binddataset("ds_Employee");
            obj.set_autofittype("col");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"43\"/><Column size=\"80\"/><Column size=\"158\"/><Column size=\"65\"/><Column size=\"135\"/></Columns><Rows><Row size=\"24\" band=\"head\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"Check\"/><Cell col=\"1\" text=\"이름\"/><Cell col=\"2\" text=\"핸드폰\"/><Cell col=\"3\" text=\"성별\"/><Cell col=\"4\" text=\"직급\"/></Band><Band id=\"body\"><Cell text=\"bind:Check\" displaytype=\"checkboxcontrol\"/><Cell col=\"1\" text=\"bind:이름\"/><Cell col=\"2\" text=\"bind:핸드폰\"/><Cell col=\"3\" text=\"bind:성별\"/><Cell col=\"4\" text=\"bind:직급\"/></Band></Format></Formats>");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Button("Button00","127",null,"120","30",null,"13",null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("1");
            obj.set_text("Button00");
            obj.set_cssclass("btn_cm_basic01");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Button("Button01","257",null,"120","30",null,"13",null,null,null,null,this.Tab00.Tabpage1.form);
            obj.set_taborder("2");
            obj.set_text("Button01");
            obj.set_cssclass("btn_cm_basic02");
            this.Tab00.Tabpage1.addChild(obj.name, obj);

            obj = new Tabpage("Tabpage2",this.Tab00);
            obj.set_text("Tabpage2");
            this.Tab00.addChild(obj.name, obj);

            obj = new Button("Button00","540","210","30","60",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_cssclass("btn_WF_pagingNext");
            this.addChild(obj.name, obj);

            obj = new Button("Button01","540","290","30","60",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_cssclass("btn_WF_pagingPrev");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","580","44","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static08","689","44",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static02","580","75","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static03","689","75",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static04","580","106","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("9");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static05","689","106",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("10");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static06","580","137","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("11");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static07","689","137",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("12");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static09","580","168","110","93",null,null,null,null,null,null,this);
            obj.set_taborder("13");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static10","689","168",null,"93","10",null,null,null,null,null,this);
            obj.set_taborder("14");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static11","580","260","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("15");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static12","689","260",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("16");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static13","580","291","110","93",null,null,null,null,null,null,this);
            obj.set_taborder("17");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static14","689","291",null,"93","10",null,null,null,null,null,this);
            obj.set_taborder("18");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static15","580","383","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("19");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static16","689","383",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("20");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static17","580","414","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("21");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static18","689","414",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("22");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static19","580","445","110","32",null,null,null,null,null,null,this);
            obj.set_taborder("23");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static21","689","445",null,"32","10",null,null,null,null,null,this);
            obj.set_taborder("24");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Static("Static22","580","476","110","78",null,null,null,null,null,null,this);
            obj.set_taborder("25");
            obj.set_text("Label");
            obj.set_cssclass("sta_cm_box01R");
            this.addChild(obj.name, obj);

            obj = new Static("Static23","689","476",null,"78","10",null,null,null,null,null,this);
            obj.set_taborder("26");
            obj.set_cssclass("sta_cm_box02L");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00","694","48","199","25",null,null,null,null,null,null,this);
            obj.set_taborder("27");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit01","694","79","199","25",null,null,null,null,null,null,this);
            obj.set_taborder("28");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00","694","110","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("29");
            obj.set_text("010");
            obj.set_value("");
            obj.set_index("-1");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit02","769","110","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("30");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit03","844","110","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("31");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo01","694","141","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("32");
            obj.set_text("010");
            obj.set_value("");
            obj.set_index("-1");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit04","769","141","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("33");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit05","844","141","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("34");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit00","694","172","145","25",null,null,null,null,null,null,this);
            obj.set_taborder("35");
            this.addChild(obj.name, obj);

            obj = new Button("Button02","844","172","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("36");
            obj.set_text("우편번호");
            obj.set_cssclass("btn_cm_basic01");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit09","694","202","370","25",null,null,null,null,null,null,this);
            obj.set_taborder("37");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit010","694","230","370","25",null,null,null,null,null,null,this);
            obj.set_taborder("38");
            this.addChild(obj.name, obj);

            obj = new Radio("Radio00","694","264","199","25",null,null,null,null,null,null,this);
            obj.set_taborder("39");
            obj.set_innerdataset("ds_Gender");
            obj.set_codecolumn("Column0");
            obj.set_datacolumn("Column0");
            obj.set_direction("vertical");
            this.addChild(obj.name, obj);

            obj = new MaskEdit("MaskEdit04","694","296","145","25",null,null,null,null,null,null,this);
            obj.set_taborder("40");
            this.addChild(obj.name, obj);

            obj = new Button("Button03","844","296","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("41");
            obj.set_text("우편번호");
            obj.set_cssclass("btn_cm_basic01");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit11","694","326","370","25",null,null,null,null,null,null,this);
            obj.set_taborder("42");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit12","694","354","370","25",null,null,null,null,null,null,this);
            obj.set_taborder("43");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo02","694","387","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("44");
            obj.set_text("010");
            obj.set_value("");
            obj.set_index("-1");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit06","769","387","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("45");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit07","844","387","70","25",null,null,null,null,null,null,this);
            obj.set_taborder("46");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit08","694","418","199","25",null,null,null,null,null,null,this);
            obj.set_taborder("47");
            this.addChild(obj.name, obj);

            obj = new CheckBox("CheckBox00","902","418","149","25",null,null,null,null,null,null,this);
            obj.set_taborder("48");
            obj.set_text("저장");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00","694","449","119","25",null,null,null,null,null,null,this);
            obj.set_taborder("49");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar01","830","449","119","25",null,null,null,null,null,null,this);
            obj.set_taborder("50");
            this.addChild(obj.name, obj);

            obj = new Static("Static24","818","449","9","25",null,null,null,null,null,null,this);
            obj.set_taborder("51");
            obj.set_text("~");
            this.addChild(obj.name, obj);

            obj = new TextArea("TextArea00","694","481","370","68",null,null,null,null,null,null,this);
            obj.set_taborder("52");
            this.addChild(obj.name, obj);

            obj = new Button("Button05","506","44","25","25",null,null,null,null,null,null,this);
            obj.set_taborder("53");
            obj.set_cssclass("btn_WF_delete01");
            this.addChild(obj.name, obj);

            obj = new Button("Button06","478","44","25","25",null,null,null,null,null,null,this);
            obj.set_taborder("54");
            obj.set_cssclass("btn_WF_add01");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1090,650,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("work01.xfdl", function() {
        this.work01_oninit = function(obj,e)
        {
        	var strColID = this.ds_Employee.getColID(1);
        	this.Static01.set_text(strColID);

        	strColID = this.ds_Employee.getColID(2);
        	this.Static02.set_text(strColID);

        	strColID = this.ds_Employee.getColID(3);
        	this.Static04.set_text(strColID);

        	strColID = this.ds_Employee.getColID(4);
        	this.Static06.set_text(strColID);

        	strColID = this.ds_Employee.getColID(5);
        	this.Static09.set_text(strColID);

        	strColID = this.ds_Employee.getColID(7);
        	this.Static11.set_text(strColID);

        	strColID = this.ds_Employee.getColID(8);
        	this.Static13.set_text(strColID);

        	strColID = this.ds_Employee.getColID(10);
        	this.Static15.set_text(strColID);

        	strColID = this.ds_Employee.getColID(11);
        	this.Static17.set_text(strColID);

        	//strColID = this.ds_Employee.getColID(12);
        	this.Static19.set_text("근무기간");

        	strColID = this.ds_Employee.getColID(14);
        	this.Static22.set_text(strColID);
        };

        this.Button00_onclick = function(obj,e)
        {
        	var aDSRowidx = this.Tab00.Tabpage1.form.Grid00.getSelectedDatasetRows();
        	var nDatasetRow = aDSRowidx[0];

        	var sName 		= this.ds_Employee.getColumn(nDatasetRow, 1);
        	this.Edit00.set_value(sName);

        	var sAge 		= this.ds_Employee.getColumn(nDatasetRow, 2);
        	this.Edit01.set_value(sAge);

        	var sCellPhone 	= this.ds_Employee.getColumn(nDatasetRow, 3);
        	var sArray = sCellPhone.split('-');
        	this.Combo00.set_text(sArray[0]);
        	this.Edit02.set_value(sArray[1]);
        	this.Edit03.set_value(sArray[2]);

        	var sHomePhone 	= this.ds_Employee.getColumn(nDatasetRow, 4);
        	sArray = sHomePhone.split('-');
        	this.Combo01.set_text(sArray[0]);
        	this.Edit04.set_value(sArray[1]);
        	this.Edit05.set_value(sArray[2]);

        	var sHomeAddress = this.ds_Employee.getColumn(nDatasetRow, 5);
        	var sHomeZipcode = this.ds_Employee.getColumn(nDatasetRow, 6);
        	this.Edit09.set_value(sHomeAddress);
        	this.MaskEdit00.set_value(sHomeZipcode);

        	var sGender 	= this.ds_Employee.getColumn(nDatasetRow, 7);
        	var sGender = (sGender == "남") ? "남성" : "여성";
        	this.Radio00.set_value(sGender);

        	var sOfficeAddress = this.ds_Employee.getColumn(nDatasetRow, 8);
        	var sOfficeZipcode = this.ds_Employee.getColumn(nDatasetRow, 9);
        	this.Edit11.set_value(sOfficeAddress);
        	this.MaskEdit04.set_value(sOfficeZipcode);

        	var sOfficePhone = this.ds_Employee.getColumn(nDatasetRow, 10);
        	sArray = sOfficePhone.split('-');
        	this.Combo02.set_value(sArray[0]);
        	this.Edit06.set_value(sArray[1]);
        	this.Edit07.set_value(sArray[2]);

        	var sPosition 	= this.ds_Employee.getColumn(nDatasetRow, 11);
        	this.Edit08.set_value(sPosition);

        	var sStartDate 	= this.ds_Employee.getColumn(nDatasetRow, 12);
        	var sEndDate 	= this.ds_Employee.getColumn(nDatasetRow, 13);
        	if (isNaN(sEndDate))
        	{
        		var date = new Date();
        		var year = date.getFullYear();
        		var month = new String(date.getMonth()+1);
        		var day = new String(date.getDate());

        		// 한자리수일 경우 0을 채워준다.
        		if(month.length == 1){
        		  month = "0" + month;
        		}
        		if(day.length == 1){
        		  day = "0" + day;
        		}

        		sEndDate = (year + "" + month + "" + day);
        	}
        	this.Calendar00.set_value(sStartDate);
        	this.Calendar01.set_value(sEndDate);

        	var sEtc 		= this.ds_Employee.getColumn(nDatasetRow, 14);
        	this.TextArea00.set_value(sEtc);
        };

        // add row
        this.Button06_onclick = function(obj,e)
        {
        	var nRow = this.ds_Employee.addRow();
        };

        // delete row
        this.Button05_onclick = function(obj,e)
        {
        	var aDSRowidx = this.Tab00.Tabpage1.form.Grid00.getSelectedDatasetRows();
        	this.ds_Employee.deleteRow(aDSRowidx[0]);
        };

        this.Static00_onclick = function(obj,e)
        {

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("oninit",this.work01_oninit,this);
            this.Static00.addEventHandler("onclick",this.Static00_onclick,this);
            this.Button00.addEventHandler("onclick",this.Button00_onclick,this);
            this.Button05.addEventHandler("onclick",this.Button05_onclick,this);
            this.Button06.addEventHandler("onclick",this.Button06_onclick,this);
        };

        this.loadIncludeScript("work01.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
