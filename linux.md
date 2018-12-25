### linux 常用命令整理

## 使用awk批量杀进程

[参考](https://www.cnblogs.com/yiyide266/p/6541809.html)

例子

```
ps -ef|grep Msg|awk '{print "kill -9" $2}'

kill -9 18083
...
```
执行后会将对应的语句输出到控制台，右键复制执行即可
