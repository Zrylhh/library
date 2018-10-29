# ES6整理


### 1.let命令修饰符
let类似var，只是let只在定义的代码块内有效

```
for (let i = 0; i < 3; i++) {
  let i = 'abc';
  console.log(i);
}
// abc
// abc
// abc
```
for循环有一个特殊之处，就是设置循环变量的那部分是一个父作用域，而循环体内部是一个单独的子作用域。

let声明的变量有这么几个特点
1. **不存在变量提升**
  如果是var声明变量，可以先使用再声明,例如这样是不会报错的，只是输出undefined
  ```
  console.log(foo); // 输出undefined
  var foo = 2;
  ```
  但是let声明的变量必须先声明再使用，否则会报错。

2. **暂时性死区**
只要块级作用域内存在let命令，它所声明的变量就“绑定”（binding）这个区域，不再受外部的影响。

  ```
  var tmp = 123;

  if (true) {
    tmp = 'abc'; // ReferenceError
    let tmp;
  }
  ```

  在if的代码块中，let声明的变量就统治了这块区域，全局变量（同名的）也不能提前用。

3. **不允许重复声明**
var允许重复声明变量（同名），let不允许（在同一代码块中）

### 2.const修饰符
const就相当于常量，不可改动。
>const实际上保证的，并不是变量的值不得改动，而是变量指向的那个内存地址所保存的数据不得改动。

对于简单类型的数据，值就保存在变量指向的内存地址，因此等同于常量。复合类型的数据（主要指数组和对象），
变量指向的内存地址，保存的是一个指向实际数据的指针，此时的const只能保证这个指针是固定的（总是指向一个固定的地址），
但是所指向的数据结构是不是可变的就不能控制了。

```
const foo = {};

// 为 foo 添加一个属性，可以成功
foo.prop = 123;
foo.prop // 123

// 将 foo 指向另一个对象，就会报错
foo = {}; // TypeError: "foo" is read-only
```

### 3.变量的解构赋值
ES6 允许按照一定模式，从数组和对象中提取值，对变量进行赋值，这被称为解构（Destructuring）。
比如这样

```
let [a, b, c] = [1, 2, 3];
```

只要等号两边模式相同就能解构赋值，缺少、不能匹配模式的值会变成undefined

```
let [foo, [[bar], baz]] = [1, [[2], 3]];
foo // 1
bar // 2
baz // 3

let [ , , third] = ["foo", "bar", "baz"];
third // "baz"

let [x, , y] = [1, 2, 3];
x // 1
y // 3

let [head, ...tail] = [1, 2, 3, 4];
head // 1
tail // [2, 3, 4]

let [x, y, ...z] = ['a'];
x // "a"
y // undefined
z // []

let [foo] = [];
let [bar, foo] = [1];
bar // 1
foo // undefined

```

另一种情况是不完全解构，即等号左边的模式，只匹配一部分的等号右边的数组。这种情况下，解构依然可以成功。

```
let [x, y] = [1, 2, 3];
x // 1
y // 2

let [a, [b], d] = [1, [2, 3], 4];
a // 1
b // 2
d // 4
```

事实上，只要某种数据结构具有 Iterator 接口，都可以采用数组形式的解构赋值
所以，等号右边可以是Set、Generator函数、字符串。

```
const [a, b, c, d, e] = 'hello';
a // "h"
b // "e"
c // "l"
d // "l"
e // "o"
```

函数的参数也可以使用解构来进行赋值

```
function add([x, y]){
  return x + y;
}

add([1, 2]); // 3
```

函数参数的解构也可以使用默认值。

```
function move({x = 0, y = 0} = {}) {
  return [x, y];
}

move({x: 3, y: 8}); // [3, 8]
move({x: 3}); // [3, 0]
move({}); // [0, 0]
move(); // [0, 0]
```

#### 解构赋值的用途
  1. **交换变量的值**
  ```
  let x = 1;
  let y = 2;

  [x, y] = [y, x];
  ```

  2. **从函数返回多个值**
    函数只能返回一个值，可以将多个值组合成对象，然后再解构赋值

  3. **提取 JSON 数据**
    可以用来批量提取json对象里的数据
  ```
  let jsonData = {
    id: 42,
    status: "OK",
    data: [867, 5309]
  };

  let { id, status, data: number } = jsonData;

  console.log(id, status, number);
  // 42, "OK", [867, 5309]
  ```

  4.  **遍历map解构**

  ```
  const map = new Map();
  map.set('first', 'hello');
  map.set('second', 'world');

  for (let [key, value] of map) {
    console.log(key + " is " + value);
  }
  // first is hello
  // second is world

  // 只获取key或者只获取value
  // 获取键名
  for (let [key] of map) {
    // ...
  }

  // 获取键值
  for (let [,value] of map) {
    // ...
  }
  ```

  5. 引入模块的时候也用到了解构

  ```
  const { SourceMapConsumer, SourceNode } = require("source-map");
  ```


### 4.字符串的扩展

1. 字符的Unicode表示法
  >允许采用\uxxxx形式表示一个字符，其中xxxx表示字符的 Unicode 码点。

  ```
  "\u0061"
  // "a"
  ```

  >JavaScript 内部，字符以 UTF-16 的格式储存，每个字符固定为2个字节。对于那些需要4个字节储存的字符（Unicode 码点大于0xFFFF的字符），JavaScript 会认为它们是两个字符。

2. 字符串可以被遍历

  ```
  for (let codePoint of 'foo') {
    console.log(codePoint)
  }
  // "f"
  // "o"
  // "o"
  ```

  这种方式遍历字符串可以识别大于0xFFFF的码点

3. at()与charAt()
  at()可以识别大于0xFFFF的码点
  // at() 可能需要额外的库来实现.

4. includes(), startsWith(), endsWith()

  ```
  includes()：返回布尔值，表示是否找到了参数字符串。
  startsWith()：返回布尔值，表示参数字符串是否在原字符串的头部。
  endsWith()：返回布尔值，表示参数字符串是否在原字符串的尾部。
  ```

  ```
  let s = 'Hello world!';

  s.startsWith('Hello') // true
  s.endsWith('!') // true
  s.includes('o') // true
  ```

  这三个方法都支持第二个参数，表示开始搜索的位置。
  ```
  let s = 'Hello world!';

  s.startsWith('world', 6) // true
  s.endsWith('Hello', 5) // true
  s.includes('Hello', 6) // false
  ```

5. repeat(),padStart()，padEnd() ,matchAll()

  repeat方法返回一个新字符串，表示将原字符串重复n次。
  ```
  'x'.repeat(3) // "xxx"
  'hello'.repeat(2) // "hellohello"
  'na'.repeat(0) // ""
  ```

  padStart()用于头部补全，padEnd()用于尾部补全。
  ```
  'x'.padStart(5, 'ab') // 'ababx'
  'x'.padStart(4, 'ab') // 'abax'

  'x'.padEnd(5, 'ab') // 'xabab'
  'x'.padEnd(4, 'ab') // 'xaba'
  ```

  matchAll方法返回一个正则表达式在当前字符串的所有匹配。

6. 模板字符串

  模板字符串（template string）是增强版的字符串，用反引号（\`）标识。它可以当作普通字符串使用，也可以用来定义多行字符串，或者在字符串中嵌入变量。

  ```
  let name = "Bob", time = "today";
  `Hello ${name}, how are you ${time}?`
  ```

  首先用\`引起来，然后在内部可以使用 ${foo}来取值，类似struts1


### 5.数值的扩展

1. 二进制和八进制表示法

  ES6 提供了二进制和八进制数值的新的写法，分别用前缀0b（或0B）和0o（或0O）表示。

  ```
  // 非严格模式
  (function(){
    console.log(0o11 === 011);
  })() // true

  // 严格模式
  (function(){
    'use strict';
    console.log(0o11 === 011);
  })() // Uncaught SyntaxError: Octal literals are not allowed in strict mode.
  ```

2. Number.isFinite(), Number.isNaN()

  Number.isFinite()用来检查一个数值是否为有限的（finite），即不是Infinity。

  如果参数类型不是数值，Number.isFinite一律返回false。

  ```
  Number.isFinite(15); // true
  Number.isFinite(0.8); // true
  Number.isFinite(NaN); // false
  Number.isFinite(Infinity); // false
  Number.isFinite(-Infinity); // false
  Number.isFinite('foo'); // false
  Number.isFinite('15'); // false
  ```

  Number.isNaN()用来检查一个值是否为NaN。

  ```
  Number.isNaN(NaN) // true
  Number.isNaN(15) // false
  Number.isNaN('15') // false
  Number.isNaN(true) // false
  Number.isNaN(9/NaN) // true
  Number.isNaN('true' / 0) // true
  Number.isNaN('true' / 'true') // true
  ```

3. Number.parseInt(), Number.parseFloat()

  ES6 将全局方法parseInt()和parseFloat()，移植到Number对象上面，行为完全保持不变。

4. Number.isInteger()

  Number.isInteger()用来判断一个数值是否为整数。
  如果参数不是数值，Number.isInteger返回false。

5. Math 对象的扩展

  以下方法不是所有浏览器支持

  ```
  Math.trunc()  // Math.trunc方法用于去除一个数的小数部分，返回整数部分。
  Math.trunc(4.1) // 4
  Math.trunc(4.9) // 4

  Math.sign() // Math.sign方法用来判断一个数到底是正数、负数、还是零。对于非数值，会先将其转换为数值。
  Math.sign(-5) // -1
  Math.sign(5) // +1
  Math.sign(0) // +0
  Math.sign(-0) // -0
  Math.sign(NaN) // NaN

  ```


### 函数的扩展

1. 函数参数的默认值

  ES6 允许为函数的参数设置默认值，即直接写在参数定义的后面。

  ```
  function log(x, y = 'World') {
    console.log(x, y);
  }

  log('Hello') // Hello World
  log('Hello', 'China') // Hello China
  log('Hello', '') // Hello
  ```


2. 函数的name属性
  函数的name属性，返回该函数的函数名。

  ```
  function foo() {}
  foo.name // "foo"
  ```

  匿名函数返回空字符串

3. 箭头函数

  ES6 允许使用“箭头”（=>）定义函数。

  如果箭头函数不需要参数或需要多个参数，就使用一个圆括号代表参数部分。

  ```
  var f = () => 5;
  // 等同于
  var f = function () { return 5 };

  var sum = (num1, num2) => num1 + num2;
  // 等同于
  var sum = function(num1, num2) {
    return num1 + num2;
  };

  ```


  **使用注意点**

  1. 函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象。

  2. 不可以当作构造函数，也就是说，不可以使用new命令，否则会抛出一个错误。

  3. 不可以使用arguments对象，该对象在函数体内不存在。如果要用，可以用 rest 参数代替。

  4. 不可以使用yield命令，因此箭头函数不能用作 Generator 函数。

  第一点尤其要注意

  ```
  function Timer() {
    this.s1 = 0;
    this.s2 = 0;
    // 箭头函数
    setInterval(() => this.s1++, 1000);
    // 普通函数
    setInterval(function () {
      this.s2++;
    }, 1000);
  }

  var timer = new Timer();

  setTimeout(() => console.log('s1: ', timer.s1), 3100);
  setTimeout(() => console.log('s2: ', timer.s2), 3100);
  // s1: 3
  // s2: 0
  ```

  ### ... 对象展开运算符
  [tc39/proposal-object-rest-spread](https://github.com/tc39/proposal-object-rest-spread)
  [ES6展开运算符的6种妙用](https://www.jianshu.com/p/c5230c11781b)
