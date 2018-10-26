
1. angular 考虑的是构建CRUD应用，在需要频繁的DOM操作时，可能Jquery更好些。

    接触一个angular项目，可以考虑根据页面的url（路由）来一个一个的查看对应的 ×Module 以及 ×Controller

    angular中有很清晰的M(model)V(html)C(controller),因为html中大量使用模板，所以这部分html也可以当作vm(view-model),即 M V V-M 模式。






2. 指令：

    + 指令的扩展写法与规范化

        >规范化的过程如下所示：

        >从元素或属性的名字前面去掉x- and data-

        >从:, -, 或 _分隔的形式转换成小驼峰命名法(camelCase).


        ```
        Hello <input ng-model='name'> <hr/>
        <span ng-bind="name"></span> <br/>
        <span ng:bind="name"></span> <br/>
        <span ng_bind="name"></span> <br/>
        <span data-ng-bind="name"></span> <br/>
        <span x-ng-bind="name"></span> <br/>
        ```
        这几种写法都是合格的
        所以，偶尔在代码里看到ng-model写成ngModel也并不奇怪，vue中也有相似的机制。


    + ng-app:根节点，在页面加载完毕后，Angular回去寻找根节点，然后开始加载ng-app指令所指定的模块 ，创建应用需要的injector ，以ng-app所在节点为根节点，开始遍历并编译DOM树。

    + ng-init:初始化数据
    + ng-model:数据
    + ng-controller：创建一个scope，后面传入一个注册的控制器的名字，表示由该控制器来管理这个scope。


    + 自定义指令
        常见参数
        - replace (可选)： 默认值为false，当为false时模板会作为子元素插入到调用该指令的元素内部;
                            当为ture时模板会替换掉调用该指令的元素。
        - link : 是用来操作DOM的方法 

3. 表达式
    + {{expressiong | filter}} 双大括号

    Angular表达式与js表达式有一定区别
    + 属性解析： 所有的属性的解析都是相对于作用域(scope)的，而不像JavaScript中的表达式解析那样是相对于全局'window'对象的。
    + 容错性： 表达式的解析对'undefined'和'null'具有容错性，这不像在JavaScript中，试图解析未定义的属性时会抛出ReferenceError或TypeError错误.
    + 禁止控制流语句： 表达式中不允许包括下列语句：条件判断(if)，循环(for/while)，抛出异常(throw)。

    在表达式中访问window(全局对象)时，需要使用$window

4. 控制器（controller）

    + 控制器中的方法都是返回一个function(工厂模式)。
    + **控制器中不要直接写DOM操作**，如果必须，请写在指令中。

5. 服务（Service）：
   可以理解为全局的静态通用类
   > 最好的做法是：把控制器中与视图无关的逻辑都移到"服务(service)"中。 以便这个应用程序的其他部分也能复用这些逻辑。

    > d（xinyue）n（renwu）
    > cl(fourZhu){daily}
    > idea{
        后台：java分布式
        前端：vue
        做什么？

    > }


6. 过滤器（filter）
    概念与vue中的计算属性差不多

7. 表单（ngvalidate）
写法
```
    <form ngvalidate>
        ...
    </form>
```

Angular定义了如下几个css类来进行表单验证的提示

+ ng-valid 
+ ng-invalid 
+ ng-pristine 
+ ng-dirty

在需要时可以直接定义这几个类的样式，来体现表单填写正确/不合格/初始状态/脏数据的不同状态

8. $location
    有一个特殊的replace方法，
    >来告诉$location服务：你下次和浏览器同步的时候，应该用新地址“替代”最后一条历史记录而不是“追加”新纪录。这在你实现重定向的时候很有用，否则它将“玩死”浏览器的“后退”按钮（“后退”立刻触发一次重定向，导致页面进入死循环）。


9. 路由
    Angular的路由可以