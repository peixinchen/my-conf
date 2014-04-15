# CheetSheet 用来帮助记忆一些常用的命令、技巧等 #


## Vim Operation
* Proj 
    * Project ~/.vimprj/${prjname}.vimprj 快捷键\cp \C来建立project文件
    * Proj $prj_name   add path & vim
    * add project.vim 内容主要是Project ~/.vimprj/${prjname}.vimprj
* SingleCompile
*,ss* for compile, *,sr* for run

* ZZ, ZQ(save without saving)
* where am i . <c-g>, g<c-g>
* n% into the file
* %!grep %!sort 过滤

### Range ###
* lineno
* mark \`m, \`< 
* symbol .,$, %
* pattern
* offset




### motion
* 插入 i I a A o O 
* 修改 c C s S r R
* 删除 d D
* 搜索 f F t T * #
* gi 回到刚才离开插入模式的位置
* g\*, g# 部分匹配
* ]I, [I 搜索

### block
iw aw iW aW
is, ip, 
a{ ( a[ a\< a"" a'' at


### register
<C-R><register>插入register中的文字
命名寄存器和无名寄存器
@<char> 执行
q<char> 开始记录宏到寄存器

0 最后拷贝的
1 最后删除的
2-9
. 最后插入的
% 文件名
_ 黑洞寄存器

### 块编辑
o 切换块首尾



### sessions
mksession <file>
source <file>
vim -s <file>


### marks 
`<mark> 精确到字符，'<mark>精确到行
`` 最后两个位置中互相跳动
修改文字的时候非常有用 c`a
:marks查看所有的mark
大写字母做mark是全局的

### ex mode ###
:.,Gnormal .
@:
pipeline :write |!php %
q: <CR>执行当前行
<c-f>从命令行切到命令行窗口
:2,$!sort

### files ###
:find命令，通过path设置查找路径, Tab补全
%%, nochdir, <c-w>T, [N]<c-w>_
* Tab 

### Traverse ###
ve选择单词 S" 加引号
:jumps <c-o> <c-i>
:changes g; g, gi





## Bash Operation
* `man ascii` : 查看ASCII表
* `watch cmd` : 
* open $file 智能根据文件类型打开文件

## ZSH
补全，不需要从头部开始。 可以输入中间的字符进行补全

## Screen

## Php

## Python

## Mysql
忘记密码怎么办
```
mysqld --skip-grant-tables;
use mysql;
update user set password=password("520") where user="root";`
flush privileges;
```
