import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class StripePay extends StatefulWidget {
  const StripePay({Key? key}) : super(key: key);

  @override
  State<StripePay> createState() => _StripePayState();
}

class _StripePayState extends State<StripePay> {
  Map<String, dynamic>? paymentIntemtData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Pay'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              await makePayment();
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: const Center(
                child: Text('Pay'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntemtData = await createPaymentIntent('50', 'USD');
    } catch (e) {
      //handle exceptons here
    } 
  }

  createPaymentIntent(String amount, String currency) async {
    try { 
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_type[]': 'card',


      };

      var response   =  await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'));
    } catch (e) {}
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price;
  }
}
