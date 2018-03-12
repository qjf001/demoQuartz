package com.qjf.demo.entity;

import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 系统定时任务控制器，其它t_qrtz开头的表为quartz框架表
 * </p>
 *
 * @author QJF
 * @since 2018-03-11
 */
@TableName("t_qrtz_console")
public class QrtzConsole implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * job（任务）名称，所有任务分组和触发器分组为默认值DEFAULT
     */
    @TableField("name")
    private String name;
    /**
     * 任务英文名称，唯一
     */
    @TableField("name_en")
    private String nameEn;
    /**
     * 类名称，包含包名称
     */
    @TableField("full_class_name")
    private String fullClassName;
    /**
     * cron表达式
     */
    @TableField("cron")
    private String cron;
    /**
     * 最后一次更新时间
     */
    @TableField("last_updatetime")
    private Date lastUpdatetime;
    /**
     * 最后一次更新操作人员id
     */
    @TableField("admin_user_id")
    private Integer adminUserId;
    /**
     * 最后一次更新操作人员ip
     */
    @TableField("admin_user_ip")
    private String adminUserIp;
    /**
     * 备注
     */
    @TableField("memo")
    private String memo;
    /**
     * 任务状态：1表示正常运行，2表示停止运行，3表示暂停（服务重启后会正常运行）
     */
    @TableField("status")
    private Integer status;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    public String getFullClassName() {
        return fullClassName;
    }

    public void setFullClassName(String fullClassName) {
        this.fullClassName = fullClassName;
    }

    public String getCron() {
        return cron;
    }

    public void setCron(String cron) {
        this.cron = cron;
    }

    public Date getLastUpdatetime() {
        return lastUpdatetime;
    }

    public void setLastUpdatetime(Date lastUpdatetime) {
        this.lastUpdatetime = lastUpdatetime;
    }

    public Integer getAdminUserId() {
        return adminUserId;
    }

    public void setAdminUserId(Integer adminUserId) {
        this.adminUserId = adminUserId;
    }

    public String getAdminUserIp() {
        return adminUserIp;
    }

    public void setAdminUserIp(String adminUserIp) {
        this.adminUserIp = adminUserIp;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "QrtzConsole{" +
        "id=" + id +
        ", name=" + name +
        ", nameEn=" + nameEn +
        ", fullClassName=" + fullClassName +
        ", cron=" + cron +
        ", lastUpdatetime=" + lastUpdatetime +
        ", adminUserId=" + adminUserId +
        ", adminUserIp=" + adminUserIp +
        ", memo=" + memo +
        ", status=" + status +
        "}";
    }
}
