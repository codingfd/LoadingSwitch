# loading_switch
[![Pub](https://img.shields.io/pub/v/loading_switch.svg?style=flat-square)](https://pub.dartlang.org/packages/loading_switch)
[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/codingfd/loading_switch)<br>
Flutter加载切换库
## 预览
<img src="media/example.gif" width="375"/>


## 如何使用
### 添加依赖
```yaml
dependencies:
  loading_switch: ^1.x
```
### 如何使用

```
///控制器
final controller = LoadingSwitchController();

LoadingSwitch(
      controller: controller,
      child: child,
      loading: ...,
      error: ...,
      empty: ...,
      option: ...
    );

///显示加载中
controller.showLoading();
    
```
有如下三种方式设置加载页面
*  全局设置,在应用初始化时设置
```
LoadingSwitch.defaultOption
```
* 初始化LoadingSwitch时配置`option`属性
* 初始化LoadingSwitch时配置`loading` `error`等属性
<br>
优先级：<br>
 `loading` `error`等   >   `option`    >  `defaultOption`


<br>
具体设置请参考example


##  Example

```
cd ./example
flutter create .
flutter run
```


## License

[Apache License 2.0](https://github.com/codingfd/GestureUnlock/blob/master/LICENSE)

Copyright (c) 2018-2019 codingfd
