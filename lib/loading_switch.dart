import 'package:flutter/cupertino.dart';

class LoadingSwitch extends StatefulWidget {
  static LoadingOption defaultOption;

  final LoadingSwitchController controller;
  final Widget child;
  final Widget loading;
  final Widget empty;
  final Widget error;
  final Map<dynamic, Widget> others;
  final OnWidgetTap onWidgetTap;
  final LoadingOption option;

  LoadingSwitch(
      {@required this.controller,
      @required this.child,
      this.loading,
      this.empty,
      this.error,
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
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget;
    var option = widget.option ?? LoadingSwitch.defaultOption;
    var status = widget.controller.status??LoadingStatus.content;
    switch (status) {
      case LoadingStatus.loading:

        returnWidget =
            widget.loading ?? option?.loadingBuilder?.call(widget.onWidgetTap);
        break;
      case LoadingStatus.content:
        returnWidget = widget.child;
        break;
      case LoadingStatus.error:
        returnWidget = widget.error ?? option?.errorBuilder?.call(widget.onWidgetTap);
        break;
      case LoadingStatus.empty:
        returnWidget = widget.empty ?? option?.emptyBuilder?.call(widget.onWidgetTap);
        break;
      case LoadingStatus.unAuth:
        returnWidget =
            widget.empty ?? option?.unAuthBuilder?.call(widget.onWidgetTap);
        break;
      default:
        returnWidget = widget.others[status] ?? option?.buildOThor(status);
        break;
    }
    return returnWidget ?? Container();
  }
}

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

  Widget buildOThor(status) {
    return null;
  }
}

class LoadingSwitchController {
  dynamic status;
  VoidCallback _refresh = () => {};

  void config(VoidCallback refresh) {
    this._refresh = refresh;
  }

  void switchStatus(status) {
    if(this.status==status)
      return;
    this.status = status;
    _refresh();
  }

  void showLoading() => switchStatus(LoadingStatus.loading);

  void showContent() => switchStatus(LoadingStatus.content);

  void showError() => switchStatus(LoadingStatus.error);

  void showEmpty() => switchStatus(LoadingStatus.empty);

  void showUnAuth()=>switchStatus(LoadingStatus.unAuth);

  bool isLoading() => status == LoadingStatus.loading;

  bool isError() => status == LoadingStatus.error;

  bool isContent() => status == LoadingStatus.content;

  bool isEmpty() => status == LoadingStatus.empty;

  bool isUnAuth() => status == LoadingStatus.unAuth;

}

enum LoadingStatus { loading, content, error, empty, unAuth }

typedef OnWidgetTap = void Function(String);
typedef WidgetBuilder = Widget Function(OnWidgetTap);
