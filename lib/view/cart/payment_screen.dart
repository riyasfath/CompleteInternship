
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../model/cartModel.dart';

class PaymentOptionsScreen extends StatefulWidget {
  final CartModel payItem;

  const PaymentOptionsScreen({required this.payItem, Key? key}) : super(key: key);

  @override
  State<PaymentOptionsScreen> createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {

  var _razorpay = Razorpay();
  var amountController = TextEditingController();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Place order",
        style: TextStyle(color: Colors.orange)),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(

                widget.payItem.price!.toString(),
                style:const TextStyle(
                  fontSize: 100,
                  color: Colors.orange
                ),
              //
              //
              // ),
              // child: TextField(
              //   controller: amountController,
              //   decoration: InputDecoration(
              //     hintText: "Enter amount"
              //   ),
              ),

            ),
            CupertinoButton(
              color: Colors.grey,
              child: const Text("Proceed"),
              onPressed: () {
                // Make Payment
                var options = {
                  'key': 'rzp_test_N4MJdLfBtoatdt',

                  'amount': "${widget.payItem.price! * 100}", // 500.00 rs
                  'name': 'onDoor',
                  'description': 'Groceries',
                  'timeout': 300,
                  'prefill': {
                    'contact': '9496697204',
                    'email': 'riyasfath@gmail.com'
                  }
                };

                _razorpay.open(options);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
