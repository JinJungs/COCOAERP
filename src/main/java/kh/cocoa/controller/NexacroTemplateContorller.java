package kh.cocoa.controller;


import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import kh.cocoa.dto.EmployeeDTO;
import kh.cocoa.dto.TemplateFormDTO;
import kh.cocoa.dto.TemplatesDTO;
import kh.cocoa.service.EmployeeService;
import kh.cocoa.service.TemplateFormService;
import kh.cocoa.service.TemplatesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/nexTemp")
public class NexacroTemplateContorller {

    @Autowired
    TemplatesService templatesService;

    @Autowired
    TemplateFormService templateFormService;

    @Autowired
    EmployeeService employeeService;

    @Autowired
    private HttpSession session;

    @RequestMapping("/formLoad.nex")
    public NexacroResult formLoad(){
        System.out.println("폼로드 도착");
        /*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");*/
        int emp_code = 1000;
        EmployeeDTO dto = employeeService.getEmpInfo(emp_code);
        HashMap<String,Object> map = new HashMap<>();
        map.put("code",dto.getCode());
        map.put("name",dto.getName());
        map.put("team_name",dto.getTeamname());
        map.put("dept_name",dto.getDeptname());
        map.put("pos_name",dto.getPosname());
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",map);
        //오리진 템플릿 리스트
        List<TemplatesDTO> list = templatesService.getTemplateList2();
        nr.addDataSet("out_origin",list);
        //폼 리스트
        List<TemplateFormDTO> formList = templateFormService.getTempleateFormList();
        nr.addDataSet("out_title",formList);
        return nr;
    }

    @RequestMapping("/ds_user.nex")
    public NexacroResult ds_user(){
        /*EmployeeDTO loginDTO = (EmployeeDTO)session.getAttribute("loginDTO");*/
        int emp_code = 1000;
        EmployeeDTO dto = employeeService.getEmpInfo(emp_code);
        HashMap<String,Object> map = new HashMap<>();
        map.put("code",dto.getCode());
        map.put("name",dto.getName());
        map.put("team_name",dto.getTeamname());
        map.put("dept_name",dto.getDeptname());
        map.put("pos_name",dto.getPosname());
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",map);
        return nr;
    }

    @RequestMapping("/tp_list.nex")
    public NexacroResult tp_list(){
        System.out.println("요청 도착");
        NexacroResult nr = new NexacroResult();
        List<TemplatesDTO> list = templatesService.getTemplateList2();
        nr.addDataSet("out_ds",list);
        return nr;
    }


    @RequestMapping("/onclick_tp_title.nex")
    public NexacroResult onclick_tp_title(@ParamVariable(name="code") int code){
        System.out.println(code);
        List<TemplatesDTO> getClickTemplateList=templatesService.getClickTemplateList(code);
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",getClickTemplateList);
        return nr;
    }

    @RequestMapping("/tp_titleRm.nex")
    public NexacroResult tp_titleRm(@ParamDataSet(name="in_ds") TemplateFormDTO dto){
        System.out.println(dto);
        int result = templateFormService.delTemplateForm(dto.getCode());
        NexacroResult nr = new NexacroResult();
        return nr;
    }

    @RequestMapping("/tp_titleAdd.nex")
    public NexacroResult tp_titleAdd(@ParamVariable(name="title")String title, @ParamVariable(name="contents")String contents){
        TemplateFormDTO dto = new TemplateFormDTO().builder().title(title).contents(contents).build();
        int result = templateFormService.addTemplateForm(dto);
        return new NexacroResult();
    }

    @RequestMapping("/tp_titleMod.nex")
    public NexacroResult tp_titleMod(@ParamDataSet(name="in_ds") TemplateFormDTO dto){
        System.out.println(dto);
        int result = templateFormService.modTemlateForm(dto);
        System.out.println(dto);
        return new NexacroResult();
    }

    @RequestMapping("/addList_onclick.nex")
    public NexacroResult addList_onclick(@ParamDataSet(name="in_ds")TemplatesDTO dto){
        System.out.println(dto);
        int result = templatesService.addTemplates(dto);
        List<TemplatesDTO> list = templatesService.getClickTemplateList(dto.getForm_code());
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",list);
        return nr;
    }

    @RequestMapping("/modList_onclick.nex")
    public NexacroResult modList_onclick(@ParamDataSet(name="in_ds")TemplatesDTO dto,
                                         @ParamVariable(name="form_code")int form_code)
    {
        System.out.println(dto);
        if(dto.getCode()==0){
            List<TemplatesDTO> list = templatesService.getClickTemplateList(form_code);
            NexacroResult nr = new NexacroResult();
            nr.addDataSet("out_ds",list);
            return nr;
        }
        int result = templatesService.modTemplates(dto);
        List<TemplatesDTO> list = templatesService.getClickTemplateList(dto.getForm_code());
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",list);
        return nr;
    }

    @RequestMapping("/delList.nex")
    public NexacroResult delList(@ParamDataSet(name="in_ds")TemplatesDTO dto){
        System.out.println(dto);
        int result = templatesService.delTemplate(dto.getCode());
        List<TemplatesDTO> list = templatesService.getClickTemplateList(dto.getForm_code());
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",list);
        return nr;

    }

    @RequestMapping("/searchList.nex")
    public NexacroResult searchList(@ParamVariable(name="getSearch")String getSearch,
                                    @ParamVariable(name="form_code")int form_code){
        List<TemplatesDTO> list = templatesService.searchList(getSearch,form_code);
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",list);
        return nr;
    }

    @RequestMapping("/tp_getFormInfoByCode.nex")
    public NexacroResult tp_getFormInfoByCode(@ParamVariable(name="code")int code) {
        TemplateFormDTO dto = templateFormService.getFormInfoByCode(code);
        dto.setMade_date(dto.getMade_date().substring(0,10));
        if(dto.getMod_date()!=null) {
            dto.setMod_date(dto.getMod_date().substring(0, 10));
        }
            NexacroResult nr =  new NexacroResult();
            nr.addDataSet("out_ds",dto);
            return nr;
        }
    }
