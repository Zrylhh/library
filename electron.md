## Electron整理

#### Electron进程间通信方式

  1. 通过ipc

    + 主进程向渲染进程发信息
        在主进程中使用对应的 XXWindow.webContents.send()
    + 主进程接收渲染进程发送的信息
        ipcMain.on()
        ipcMain.once()

    + 渲染进程向主进程发信息
        ipcRenderer.send()
    + 渲染进程接收主进程信息
        ipcRenderer.on()
        ipcRenderer.once()

  2. 通过remote方法
    remote方法允许渲染进程调用主进程中的模块(方法)

#### 在Electron 中进行Ajax请求，并不会遇到跨域的问题

#### 在Electron 中可以使用 child_process (属于node模块) 调用系统命令
