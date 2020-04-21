import 'package:flutter/cupertino.dart';

class LoadingSwitch extends StatefulWidget {
  ///全局默认配置
  static LoadingOption defaultOption;

  ///控制器
  final LoadingSwitchController controller;

  ///child
  final Widget child;

  ///加载中界面
  final Widget loading;

  ///空数据界面
  final Widget empty;

  ///错误界面
  final Widget error;

  ///未授权界面
  final Widget unAuth;

  ///其他界面
  final Map<dynamic, Widget> others;

  ///点击时间
  final OnWidgetTap onWidgetTap;

  ///界面配置
  final LoadingOption option;

  LoadingSwitch(
      {@required this.controller,
      @required this.child,
      this.loading,
      this.empty,
      this.error,
      this.unAuth,
      this.others,
      this.onWidgetTap,
      this.option});

  @override
  State<StatefulWidget> createState() {
    var state = LoadingSwitchState();
    controller.config(state._refresh);
    return state;
  }
}

class LoadingSwitchState extends State<LoadingSwitch> {
  ///重置界面
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget;
    var option = widget.option ?? LoadingSwitch.defaultOption;
    var status = widget.controller.status ?? LoadingStatus.content;
    switch (status) {
      case LoadingStatus.loading:
        returnWidget =
            widget.loading ?? option?.loadingBuilder?.call(widget.onWidgetTap);
        break;
      case LoadingStatus.content:
        returnWidget = widget.child;
        break;
      case LoadingStatus.error:
        returnWidget =
            widget.error ?? option?.errorBuilder?.call(widget.onWidgetTap);
        break;
      case LoadingStatus.empty:
        returnWidget =
            widget.empty ?? option?.emptyBuilder?.call(widget.onWidgetTap);
        break;
      case LoadingStatus.unAuth:
        returnWidget =
            widget.unAuth ?? option?.unAuthBuilder?.call(widget.onWidgetTap);
        break;
      default:
        returnWidget = widget.others[status] ?? option?.otherBuild(status);
        break;
    }
    return returnWidget ?? Container();
  }
}

///加载配置
class LoadingOption {
  final WidgetBuilder loadingBuilder;
  final WidgetBuilder emptyBuilder;
  final WidgetBuilder errorBuilder;
  final WidgetBuilder unAuthBuilder;

  LoadingOption(
      {this.loadingBuilder,
      this.emptyBuilder,
      this.errorBuilder,
      this.unAuthBuilder});

  ///根据[status]构建其他界面
  Widget otherBuild(status) {
    return null;
  }
}

class LoadingSwitchController {
  ///加载状态
  dynamic status;
  ///刷新方法
  VoidCallback _refresh;

  ///配置方法
  void config(VoidCallback refresh) {
    this._refresh = refresh;
  }

  ///切换状态
  void switchStatus(status) {
    if (this.status == status) return;
    this.status = status;
    _refresh();
  }

  ///显示加载中界面
  void showLoading() => switchStatus(LoadingStatus.loading);

  ///显示内容页面
  void showContent() => switchStatus(LoadingStatus.content);

  ///显示错误页面
  void showError() => switchStatus(LoadingStatus.error);

  ///显示空页面
  void showEmpty() => switchStatus(LoadingStatus.empty);

  ///显示未授权页面
  void showUnAuth() => switchStatus(LoadingStatus.unAuth);

  ///是否加载中页面
  bool isLoading() => status == LoadingStatus.loading;

  ///是否错误页面
  bool isError() => status == LoadingStatus.error;

  ///是否内容页面
  bool isContent() => status == LoadingStatus.content;

  ///是否空界面
  bool isEmpty() => status == LoadingStatus.empty;

  ///是否未授权页面
  bool isUnAuth() => status == LoadingStatus.unAuth;
}

enum LoadingStatus { loading, content, error, empty, unAuth }

typedef OnWidgetTap = void Function(String);
typedef WidgetBuilder = Widget Function(OnWidgetTap);
