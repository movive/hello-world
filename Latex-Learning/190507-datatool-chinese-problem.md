datatool无法自动将带有中文字符的csv表格首行设为header，推测原因是设置header的同时datatool将csv首行各项设为keys，而keys不能赋予中文字符。解决方式是载入表格时用`header=`来设置header，利用`autokeys`选项自动设置keys，避免csv首行被设置成keys或者利用`keys={1,2,3,4,5,6}来自行设置keys。代码如下

`\DTLloaddb{header={编号,姓名,生日},autokeys}{name.csv}`