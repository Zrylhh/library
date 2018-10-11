# CSS整理

### 1.字体图标

icomoon

### 2. stylish

stylish 是chrome插件
[userstyle.org](https://userstyles.org/)


### 3. 关于viewport

[移动前端开发之viewport的深入理解](https://www.cnblogs.com/2050/p/3877280.html#!comments)

主要针对移动端适配时使用

### 4. box-sizing布局

參考文檔
[css3使用box-sizing布局](https://www.cnblogs.com/ooooevan/p/5470982.html)

>css3增添了盒模型box-sizing，属性值有下面三个：

content-box：默认值，让元素维持W3C的标准盒模型。元素的宽度/高度（width/height）（所占空间）等于元素边框宽度（border）加上元素内边距（padding）加上元素内容宽度 /高度（content width/height）即：Element Width/Height = border+padding+content width/height。

border-box：让元素维持IE6及以下版本盒模型，元素的宽度/高度（所占空间）等于元素内容的宽度/高度。这里的content width/height包含了元素的border,padding,内容的width/height。即：Element Width/Height =width /height-border-padding。

inherit：继承父元素的盒模型模式。

如果使用content-box 邊框會額外佔用寬度高度，可能會破壞佈局
如果使用border-box 邊框會算在元素內部的寬度高度。


### 5. 特殊选择器 ~ > +


