import 'package:flutter/material.dart';
import 'package:wanwan/commponets/line.dart';

class ShowDialog extends Dialog {
  final String negativeText;
  final String positiveText;
  final String title;
  final String msg;
  final Function positiveFun;
  final Function negativeFun;

  ShowDialog(
      {Key key,
      this.negativeText,
      this.positiveText,
      this.title,
      this.msg,
      this.positiveFun,
      this.negativeFun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        //透明层
        type: MaterialType.transparency,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                height: 180,
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            title == null ? "提示" : title,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 30, right: 30),
                          child: Center(
                            child: Text(
                              msg == null ? "" : msg,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Line(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: negativeFun != null
                                  ? negativeFun
                                  : () {
                                      Navigator.pop(context);
                                    },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2 -
                                    30.5,
                                alignment: Alignment.center,
                                height: 50,
                                child: Text(
                                  negativeText == null ? "取消" : negativeText,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 50,
                              decoration:
                                  BoxDecoration(color: Color(0xFFDDDDDD)),
                            ),
                            InkWell(
                              onTap: positiveFun != null
                                  ? () {
                                      Navigator.pop(context);
                                      positiveFun();
                                    }
                                  : () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2 -
                                    30.5,
                                alignment: Alignment.center,
                                height: 50,
                                child: Text(
                                  positiveText == null ? "确定" : positiveText,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
