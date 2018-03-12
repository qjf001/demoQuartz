package com.qjf.quartz;

import org.quartz.spi.TriggerFiredBundle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.scheduling.quartz.SpringBeanJobFactory;

/**
 * @Author:Tin
 * @Date: create in 2018/1/23 15:19
 * @Description:
 * AutowireCapableBeanFactory
 * 1、BeanFactory接口的扩展，被那些能够实现自动匹配的工厂实现，提供针对已存在bean实例的服务
 * 2、整合其他框架的代码是此接口优势所在，它可以连接和填充那些生命周期不被Spring管理的已存在的bean实例
 * 3、此接口没有被ApplicationContext实现，因为他几乎不（代表有）在程序代码中使用。那也就是说他从一个application context上下文中也是可用的，
 *    通过ApplicationContext的getAutowireCapableBeanFactory方法就很容易访问此接口
 */
public class CustomJobFactory extends SpringBeanJobFactory{

    @Autowired
    private AutowireCapableBeanFactory capableBeanFactory;

    protected Object createJobInstance(TriggerFiredBundle bundle) throws Exception {
        //调用父类的方法
        Object jobInstance = super.createJobInstance(bundle);
        //进行注入
        /**
         * @Author:QJF
         * @Date: 2018/1/24 9:48
         * @Description:
         * 通过实例化之后的回调和bean属性的填充处理进程（如注解驱动注入） 填充给定的bean实例
         * 注：此方法预期是填充有注解的属性和方法，或者是新建的实例，也或者是反序列化得到的实例。
         * 此方法同样并非通过传统的by-name或者by-type实现属性的注入，反之，要达成此目的，使用方法autowireBeanProperties
         * @param existingBean
         * @throws BeansException  如果注入失败，抛出此异常
         *
         */
        capableBeanFactory.autowireBean(jobInstance);
        return jobInstance;
    }

}
