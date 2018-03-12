package com.qjf.demo.service;

import com.qjf.demo.entity.QrtzConsole;
import com.baomidou.mybatisplus.service.IService;
import org.quartz.Job;
import org.quartz.JobKey;
import org.quartz.SchedulerException;
import org.quartz.TriggerKey;
import org.quartz.impl.JobDetailImpl;
import org.quartz.impl.triggers.CronTriggerImpl;

import java.text.ParseException;
import java.util.Date;

/**
 * <p>
 * 系统定时任务控制器，其它t_qrtz开头的表为quartz框架表 服务类
 * </p>
 *
 * @author QJF
 * @since 2018-03-12
 */
public interface QrtzConsoleService extends IService<QrtzConsole> {

    public QrtzConsole get(final Integer id);

    public boolean saveOrUpdate(QrtzConsole qc);

    public boolean save(QrtzConsole qc);

    public boolean update(QrtzConsole qc);

    /**
     * @Author:QJF
     * @Date: 2018/1/23 18:16
     * @Description: 直接物理刪除，刪除后清除定時任務
     */
    public void delete(Integer id) throws SchedulerException ;

    /**
     * @Author:QJF
     * @Date: 2018/1/23 18:17
     * @Description: 更新狀態，根據狀態對定時任務作出相應的更改
     */
    public void updateStatus(final Integer id,final Integer userId,final String ip) throws SchedulerException, ParseException, ClassNotFoundException;

    public void startSchedule(QrtzConsole qc) throws ParseException, SchedulerException, ClassNotFoundException ;

    /**移除一个任务和触发器 */
    public void removeJob(QrtzConsole qc) throws SchedulerException;
}
