package com.qjf.demo.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.qjf.demo.entity.QrtzConsole;
import com.qjf.demo.mapper.QrtzConsoleMapper;
import com.qjf.demo.service.QrtzConsoleService;
import org.quartz.Job;
import org.quartz.JobKey;
import org.quartz.SchedulerException;
import org.quartz.TriggerKey;
import org.quartz.impl.JobDetailImpl;
import org.quartz.impl.StdScheduler;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.util.Date;

/**
 * @Author:Tin
 * @Date: create in 2018/1/23 15:55
 * @Description:
 */
@Service
public class QrtzConsoleServiceImpl extends ServiceImpl<QrtzConsoleMapper, QrtzConsole> implements QrtzConsoleService {

    @Resource
    private StdScheduler scheduler;

    public QrtzConsole get(final Integer id) {
        return selectById(id);
    }

    public boolean saveOrUpdate(QrtzConsole qc) {
        qc.setLastUpdatetime(new Date());
        if(null != qc.getId() && qc.getStatus().intValue()==1)
            throw new RuntimeException("該任務正在運行中，不可以修改");
        return null == qc.getId() ? save(qc) : update(qc);
    }

    public boolean save(QrtzConsole qc){
        return insert(qc);
    }

    public boolean update(QrtzConsole qc){
        qc.setLastUpdatetime(new Date());
        return updateById(qc);
    }

    /**
     * @Author:QJF
     * @Date: 2018/1/23 18:16
     * @Description: 直接物理刪除，刪除后清除定時任務
     */
    public void delete(Integer id) throws SchedulerException {
        removeJob(get(id));
        delete(id);
    }

    /**
     * @Author:QJF
     * @Date: 2018/1/23 18:17
     * @Description: 更新狀態，根據狀態對定時任務作出相應的更改
     */
    public void updateStatus(final Integer id,final Integer userId,final String ip) throws SchedulerException, ParseException, ClassNotFoundException {
        QrtzConsole qc = get(id);
        int status = qc.getStatus().intValue();
        if(status == 1)
            removeJob(qc);
        else
            startSchedule(qc);

        qc.setStatus(status == 1 ? 2 : 1);
        qc.setAdminUserId(userId);
        qc.setAdminUserIp(ip);
        update(qc);
    }

    public void startSchedule(QrtzConsole qc) throws ParseException, SchedulerException, ClassNotFoundException {
        String cron = qc.getCron().trim();
        String name = qc.getNameEn()+cron;
        JobDetailImpl jobdetail = new JobDetailImpl();
        jobdetail.setName(name);
        jobdetail.setJobClass((Class<? extends Job>) Class.forName(qc.getFullClassName()));

        CronTriggerImpl trigger = new CronTriggerImpl();
        trigger.setName(name);
        trigger.setCronExpression(cron);
        trigger.setMisfireInstruction(CronTriggerImpl.MISFIRE_INSTRUCTION_DO_NOTHING);
        scheduler.scheduleJob(jobdetail, trigger);
    }

    /**移除一个任务和触发器 */
    public void removeJob(QrtzConsole qc) throws SchedulerException{
        String name = qc.getNameEn()+qc.getCron();
        scheduler.pauseTrigger(new TriggerKey(name));//停止触发器
        scheduler.unscheduleJob(new TriggerKey(name));//移除触发器
        scheduler.deleteJob(new JobKey(name));//删除任务
    }

}
