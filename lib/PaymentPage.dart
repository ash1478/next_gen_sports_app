import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class PaymentPage extends StatefulWidget {
  UpiIndiaResponse _upiResponse;
  PaymentPage(this._upiResponse);
  @override
  _PaymentPageState createState() => _PaymentPageState(_upiResponse);
}

class _PaymentPageState extends State<PaymentPage> {
  UpiIndiaResponse _upiResponse;
  _PaymentPageState(this._upiResponse);


  String approvalRef;
  String status;
  String txnRef;
  String resCode;
  String txnId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txnId = _upiResponse.transactionId;
    resCode = _upiResponse.responseCode;
    txnRef = _upiResponse.transactionRefId;
    status = _upiResponse.status;
    approvalRef = _upiResponse.approvalRefNo;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Transaction Id: $txnId'),
          Text('Response Code: $resCode'),
          Text('Reference Id: $txnRef'),
          Text('Status: $status'),
         // Text('Approval No: $approvalRef'),
        ],
      ),
    );
  }
}
