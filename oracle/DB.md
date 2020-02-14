### Oracle


1. oracle存储单元，数据块（block）


#### 常用字符集

汉字：ZHS16GBK
通用: AL32UTF8

#### 表

要善用表空间

#### 数据类型

常用 NUMBER VARCHAR2 CLOB BLOB
时间视精度而定

时间精度|类型
:-:|:-:
大于1天|VARCHAR2
大于1秒|DATE
小于1秒|TIMESTAMP


#### 视图
对于oracle只是会在执行sql时将视图替换为创建时的sql，不会有性能优化，只能用于简化代码。

#### 索引（索引）
    
1. 普通B树索引
    例如对0-10000进行索引，那么就分割为0-50、51-100...等数据块，然后再对数据块索引
    
    优势：可以快速定位到一小部分数据（查的快）
    order by 、group by、distinct等会引起排序的操作要利用索引（频繁使用时）

    劣势：索引会影响DML（增删改）的性能，所以一张表不要超过5个索引。
    查询大量数据时全表扫描更好，推荐5%以下数据建索引，15%以上全表扫描。

2. 反向键索引
3. 函数索引
4. 位图索引

#### SQL
    
避免隐式转换，例如

```
    // class_id 是varchar2
    where class_id = 2018001   // 对于oracle，可能不会将 2018001转换为字符型来比较，而是将class_id转化为number来比较
    where class_id = '2018001'
```

尽量使用union all 而不是union，union会去重引起排序。

like ，'%' 出现在字符串前会无法使用索引。

#### 执行计划
 可以分析一句sql，oracle执行的过程，例如是全表扫描还是索引，先访问那一张表等，可以用于优化sql。

#### 通过pl/sql执行计划来优化sql
在plsql中打开一个新的解释计划窗口，在其中执行sql，查看执行计划。尽量让查询通过索引来进行，函数计算会导致索引失效，要单独建立函数索引。


#### DML

delete操作比较频繁的表，应改用假删除。
因为oracle默认会把删掉的记录记录下来，在oracle崩溃时可以用来修复短时间内的数据。

#### 复杂查询语句

表连接不宜超过5个，嵌套不宜超过5个（不关联表的嵌套不计数）。

#### HINT

可以固定**执行计划**

#### DBLink

不建议用，应用之间还是应该走接口。

#### PLSQL

varchar2的输出参数不要超过50（内存占用过多），可以改用游标。

#### 统计信息

oracle会自动统计表的数据，例如数据量、数据分布、索引等，便于后续执行sql时安排执行计划，可以手动调用命令来让oracle分析。
没有统计信息的表执行sql效率会低。

### 使用oracle物化视图

### 连接多表

**join** 为 **inner join**的简写

**left join**和**right join**为**left outer join**和**right outer join**的简写

多表联接参考

```
select * from 
test1 t1 left join test2 t2 on t1.id=t2.id
left join test3 t3 on t1.id=t3.id
... 
```
#### 行转列
一般用listagg函数，可以将字段进行拼接。
可以使用xmlagg将特别长的字段转换为clob

#### 列转行

将字段用逗号分隔后转换成行，参考sql

```
with temp as
(select '1,2,3' nums, 'a' names from dual
	union all
	select '4,5' nums, 'b' names from dual
	union all
	select '6,7' nums, 'c' names from dual
	union all
	select '8' nums, 'c' names from dual
	union all
	select '9,10' nums, 'c' names from dual
	union all
	select '11,12' nums, 'c' names from dual
	union all
	select '13,14' nums, 'c' names from dual
	union all
	select '15,16' nums, 'c' names from dual
	union all
	select '17,18' nums, 'c' names from dual
	union all
	select '19,20' nums, 'c' names from dual
	union all
	select '21,22,23,24,25,26,27,28,29,30,31,32,33,34' nums, 'c' names from dual
)
select regexp_substr(nums,'[^,]+',1,b.lv) order_num,names
from temp, (select level lv from dual connect by level<=(select max(length(regexp_replace(nums,'[^,]+'))+1) from temp)) b	--用于分配行数（行数取最大的nums分隔数）
where b.lv <=length(regexp_replace(nums,'[^,]+'))+1 order by order_num
```

其中lv主要是用于判断有多少行要取，可以定义一个比较大的数字，然后在后面的查询中再过滤掉为空的数据。

#### 分组后排序

```
select id,name,score,row_number() over(partition by id order by score desc nulls last) as rn
```
按照id分组，对分组后数据按照score排序，最终得出排名rn字段，在后面的查询中可以通过rn字段来获得前5的数据.

tip:使用rank over()的时候，空值是最大的，如果排序字段为null, 可能造成null字段排在最前面，影响排序结果。
#### dense_rank()和row_number()和rank()的区别

参考下例

```
--row_number() 顺序排序
select name,course,row_number() over(partition by course order by score desc) rank from student;
```

name|course|rank
:-:|:-:|:-:
dock|1|1
bob|1|2
clark|1|3
elic|1|4
alice|1|5
jacky|2|**1**
hill|2|**2**
frank|2|**3**
iris|2|**4**
grace|2|**5**

```
--rank() 跳跃排序，如果有两个第一级别时，接下来是第三级别
select name,course,rank() over(partition by course order by score desc) rank from student;
```
name|course|rank
:-:|:-:|:-:
dock|1|1
bob|1|2
clark|1|3
elic|1|4
alice|1|5
jacky|2|**1**
hill|2|**2**
frank|2|**2**
iris|2|**4**
grace|2|**5**

```
--dense_rank() 连续排序，如果有两个第一级别时，接下来是第二级别 
select name,course,dense_rank() over(partition by course order by score desc) rank from student;
```
name|course|rank
:-:|:-:|:-:
dock|1|1
bob|1|2
clark|1|3
elic|1|4
alice|1|5
jacky|2|**1**
hill|2|**2**
frank|2|**2**
iris|2|**3**
grace|2|**4**