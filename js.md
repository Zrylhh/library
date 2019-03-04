### js整理

## 关于闭包（closure）

```
function fn(){
  var num = 0;
  console.log(++num);
}
fn(); // 1
fn(); // 1
```
函数执行完以后，里面的变量（即局部变量）就会销毁，下一次运行又会重新创建那个变量，虽然第一次++num了但是这个变量在第一次执行完毕以后就被销毁了,所以两次输出都是1。
**如果一个函数被其他变量引用，这个函数的作用域将不会被销毁，也就是闭包的原因**

```
function fn(){
    var a = 0;
    return function(){
      console.log(++a);
    };
}
var f = fn();
f(); //1
f(); //2
```

**对于在for循环中绑定事件/定义函数，可以将事件/函数部分用一个自执行方法包起来**

```
var arr = [];
for(var i=0;i<2;i++){
    arr[i] = function(){
        console.log(i);
    }
}
arr[0](); //2
arr[1](); //2
// 为什么最后输出的都是2
// 在执行arr中方法的时候，循环已经结束，i=2，arr中函数没有i变量，于是从作用域链中找，最终找到循环结束的i


// 修改为下面即可正确执行
var arr = [];
for(var i=0;i<2;i++){
	(function(i){            //(2)
		arr[i] = function(){   //(3)
        console.log(i);    //(4)
    }
	})(i);                   //(1)
}
// 其中(1)处的i，是for循环中的i，赋值给自执行函数，(2)处的i是自执行函数的形参

```

**闭包可以解决函数外部无法访问函数内部变量的问题**
**创建一个闭包，一个函数中嵌套另外一个函数，并且将这个函数return出去，然后将这个return出来的函数保存到了一个变量中，那么就创建了一个闭包**


### 函数声明与函数表达式


### call、apply和bind

call和apply是函数自带的方法，可以用来改变this

```
var a = {
    user:"追梦子",
    fn:function(){
        console.log(this.user); //追梦子
    }
}
var b = a.fn;
b();  //undefined

var c = {
    user:'test'
}
// 将this指向c
b.call(c);  // test

// 不传值或者传null指向window
window.user = 'top';
b.call();   // top

//call可以传多个参数，第一个参数是指向的对象，后面的会直接作为实参
// apply可以传多个参数,第一个参数是指向的对象，后面只能有一个数组

```

bind方法返回的是一个修改过后的函数。


### this的指向

#### [理解js中this的指向](https://www.cnblogs.com/pssp/p/5216085.html)

1. **this的指向在函数创建的时候是决定不了的，在调用的时候才能决定，谁调用的就指向谁**
2. **this永远指向的是最后调用它的对象**
3. 在严格版中的默认的this不再是window，而是undefined。
4. new操作符会改变函数this的指向问题
  ```
  function fn(){
      this.num = 1;
  }
  var a = new fn();
  console.log(a.num); //1
  fn();               //undefined
  // 此处
  ```
5. 在非箭头函数中，谁调用，this就指向谁，除了使用call/apply/bind方法外。


### \_\_proto\_\_与prototype

\_\_proto\_\_ 是对象的属性，

prototype 是函数的属性；

在proto或者prototype中编写属性方法，在new的对象中可以继承。


### 连续赋值
```
function fn(){
    var a = b = c = 10;
}
fn();

console.log(b); //10
console.log(c); //10
console.log(a); //a is not defined

// 解释：赋值语句是从右往左执行的，我们将10赋值给了c，但是c此时还声明，接着把c的返回值赋值给了b，但是b也还没有声明，最后赋值给了a此时a有声明，所以a就是局部变量。
```


### js中的正则表达式

两种写法
```
var reg = new RegExp("表达式","可选规则");
var reg = / 表达式 /可选规则;
```


### 如何动态的加载js

```
var script1 = document.createElement("script");
script1.src = "http://127.0.0.1:8081/index.js";
document.body.appendChild(script1);
```

即可，appendChild方法是异步执行的
或者使用document.write()(会覆盖原有html？)


### event.preventDefault()与 event.stopPropagation()

- event.preventDefault()
  阻止原本的事件

- event.stopPropagation()
  阻止事件的传播

### event.target 可以获取触发事件的元素

 event.target.value 获取值

### JS事件中防抖debounce和节流throttle

  浏览器的一些事件，如：resize,scroll,keydown,keyup,keypress,mousemove等。这些事件触发频率太过频繁，绑定在这些事件上的回调函数会不停的被调用。

  - debounce的作用是在让在用户动作停止后延迟x ms再执行回调。

  - throttle的作用是在用户动作时没隔一定时间（如200ms）执行一次回调。

### label标签 for属性

  ```
  <label for="female">Male</label>
  <input type="radio" name="sex" id="male" />

  <label for="male">Female</label>
  <input type="radio" name="sex" id="female" />
  ```

  for后面跟一个元素的id，点击label会关联到for的元素
  
### 移位运算 >>> 与 >>

  \>\> 有符号移位：该操作符会将第一个操作数向右移动指定的位数。向右被移出的位被丢弃，拷贝最左侧的位以填充左侧
  
  ```
  -9 >> 2
  11111111111111111111111111110111  // -9 -> 11111111111111111111111111111101   // -3
  ```
  
  \>\>\> 无符号移位：该操作符会将第一个操作数向右移动指定的位数。向右被移出的位被丢弃，左侧用0填充。因为符号位变成了 0，所以结果总是非负的。（即便右移 0 个比特，结果也是非负的。）
  
  ```
  9 >>> 2
  00000000000000000000000000001001   // 9 ->  00000000000000000000000000000010 // 2
  ```
  
  >> x >>> 0 本质上就是保证x有意义（为数字类型），且为正整数，在有效的数组范围内（0 ～ 0xFFFFFFFF），且在无意义的情况下缺省值为0。
  
  摘自[js中表达式 >>> 0 浅析](https://segmentfault.com/a/1190000014613703)
  

### js获取随机颜色
  
  ```
  function getRandomColor(){ 
    return "#"+("00000"+((Math.random()*parseInt("ffffff",16)+0.5)>>0).toString(16)).slice(-6); 
  } 
  // 16777215为16进制的颜色ffffff转成10进制的数字 
  // >>数字取整 
  // 转成16进制不足6位的以0来补充 
  ```
  
  计算出颜色的补色
  以RGB而言，只要计算R、G、B每一位的值与256的差值即可
  ```
  // 计算补色
  var R = bgColor.slice(0,2);
  var G = bgColor.slice(2,4);
  var B = bgColor.slice(4,6);
  var reverseR = (255-parseInt(R,16)).toString(16);
  var reverseG = (255-parseInt(G,16)).toString(16);
  var reverseB = (255-parseInt(B,16)).toString(16);
  
  // 此处的 '#'+reverseR+reverseG+reverseB 即为补色
  ```
  

### HTML5中的Web Notification桌面通知

参考地址[简单了解HTML5中的Web Notification桌面通知](https://www.zhangxinxu.com/wordpress/2016/07/know-html5-web-notification/)


### 事件绑定与事件委托

事件绑定：
原生js下使用 addEventListener, Jquery使用on/bind

事件委托，是对事件绑定的扩展，利用事件冒泡，只指定一个事件处理程序来管理某一类型的所有事件，比如对很多数据的表格中进行事件绑定。

例如下面这个列表，点击时使li变成红色
```
<ul id = "lists">
         <li>列表1</li>
         <li>列表2</li>
         <li>列表3</li>
         <li>列表4</li>
         <li>列表5</li>
         <li>列表6</li>
 </ul>
 
// js
var lists = document.getElementById("lists");
lists.addEventListener("click",function(event){
    var target = event.target;
    //防止父元素ul也触发事件
    if(target.nodeName == "LI"){
       target.style.backgroundColor = "red";
    }
})
 
// jquery
// 要用到事件回调函数中自带的参数event，event.target
// on方法可以对元素类型进行过滤
$("#lists").on("click","li",function(event){
	var target = $(event.target);
	target.css("background-color","red");
})
 
```

### bind与on方法的区别


### 关于setTImeOut(function(){},0)

这里就必须要理解javascript的执行过程 [这一次，彻底弄懂javascript执行机制](https://juejin.im/post/59e85eebf265da430d571f89)。

简单来说 setTImeOut(function(){},0) 就是告诉浏览器，有空了就来执行这个方法



### 关于元素拖动，可以参考这里的代码

[AngularJs指令](http://www.angularjs.net.cn/tutorial/5.html)

### webworker

[Web Worker 使用教程](http://www.ruanyifeng.com/blog/2018/07/web-worker.html)


### utf-8格式编码的中文转化为普通的中文

unescape('&#x4E2D;&#x56FD;'.replace(/&#x/g, '%u').replace(/;/g, ''))

### 如何维护nodejs程序的稳定性
捕获这两个防止意外 uncaughtException 和 unhandledRejection。
