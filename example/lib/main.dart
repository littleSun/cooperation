import 'package:cooperation_example/entry.dart';
import 'package:cooperation/cooperation.dart';

void main() {
}

@pragma('vm:entry-point')
entry() {
  Cooperation.instance.addHandler('m1', (arguments) async {
    return arguments?['platform'];
  });
  Cooperation.instance.addHandler('m2', (arguments) async {
    return 'm2';
  });
}