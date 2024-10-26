import 'package:flutter/material.dart';

void reusableDialog(BuildContext context, String message, dynamic Function() okBtn) {
  showDialog(
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: AlertDialog(
        content: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    message
                  ),
                )
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: TextButton(
                  onPressed: okBtn,
                  child: const Text('OK'),
                )
              )
            ],
          ),
        )
      ),
    ),
  );
}