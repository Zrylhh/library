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

## 各个目录的主要用途
例如fdisk命令就需要在相应文件夹/sbin/下输入指令 ./fdisk   就出现你要看的东西了

再如ifconfig命令需要在文件夹/sbin/下指执行./ifconfig就出现你要看的东西了

./bin: bin为binary的简写主要放置一些系统的必备执行档例如:cat、cp、chmod df、dmesg、gzip、kill、ls、mkdir、more、mount、rm、su、tar等。 

/usr/bin: 主要放置一些应用软体工具的必备执行档例如c++、g++、gcc、chdrv、diff、dig、du、eject、elm、free、gnome*、 gzip、htpasswd、kfm、ktop、last、less、locale、m4、make、man、mcopy、ncftp、 newaliases、nslookup passwd、quota、smb*、wget等。 

/sbin: 主要放置一些系统管理的必备程式例如:cfdisk、dhcpcd、dump、e2fsck、fdisk、halt、ifconfig、ifup、 ifdown、init、insmod、lilo、lsmod、mke2fs、modprobe、quotacheck、reboot、rmmod、 runlevel、shutdown等。 

/usr/sbin: 放置一些网路管理的必备程式例如:dhcpd、htpd、imap、in.*d、inetd、lpd、named、netconfig、nmbd、samba、sendmail、squid、swap、tcpd、tcpdump等。 

## 实时网卡流量
```
sar -n DEV 1 2
```
命令后面1 2 意思是：每一秒钟取1次值，取2次。
参数解释：
  + IFACE：LAN接口
  + rxpck/s：每秒钟接收的数据包
  + txpck/s：每秒钟发送的数据包
  + rxbyt/s：每秒钟接收的字节数
  + txbyt/s：每秒钟发送的字节数
  + rxcmp/s：每秒钟接收的压缩数据包
  + txcmp/s：每秒钟发送的压缩数据包
  + rxmcst/s：每秒钟接收的多播数据包
  + rxerr/s：每秒钟接收的坏数据包
  + txerr/s：每秒钟发送的坏数据包
  + coll/s：每秒冲突数
  + rxdrop/s：因为缓冲充满，每秒钟丢弃的已接收数据包数
  + txdrop/s：因为缓冲充满，每秒钟丢弃的已发送数据包数
  + txcarr/s：发送数据包时，每秒载波错误数
  + rxfram/s：每秒接收数据包的帧对齐错误数
  + rxfifo/s：接收的数据包每秒FIFO过速的错误数
  + txfifo/s：发送的数据包每秒FIFO过速的错误数
