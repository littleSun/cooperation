import 'package:cooperation/cooperation.dart';

@pragma('vm:entry-point')
entry() {
  Cooperation.instance.addHandler('m1', (arguments) async {
    return arguments?['platform'];
  });
  Cooperation.instance.addHandler('m2', (arguments) async {
    return 'm2';
  });
}