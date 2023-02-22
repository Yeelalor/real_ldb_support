import 'package:flutter/material.dart';

class LoadingProccess {
  Future<void> LoadingProcess(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 200.0,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.0),
                              child: Image.asset(
                                "assets/logos/logo w ldb.png",
                                height: 90.0,
                                width: 90.0,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        );
      },
    );
  }
}
