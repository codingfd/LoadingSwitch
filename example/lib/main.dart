import 'package:flutter/material.dart';
import 'package:loading_switch/loading_switch.dart';
import 'page/default_loading_page.dart';
import 'page/default_error_page.dart';
import 'page/default_empty_page.dart';
import 'page/test_page.dart';
import 'page/text_loading_option.dart';

void main() {
  LoadingSwitch.defaultOption = LoadingOption(
      loadingBuilder: (_) => DefaultLoadingPage(),
      errorBuilder: (onWidgetTap) => DefaultErrorPage(
            onWidgetTap: onWidgetTap,
          ),
      emptyBuilder: (_) => DefaultEmptyPage());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoadingSwitch Example"),
      ),
      body: ListView(
        children: <Widget>[
          _buildItem(context, "全局配置", 1),
          _buildItem(context, "约定配置", 2),
          _buildItem(context, "单独配置", 3),
          _buildItem(context, "未定义配置", 4),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String text, int index) => SizedBox(
      width: double.infinity,
      child: FlatButton(
        child: Text(
          text,
        ),
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ExamplePage(text, index)))
        },
      ));
}

class ExamplePage extends StatelessWidget {
  final title;
  final index;

  ExamplePage(this.title, this.index);

  @override
  Widget build(BuildContext context) {
    return _buildPage();
  }

  Widget _buildPage() {
    final controller = LoadingSwitchController();
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildLoadingSwitch(controller)),
            Row(
              children: <Widget>[
                _buildButton("加载页面", () => controller.showLoading()),
                _buildButton("错误页面", () => controller.showError()),
                _buildButton("空页面", () => controller.showEmpty()),
                _buildButton("内容页面", () => controller.showContent()),
              ],
            )
          ],
        ));
  }

  LoadingSwitch _buildLoadingSwitch(LoadingSwitchController controller) {
    var child = Container(
        alignment: Alignment.center,
        child: Text(
          "content",
          style: TextStyle(fontSize: 24),
        ));

    switch (index) {
      case 1:

        ///根据全局配置初始化
        return LoadingSwitch(
          controller: controller,
          onWidgetTap: (tag) {
            print("重新加载$tag");
            controller.showLoading();
          },
          child: child,
        );

      case 2:

        ///根据option初始化
        return LoadingSwitch(
          controller: controller,
          onWidgetTap: (tag) {
            print("重新加载$tag");
            controller.showLoading();
          },
          child: child,
          option: TextLoadingOption(),
        );
      case 3:

        ///单独页面配置
        return LoadingSwitch(
          controller: controller,
          onWidgetTap: (tag) {
            print("重新加载$tag");
            controller.showLoading();
          },
          child: child,
          option: TextLoadingOption(),
          loading: DefaultLoadingPage(),
        );
      case 4:

        ///未定义枚举值的页面
        controller.switchStatus("test");
        return LoadingSwitch(
          controller: controller,
          onWidgetTap: (tag) {
            print("重新加载$tag");
            controller.showLoading();
          },
          child: child,
          others: {"test": TestPage()},
        );
    }

    return null;
  }

  Widget _buildButton(String text, VoidCallback onPressed) => Expanded(
          child: FlatButton(
        child: Text(text),
        onPressed: onPressed,
      ));
}
