### 使用sqlldr将csv中数据导入到oracle中

需要配置一个test.ctl文件，内容参考以下：
```
load data
infile test.csv //要导入的文件路径
append          //向表中追加数据，可以使用其他参数来先清理表
into table test //要导入数据的表名
fields terminated by ','    //以 , 来分割
Optionally enclosed by '"'  //以 " 
TRAILING NULLCOLS           //无数据时留空，不配置这行会丢弃空数据
{
    id,
    col1,
    col2
    ...
}                           //表字段，要与csv中数据顺序对应
```

然后执行脚本
```
sqlldr userid=username/password@ip/实例 control='test.ctl' data='test.csv' log='test.log' errors=200 // errors最大容错，当错误数据达到该数字时，sqlldr退出导入，默认为50,ora10和ora11设置为-1表示无限。
```

### sqlldr 源文件的换行符问题

在windows系统下，csv文件最后以 **CRLF** 结尾，而linux系统下，默认以**LF**结尾，这就导致dos格式（windows）文件放到linux系统下通过sqlldr导入时，会认为最后一个字段是 **字段LF** 形式，如果是数字可能就会报错"invalid number" .
解决方法是将文件通过编辑器转换成unix格式（dos变unix），然后给最后一个字段指定 TERMINATED BY whitespace .
```
load data
infile test.csv //要导入的文件路径
append          //向表中追加数据，可以使用其他参数来先清理表
into table test //要导入数据的表名
fields terminated by ','    //以 , 来分割
Optionally enclosed by '"'  //以 " 
TRAILING NULLCOLS           //无数据时留空，不配置这行会丢弃空数据
{
    id,
    col1,
    col2
    ...
    lastcol TERMINATED BY whitespace  //指定换行
}                           //表字段，要与csv中数据顺序对应
```