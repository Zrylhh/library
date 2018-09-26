# ES5整理

## 1.严格模式
"use strict"，会对代码的规范要求提高，例如不能使用未声明的变量。

## 2.JSON对象
提供了一个全局的JSON对象，可以使用以下方法
```
JSON.parse(text [, reviver])
```
和
```
JSON.stringify(value [, replacer [, space]])
```
### `JSON.parse(text [, reviver])`
可以接受两个参数，第一个是要转换的字符串，第二个是转换时的过滤方法
```
var result = JSON.parse('{"a": 1, "b": "2"}', function(key, value){
  if (typeof value == 'string'){
    return parseInt(value);
  } else {
    return value;
  }
})

>> result.b
2
```

### `JSON.stringify(value [, replacer [, space]])`
可以接受三个参数，第一个是要转换的字符串，第二个是转换时的过滤方法,第三个是转换后的json
的缩进
>我们同样可以传递一个space参数以便获得返回结果的可读性帮助。space参数可以是个数字，表明了作缩进的JSON字符串或字符串每个水平上缩进的空格数。如果参数是个超过10的数值，或是超过10个字符的字符串，将导致取数值10或是截取前10个字符。

```
var luckyNums = JSON.stringify(nums, function(key, value) {
  if (value == 13) {
    return undefined;
  } else {
    return value;
  }
}, 2);

>> luckyNums
'{
  "first":7,
  "second":14
}'
```

## 3.附加对象
附加到Object和Array上的方法
### Object
```
Object.getPrototypeOf
Object.getOwnPropertyDescriptor
Object.getOwnPropertyNames
Object.create
Object.defineProperty
Object.defineProperties
Object.seal
Object.freeze
Object.preventExtensions
Object.isSealed
Object.isFrozen
Object.isExtensible
Object.keys
```

可以使用Object.defineProperty来定义一个对象的属性
```
var cat = {};

Object.defineProperty(cat, "name", {
  value: "Maru",
  writable: false,
  enumerable: true,
  configurable: false
});
```
当enumerable设置为false的时候，for-in循环内不会将这个属性遍历出来。

### Array

```
Array.prototype.indexOf
Array.prototype.lastIndexOf
Array.prototype.every
Array.prototype.some
Array.prototype.forEach
Array.prototype.map
Array.prototype.filter
Array.prototype.reduce
Array.prototype.reduceRight
```

可以使用Array.isArray来判断是不是一个数组对象。

```
Array.isArray("NO U")
>> false

Array.isArray(["NO", "U"])
>> true
```
