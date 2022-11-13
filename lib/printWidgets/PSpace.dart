import 'package:pdf/widgets.dart';

class PSpace extends StatelessWidget {
  double space;
  PSpace({this.space = 10});
  @override
  Widget build(Context context) {
    return SizedBox(
      height: space,
    );
  }
}
