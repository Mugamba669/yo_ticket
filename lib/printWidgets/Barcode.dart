import 'package:miic/printWidgets/PSpace.dart';
import 'package:pdf/widgets.dart';

class PBarCode extends StatelessWidget {
  PBarCode({required this.text});

  final String text;

  @override
  Widget build(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PSpace(),
        BarcodeWidget(
          data: text,
          drawText: false,
          barcode: Barcode.qrCode(),
          width: 400,
          height: 250,
        )
      ],
    );
  }
}
