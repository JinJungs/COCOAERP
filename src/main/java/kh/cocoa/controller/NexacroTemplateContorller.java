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
import javax.xml.transform.Templates;
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
        System.out.println(list);
        nr.addDataSet("out_ds",list);
        return nr;
    }

    @RequestMapping("/tp_origin.nex")
    public NexacroResult tp_origin(){
        NexacroResult nr = new NexacroResult();
        List<TemplatesDTO> list = templatesService.getTemplateList2();
        System.out.println(list);
        nr.addDataSet("out_ds",list);
        return nr;
    }

    @RequestMapping("/tp_title.nex")
    public NexacroResult tp_title(){
        NexacroResult nr = new NexacroResult();
        List<TemplateFormDTO> list = templateFormService.getTempleateFormList();
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

    @RequestMapping("/tp_titleAdd")
    public NexacroResult tp_titleAdd(@ParamDataSet(name="in_ds") TemplateFormDTO dto){
        int result = templateFormService.addTemplateForm(dto);
        return new NexacroResult();
    }

    @RequestMapping("/tp_titleMod")
    public NexacroResult tp_titleMod(@ParamDataSet(name="in_ds") TemplateFormDTO dto){
        int result = templateFormService.modTemlateForm(dto);
        System.out.println(dto);
        return new NexacroResult();
    }

    @RequestMapping("/addList_onclick.nex")
    public NexacroResult addList_onclick(@ParamVariable(name="form_code")int form_code,
                                         @ParamVariable(name="name")String name,
                                         @ParamVariable(name="explain")String explain,
                                         @ParamVariable(name="contents")String contents,
                                         @ParamVariable(name="status")String status,
                                         @ParamVariable(name="temp_code")int temp_code,
                                         @ParamVariable(name="writer_code")int writer_code){
        TemplatesDTO dto = new TemplatesDTO();
        dto.setName(name);
        dto.setForm_code(form_code);
        dto.setContents(contents);
        dto.setExplain(explain);
        dto.setTemp_code(temp_code);
        dto.setWriter_code(writer_code);
        dto.setStatus(status);
        int result = templatesService.addTemplates(dto);
        List<TemplatesDTO> list = templatesService.getClickTemplateList(form_code);
        NexacroResult nr = new NexacroResult();
        nr.addDataSet("out_ds",list);
        return nr;
    }
}
