### 记录一次springboot配置双数据源的过程

# 前情

项目已配置一个mysql数据库，使用了sharding分表策略，使用jpa来管理。现要求再配置一个数据库用于保存其他数据（与业务无关），两个数据库相互无关系。

# 操作

首先考虑sharding配置双数据源，网上搜了sharding配置双数据源多用于读写分离，主库写入从库用于读取，主从库关联比较密切（两个数据库之间还要进行主从配置），与需求不符合，略过。

然后尝试普通的springboot配置双数据源，写配置文件，新增一个数据源配置（secondaryDataSource），在启动时报错，大意为需要一个Primary的数据源。于是尝试在新增的数据源上增加 @Primary配置，之后可以正常启动但是原来的sharding分表策略也使用了新的数据源。 

在网上搜了下，想到了既然已经引入了springboot-sharding，那么默认已经配置了一个数据源供sharding使用，但是并没有给这个数据源加 @Primary并且sharding也没有指定某个数据源（因为刚开始并没有考虑过多个数据库），于是再写一个配置类继承springboot-sharding的配置类，重写 dataSource方法，返回父类的datasource，并加上配置@Primary,这样sharding的数据源就变成了Primary，而新增的代码中会指定新增的数据源（jdbctemplate），之后正常启动并达成需求。