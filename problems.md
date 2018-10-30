### 安装electronic-wechat时遇到的问题

  跨平台微信 [geeeeeeeeek/electronic-wechat](https://github.com/geeeeeeeeek/electronic-wechat)

  clone代码后npm install，总是卡在nodejieba 这个包这里。于是直接去github找这个包，发现依赖于python2.7(recommand)以及标准C库（gcc），并且要使用node-gyp来进行编译，所以先安装了node-gyp,然后检查本机环境，单独将nodejieba安装，然后再安装其他的依赖即可。
