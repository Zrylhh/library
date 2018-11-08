### 安装electronic-wechat时遇到的问题

  跨平台微信 [geeeeeeeeek/electronic-wechat](https://github.com/geeeeeeeeek/electronic-wechat)

  clone代码后npm install，总是卡在nodejieba 这个包这里。于是直接去github找这个包，发现依赖于python2.7(recommand)以及标准C库（gcc），并且要使用node-gyp来进行编译，所以先安装了node-gyp,然后检查本机环境，单独将nodejieba安装，然后再安装其他的依赖即可。


### 这里修改统一行，测试如何解决冲突

  但是c语言写的还是找不到入口，好像还不支持linux，等后面环境变成win了再尝试运行。
### 关注下miniblink，后面可能要用到

  调整md样式

  最好还是看一下源码，看一下如何缩减chromium大小的。

  这里随便写一些东西，改动同一行导致冲突即可
