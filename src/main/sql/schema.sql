-- 数据库初始化脚本

CREATE DATABASE IF NOT EXISTS opt
  DEFAULT CHARACTER SET utf8;

USE opt;

-- 用户表
CREATE TABLE IF NOT EXISTS opt.user (
  user_id  BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '用户id',
  name     VARCHAR(20)  NOT NULL
  COMMENT '用户真实姓名',
  email    varchar(128) NOT NULL
  COMMENT '用户邮箱',
  password VARCHAR(100) NOT NULL
  COMMENT '用户密码',
  phone    BIGINT       NOT NULL
  COMMENT '用户手机号',
  status   SMALLINT              DEFAULT 0
  COMMENT '用户状态',
  title    VARCHAR(20)  NOT NULL
  COMMENT '用户职务',
  PRIMARY KEY (user_id),
  KEY idx_user_phone(phone),
  KEY idx_user_name(name)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8
  COMMENT = '用户表';

INSERT INTO user (name, email, password, phone, status, title)
VALUES ('lumi', 'Lujian@*****.com', 'MCC0420', 18817314957, 0, 'superAdmin');

-- DAG表
CREATE TABLE IF NOT EXISTS opt.dag (
  id                BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '行记录id',
  dag_id            VARCHAR(64)  NOT NULL
  COMMENT 'dag id',
  default_args      JSON         NOT NULL
  COMMENT 'dag配置参数',
  description       VARCHAR(128) COMMENT 'dag描述',
  schedule_interval VARCHAR(64)  NOT NULL
  COMMENT 'dag调度周期',
  file_path         varchar(256) NOT NULL
  COMMENT 'dag文件保存路径',
  createor          BIGINT       NOT NULL
  COMMENT '创建者',
  create_time       TIMESTAMP             DEFAULT current_timestamp()
  COMMENT '任务创建时间',
  update_time       TIMESTAMP    NULL
  COMMENT '任务更新时间',
  status            SMALLINT     NOT NULL DEFAULT 0
  COMMENT '任务状态',
  PRIMARY KEY (id),
  KEY idx_createor(createor),
  KEY idx_status(status),
  KEY idx_dag_id(dag_id)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8
  COMMENT = 'dag表';

-- 任务表
CREATE TABLE IF NOT EXISTS opt.task (
  id           BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '行记录id',
  task_id      VARCHAR(64)  NOT NULL
  COMMENT '任务id',
  bash_commend varchar(256) NOT NULL
  COMMENT 'bash 命令',
  hql_script   varchar(256) NOT NULL
  COMMENT 'hql脚本',
  up_stream    JSON         NOT NULL
  COMMENT '上游依赖',
  down_stream  JSON         NOT NULL
  COMMENT '下游依赖',
  description  varchar(512) COMMENT '任务描述',
  dag_id       BIGINT       NOT NULL
  COMMENT 'dag 行id',
  createor     BIGINT COMMENT '创建者',
  create_time  TIMESTAMP             DEFAULT current_timestamp()
  COMMENT '任务创建时间',
  update_time  TIMESTAMP    NULL
  COMMENT '任务更新时间',
  status       SMALLINT     NOT NULL DEFAULT 0
  COMMENT '任务状态',
  type         INT          NOT NULL
  COMMENT '任务类型',
  PRIMARY KEY (id),
  KEY idx_createor(createor),
  KEY idx_status(status),
  KEY idx_task_id(task_id),
  CONSTRAINT FOREIGN KEY (createor) REFERENCES user (user_id),
  CONSTRAINT FOREIGN KEY (dag_id) REFERENCES dag (id)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = utf8
  COMMENT = '任务表';
