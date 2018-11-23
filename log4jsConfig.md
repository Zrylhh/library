### log4js 配置

#### appender与catogary

appender是具体负责工作的，catogary是appender的分类，getlogger获取的是catogary，所以一定要有一个default的catogary，否则getlogger()就取不到分类。


附一个配置参考
```javascript
log4js.configure({
    appenders: {
        console: {
            "type": "console"
        },
        info: {
            "type": "dateFile",
            "filename": userDataPath + "/logs/info/info",
            "daysToKeep": 60,
            "pattern": ".yyyy-MM.log",
            "alwaysIncludePattern": true,
        },
        error: {
            "type": "dateFile",
            "filename": userDataPath + "/logs/error/error",
            "daysToKeep": 60,
            "pattern": ".yyyy-MM.log",
            "alwaysIncludePattern": true,
        }
    },
    categories: {
        default:{
            appenders: ['error',"info" , 'console'],
            level: 'error'
        },
        error: {
            appenders: ['error',  'console'],
            level: 'error'
        },
        info:{
            appenders: ['info','console'],
            level: 'info'
        }
    },
});

```