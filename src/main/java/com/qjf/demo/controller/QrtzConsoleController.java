package com.qjf.demo.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.qjf.common.BasicController;
import com.qjf.common.IPHelper;
import com.qjf.common.MyPage;
import com.qjf.common.ResultMap;
import com.qjf.demo.entity.QrtzConsole;
import com.qjf.demo.service.QrtzConsoleService;
import org.quartz.impl.StdScheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @Author:Tin
 * @Date: create in 2018/1/23 15:54
 * @Description: 定时任务管理
 *  1、job 名称 和 trigger 名称都采用job名称，job 和 trigger 一对一
 *  2、 trigger 都采用 cron trigger
 *  3、 job 和 trigger 组名称都使用默认值 DEFAULT
 *  注意：quartz 框架中 执行的sql语句都是大写（表名称和字段），linux环境下要注意（默认表名称是大小写敏感的）
 */
@Controller
@RequestMapping("admin/qrtzConsole")
public class QrtzConsoleController extends BasicController {

    private static Logger logger = LoggerFactory.getLogger(QrtzConsoleController.class);

    @Resource
    private QrtzConsoleService qrtzConsoleService;

    @Resource
    private StdScheduler scheduler;

    @RequestMapping(value="list",method = RequestMethod.GET)
    public String list(){
        return COMMON_LIST;
    }

    /**
     * @Author:QJF
     * @Date: 2018-03-10
     * @Description: 列表页面数据
     */
    @ResponseBody
    @RequestMapping(value = "listData",method = RequestMethod.GET,produces = {"application/json;charset=UTF-8"})
    public Map listData(Page<QrtzConsole> page, HttpServletRequest req){
        ResultMap rm = new ResultMap();
        try {
            EntityWrapper<QrtzConsole> wrapper = new EntityWrapper<>();
            rm.put("page", new MyPage(qrtzConsoleService.selectPage(page,wrapper)));
            rm.setSuccess();
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return rm;

    }

    @RequestMapping(value="edit",method = RequestMethod.GET)
    public String edit(Model model, @RequestParam(value = "id", required = false) Integer id) {
        if (null != id)
            model.addAttribute("data", qrtzConsoleService.get(id));
        return COMMON_EDIT;
    }

    /**
     * @Author:QJF
     * @Date: 2018/1/24 10:34
     * @Description:  status=1 運行中 status=2停止 status=3暂停
     * 实际使用当中暂时不适用status=3暂停的状态
     */
    @RequestMapping(value="save",method = RequestMethod.POST)
    @ResponseBody
    public Map save(QrtzConsole qc, HttpServletRequest req){
        ResultMap rm = new ResultMap();
        try {
            String ip = IPHelper.getIpAddr(req);
            qc.setAdminUserIp(ip);
            qc.setAdminUserId(1);
            qrtzConsoleService.saveOrUpdate(qc);
            return rm.setSuccess();
        } catch (Exception e) {
           logger.error(e.getMessage());
        }
        return rm;
    }

    @RequestMapping(value="delete",method = RequestMethod.POST)
    @ResponseBody
    public Map delete(Integer id){
        ResultMap rm = new ResultMap();
        try {
            qrtzConsoleService.delete(id);
            return rm.setSuccess();
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return rm;
    }

    /**
     * @Author:QJF
     * @Date: 2018/1/24 12:07
     * @Description: 目前支持2中状态，运行中和停止
     */
    @RequestMapping(value="update",method = RequestMethod.POST)
    @ResponseBody
    public Map update(Integer id, HttpServletRequest req){
        ResultMap rm = new ResultMap();
        try {
            String ip = IPHelper.getIpAddr(req);
            qrtzConsoleService.updateStatus(id,1,ip);
            return rm.setSuccess();
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return rm;
    }

    @RequestMapping(value="getSchedulerStatus",method = RequestMethod.GET)
    @ResponseBody
    public Map getSchedulerStatus(){
        ResultMap rm = new ResultMap();
        try {
            boolean standbyMode = scheduler.isInStandbyMode();
            System.out.println(standbyMode);
            rm.put("paused",standbyMode);
            return rm.setSuccess();
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return rm;
    }

    @RequestMapping(value="schedulerStartOrShutDown",method = RequestMethod.POST)
    @ResponseBody
    public Map schedulerStartOrShutDown(){
        ResultMap rm = new ResultMap();
        try {

            boolean standbyMode = scheduler.isInStandbyMode();
            if(standbyMode)
                scheduler.start();
            else
                scheduler.standby();

            rm.put("paused",!standbyMode);
            return rm.setSuccess();
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return rm;
    }
}
