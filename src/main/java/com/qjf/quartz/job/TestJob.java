package com.qjf.quartz.job;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * @Author:Tin
 * @Date: create in 2018/1/22 16:57
 * @Description:
 */
public class TestJob implements Job {


    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        System.out.println("处理数据");
    }
}
