import 'package:loading_switch/loading_switch.dart';

import 'text_loading_page.dart';

class TextLoadingOption extends LoadingOption {
  TextLoadingOption() : super(loadingBuilder: (_) => TextLoadingPage());
}

class Test {
  final name;

  Test(this.name);
}

class Test11 extends Test {
  Test11(name) : super(name);
}
