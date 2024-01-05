## AutoCAD机械版

* SCALELISTEDIT（命令）

控制可用于布局视口、页面布局和打印的缩放比例的列表。

在lisp中

```markup
 i=5 ；可以是任何值，前面获取输入值
(command "-scalelistedit"
       "a"
       (strcat "1:" (rtos i))
       (strcat "1:" (rtos i))
       "e"
  )
```

可以设置比例。不论这个比例是否存在，都可以添加：

```markup
命令: -scalelistedit  
输入选项 [?/添加(A)/删除(D)/重置(R)/退出(E)] <添加>:  a
输入新比例的名称:  1:1
输入缩放比例:  1:1
输入选项 [?/添加(A)/删除(D)/重置(R)/退出(E)] <添加>:  e
```

* CANNOSCALE（系统变量）

为当前空间设置当前**注释比例**的名称。

| 类型:     | 字符串 |
| --------- | ------ |
| 保存位置: | 图形   |
| 初始值:   | 1:1    |

仅可输入图形的命名比例列表中存在的命名比例。

```markup
命令: CANNOSCALE
输入 CANNOSCALE 的新值 <"1:1.5">: 1:1
命令: CANNOSCALE
输入 CANNOSCALE 的新值 <"1:1">: 1:5
CANNOSCALE 无法设置为该值。
*无效*
```

可以看出，如果不在"scalelistedit"列表中的比例，cannoscale是不能设置的。

* DIMSCALE（系统变量）

设置应用于 **标注变量** （用于指定尺寸、距离或偏移量）的全局比例因子。

| 类型:     | 实数   |
| --------- | ------ |
| 保存位置: | 图形   |
| 初始值:   | 1.0000 |

同时还影响具有 LEADER 命令的引线对象。

使用 MLEADERSCALE 缩放通过 MLEADER 命令创建的多重引线对象。

* DIMSCALE 不影响测量的长度、坐标或角度。
* 使用 DIMSCALE 控制标注的全局比例。但是，如果当前标注样式是注释性的，则 DIMSCALE 将自动设定为零并且标注比例由 CANNOSCALE 系统变量控制。使用注释性标注时，不能将 DIMSCALE 设定为非零值。

```markup
命令: DIMSCALE
输入 DIMSCALE 的新值 <2.000>: 1.5
```

这个会影响到标注尺寸线及文字的大小。

## ZWCADM

* SCALELISTEDIT（命令）

设置可用于布局视口、页面布局和打印的默认比例列表。

在命令行输入 SCALELISTEDIT 命令，开启"编辑比例列表”对话框。

在命令行输入 SCALELISTEDIT 命令，在命令行显示提示。

```markup
命令: scalelistedit  ;这里有问题，不是我的问题，我再前面加“-”就敏感信息。
输入选项 [?/添加(A)/删除(D)/重置(R)/退出(E)] <添加>: a
输入新比例的名称: 1:1
1:1 已存在。要重定义比例吗? [是(Y)/否(N)] <否>: y
输入缩放比例: 1:1
输入选项 [?/添加(A)/删除(D)/重置(R)/退出(E)] <添加>: e
```

这里多了一个判断比例是否已经存在，如果已经存在需要输入"Y",如果不存在，提示与autoCADM一致。（不知道这里是基于什么考虑，影响了部分lisp二次开发程序直接移植，问题倒是好解决）

* CANNOSCALE（系统变量）

设置当前空间的注释比例名称。

可以使用命名比例列表中的比例名称来设置 CANNOSCALE 系统变量值。

 类型：** 字符串

 存储于：** 图形文件

 预设值：** 1:1

```markup
命令: CANNOSCALE
输入 CANNOSCALE 的新值 <"1:5">: 1:1
命令:
CANNOSCALE    ;;这里有问题，不是我的问题，我再前面加“-”就敏感信息。
输入 CANNOSCALE 的新值 <"1:1">: 1:2
CANNOSCALE 无法设置为该值。
*无效*
```

这个与autoCADM是一样的。

* DIMSCALE（系统变量）

指定标注尺寸大小、距离或偏移变量的全局比例系数。此比例的设置，还会影响到利用 LEADER 命令创建引线的比例。DIMSCALE 系统变量的设定对测量长度、坐标或角度不存在任何影响。

```markup
命令: DIMSCALE
输入 DIMSCALE 的新值 <1.000>: 5
```

这个与autoCADM也是一样的，修改其值时，标注尺寸样式大小（ACADM、ZWCADM）都不受影响。两者的标准判断的应该是其他的其他的参数。

* (ZwmGetCurDrawScale) 中望CAD机械版lisp-sdk中的内容，得到当前活动图框比例

```markup
命令: (ZwmGetCurDrawScale)
5.0
```

这个只能在用机械版，插入图幅后能用，另外发现这个比例没有对scalelistedit、CANNOSCALE的变量发生改变，改变了 **DIMSCALE的参数** 。

```markup
命令: scalelistedit
输入选项 [?/添加(A)/删除(D)/重置(R)/退出(E)] <添加>: ?
比例名称                  图纸单位     图形单位      有效比例
------------------------ ------------ ------------- -----------
1:1:1                    1            1             1
2:1:5                    1            5             0.2
```

```markup
命令: CANNOSCALE
输入 CANNOSCALE 的新值 <"1:1">: *取消*
```

```markup
命令: (ZwmGetCurDrawScale)
5.0
命令: DIMSCALE
输入 DIMSCALE 的新值 <5.0000>:
```

那么好，我们既然知道(ZwmGetCurDrawScale)修改了dimscale的值，那我们反过来试一下，修改dimscale的值，看(ZwmGetCurDrawScale)的值是否修改。

```markup
命令: DIMSCALE
输入 DIMSCALE 的新值 <5.0000>: 10
命令: (setq bOpen(Zwm_DbOpenFile ""))
T
命令: (Zwm_DbRefreshFrame)
nil
```

看来是没修改。

(这里用了两个ZWCADM-sdk命令)

;打开指定的文件，空字符表示当前文件，成功返回T，在读写图框、标题栏、明细表的数据，必须首先调用Zwm_DbOpenFile（ZWCAD机械版lisp-sdk中提到）

(setq bOpen(Zwm_DbOpenFile ""))

;;用内存数据重新刷新图框信息 （ZWCAD机械版lisp-sdk中提到）

(Zwm_DbRefreshFrame)

```markup
命令: (setq titleVaule (Zwm_TitleGetItem 12))
("比例" "SCALE" "1:5")
命令:
```

看来这个比例修改不是可逆的，应该是ZWCADM二次开发，设置比例同时，修改了dimscale的值，但不可逆。

那我们子再看一下dimscale的值，依然是不同的。

```markup
命令: DIMSCALE
输入 DIMSCALE 的新值 <10.0000>:
```

执行机械>图纸>更换比例（ZWMSWITCHSCALE），dimscale的值再次更新为所设置的比例。

```markup
命令: ZWMSWITCHSCALE   ；不是我的问题，前面需要加"_"
请选择新的绘图区域中心及更新比例的图形:
请指定目标位置:
命令: DIMSCALE
输入 DIMSCALE 的新值 <5.0000>:
```

## 结论：

1. 从上面的这些来看，autoCADM的增强尺寸标注是尺寸标注比例是靠"cannoscale"的值修改的。ZWCADM的智能标注是"dimscale"的值修改尺寸标注比例的。
2. ZWCAD机械版的默认图框使用的是自定义"scale"字段（这个是猜测）。

3.autoCADM的图框直接用的时"cannoscale"的当前比例，修改cannoscale的默认值后，更新图框是同时更新比例和图框大小的。但是为更改"dimscale"的默认值，造成cad标准标注尺寸不符合标准。

4. ZWCADM同一模型空间不同比例的图纸，用只能标注，可以识别图幅，标注比例是符合图纸比例。“dimscale”的值为最后插入的图框比例。
5. autoCADM同一模型空间不同比例的图纸，用万能标注，不能识别图框，需要手动切换“cannoscale”空间注释比例的值可以进行不同标注。"dimscale"的值未被修改。

通过上面的试验，各有优缺点。唯一的问题就是ZWCAD为什么要在(SCALELISTEDIT)命令增加了一个判断是否存在，个人觉得意义不大，只是lisp移植时出现了小插曲，功能倒是没有影响。
