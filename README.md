# loading_switch
[![Pub](https://img.shields.io/pub/v/loading_switch.svg?style=flat-square)](https://pub.dartlang.org/packages/loading_switch)
[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/codingfd/loading_switch)<br>
Flutter 加载切换库
## Get started
### Add dependency
```yaml
dependencies:
  loading_switch: ^1.x
```
### Super simple to use

```dart
final String html = '''
<html>
<div><a href='https://github.com'>github.com</a></div>
<div class="head">head</div>
<table><tr><td>1</td><td>2</td><td>3</td><td>4</td></tr></table>
<div class="end">end</div>
</html>
''';

XPath.source(html).query("//div/a/text()").list()

```

more simple refer to [this](https://github.com/codingfd/xpath/blob/master/test/xpath_test.dart)

