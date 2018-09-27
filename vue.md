
#### 1.创建一个vue实例

```
var vm = new Vue({
  // 选项
})
```

有一些可以在创建时初始化的属性(选项)

  1. data:数据对象 Object | Function
  2. props: Array<string> | Object 用于接收来自父组件的数据？
          可以当成元素本身上面的attr，在vue渲染过程中会自动去读取。
  3. 生命周期钩子
      created,mounted....
      其中created就是一个生命周期钩子函数，就是vue实例生成后调用的函数，一般我们都在created函数中处理ajax数据。


#### 2.vue作为模板的语法

**数据绑定最常见的形式就是使用“Mustache”语法 (双大括号) 的文本插值**

```
<span>Message: {{ msg }}</span>
<!-- 直接输出值 -->
```


一些vue的指令

1. v-once 仅一次的进行插值  
2. v-html 插入raw html
3. v-bind 缩写 :  ,将一个元素的属性与一个js中的变量绑定，例如  
  ```
  <div v-bind:id="dynamicId"></div>
  <button v-bind:disabled="isButtonDisabled">Button</button>
  <a v-bind:href="url">...</a>
  ```

  其中dynamicId与isButtonDisabled都是js中的变量，可以进行操作。

  v-bind 针对class与style有增强处理，例如

  ```
  <div class="static"
       v-bind:class="{ active: isActive, 'text-danger': hasError }">
  </div>

  data: {
    isActive: true,
    hasError: false
  }

  ```

  更简洁的写法

  ```
  <div v-bind:class="classObject"></div>

  data: {
    classObject: {
      active: true,
      'text-danger': false
    }
  }

  ```

  甚至可以写成计算属性

  ```
  data: {
    isActive: true,
    error: null
  },
  computed: {
    classObject: function () {
      return {
        active: this.isActive && !this.error,
        'text-danger': this.error && this.error.type === 'fatal'
      }
    }
  }
  ```

  v-bind:style 类似




4. v-if 条件渲染

  v-if是一个指令，指令需要放在元素上，可以使用\<template\>包裹多个元素，使用v-if进行条件渲染
  最终\<template\>不会被渲染出来。

  ```
  <template v-if="ok">
    <h1>Title</h1>
    <p>Paragraph 1</p>
    <p>Paragraph 2</p>
  </template>
  ```

  v-else-if / v-else 可以用来表示else块
  必须跟在v-if后面。

  **使用v-if切换两个相同的元素时，可能会出现内容没有被清除的情况，此时需要给元素加上不同的key来区分**




5. v-on 缩写 @

  ```
  <a v-on:click="doSomething">...</a>

  <a @click="doSomething">...</a>
  ```

  v-on:click="" 后面可以是javascript代码、方法名

  ```
  <div id="example-2">
    <!-- `greet` 是在下面定义的方法名 -->
    <button v-on:click="greet">Greet</button>
  </div>
  var example2 = new Vue({
    el: '#example-2',
    data: {
      name: 'Vue.js'
    },
    // 在 `methods` 对象中定义方法
    methods: {
      greet: function (event) {
        // `this` 在方法里指向当前 Vue 实例
        alert('Hello ' + this.name + '!')
        // `event` 是原生 DOM 事件
        if (event) {
          alert(event.target.tagName)
        }
      }
    }
  })
  ```

  v-on 支持事件修饰符

    - .stop （停止事件传播）
    - .prevent  （阻止原本事件）
    - .capture  
    - .self
    - .once
    - .passive

    按键修饰符部分(可以用键值或者别名.enter 等同 .13)

    - .enter
    - .tab
    - .delete (捕获“删除”和“退格”键)
    - .esc
    - .space
    - .up
    - .down
    - .left
    - .right



    ```
    <!-- 阻止单击事件继续传播 -->
    <a v-on:click.stop="doThis"></a>

    <!-- 提交事件不再重载页面 -->
    <form v-on:submit.prevent="onSubmit"></form>

    <!-- 修饰符可以串联 -->
    <a v-on:click.stop.prevent="doThat"></a>

    <!-- 只有修饰符 -->
    <form v-on:submit.prevent></form>

    <!-- 添加事件监听器时使用事件捕获模式 -->
    <!-- 即元素自身触发的事件先在此处处理，然后才交由内部元素进行处理 -->
    <div v-on:click.capture="doThis">...</div>

    <!-- 只当在 event.target 是当前元素自身时触发处理函数 -->
    <!-- 即事件不是从内部元素触发的 -->
    <div v-on:click.self="doThat">...</div>
    ```



6. v-model

  一般用于表单元素 \<input\>、\<textarea\> 及 \<select\>元素上创建双向数据绑定。

  ```
  文本
  <input v-model="message" placeholder="edit me">
  <p>Message is: {{ message }}</p>

  <span>Multiline message is:</span>
  <p style="white-space: pre-line;">{{ message }}</p>
  <br>
  <textarea v-model="message" placeholder="add multiple lines"></textarea>

  <input type="checkbox" id="checkbox" v-model="checked">
  <label for="checkbox">{{ checked }}</label>

  <div id='example-3'>
    <input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
    <label for="jack">Jack</label>
    <input type="checkbox" id="john" value="John" v-model="checkedNames">
    <label for="john">John</label>
    <input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
    <label for="mike">Mike</label>
    <br>
    <span>Checked names: {{ checkedNames }}</span>
  </div>
  new Vue({
    el: '#example-3',
    data: {
      checkedNames: []
    }
  })


  <div id="example-4">
    <input type="radio" id="one" value="One" v-model="picked">
    <label for="one">One</label>
    <br>
    <input type="radio" id="two" value="Two" v-model="picked">
    <label for="two">Two</label>
    <br>
    <span>Picked: {{ picked }}</span>
  </div>
  new Vue({
    el: '#example-4',
    data: {
      picked: ''
    }
  })

  ```

  v-model 会默认将表单元素的value作为

7. v-show

  相比v-if就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地基于 CSS 进行切换。

8. v-for

  ```
  <ul id="example-1">
    <li v-for="item in items">
      {{ item.message }}
    </li>
  </ul>
  var example1 = new Vue({
    el: '#example-1',
    data: {
      items: [
        { message: 'Foo' },
        { message: 'Bar' }
      ]
    }
  })

  ```

  在 v-for 块中，我们拥有对父作用域属性的完全访问权限。v-for 还支持一个可选的第二个参数为当前项的索引。

  ```
  <ul id="example-2">
    <li v-for="(item, index) in items">
      {{ parentMessage }} - {{ index }} - {{ item.message }}
    </li>
  </ul>
  var example2 = new Vue({
    el: '#example-2',
    data: {
      parentMessage: 'Parent',
      items: [
        { message: 'Foo' },
        { message: 'Bar' }
      ]
    }
  })
  ```

  当作为数据源的数组发生变化时，v-for所渲染出的元素也会跟着变化
  会引起元素变化的数组操作：
    - push()
    - pop()
    - shift()
    - unshift()
    - splice()
    - sort()
    - reverse()

  不会引起元素变化的操作：
    - 利用索引直接操作某个值，例如：vm.items[indexOfItem] = newValue
    - 修改数组的长度时，例如：vm.items.length = newLength

    可以使用set / vm.$set 来替代。

  **注意:**
  **对象** 的属性并不能像 **数组** 那样随意增加然后引起元素变化
  需要使用 vm.$set 实例方法，它只是全局 Vue.set 的别名

  ```
  Vue.set(object, key, value)

  var vm = new Vue({
    data: {
      userProfile: {
        name: 'Anika'
      }
    }
  })
  ```

  作为数据源的数组，可以是一个计算属性或者方法

  ```
  <li v-for="n in even(numbers)">{{ n }}</li>

  data: {
    numbers: [ 1, 2, 3, 4, 5 ]
  },
  methods: {
    even: function (numbers) {
      return numbers.filter(function (number) {
        return number % 2 === 0
      })
    }
  }
  ```

  也可以使用\<template\>作为一个不会被渲染的元素，包裹若干个要渲染的元素。

  **v-for优先度比v-if高**


计算属性

**对于复杂逻辑，应当使用计算属性**
**计算属性对比方法(method)的优势，在值发生变化前计算属性不会重新计算，节省了一定的性能**

  ```
  <div id="example">
    <p>Original message: "{{ message }}"</p>
    <p>Computed reversed message: "{{ reversedMessage }}"</p>
  </div>

  var vm = new Vue({
    el: '#example',
    data: {
      message: 'Hello'
    },
    computed: {
      // 计算属性的 getter
      reversedMessage: function () {
        // `this` 指向 vm 实例
        return this.message.split('').reverse().join('')
      }
    }
  })
  ```

  结果：

  Original message: "Hello"

  Computed reversed message: "olleH"

  值得注意的是，不论是计算属性还是方法（method），虽然在编写时是在computed/method下，最终执行时，this都是指向vue实例，所以，计算属性跟方法都不能使用箭头函数
