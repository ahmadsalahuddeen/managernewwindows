import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/notification_controller.dart';

class ShoppingCartButtonWidget extends StatefulWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  @override
  _ShoppingCartButtonWidgetState createState() =>
      _ShoppingCartButtonWidgetState();
}

class _ShoppingCartButtonWidgetState
    extends StateMVC<ShoppingCartButtonWidget> {
  NotificationController _con;

  _ShoppingCartButtonWidgetState() : super(NotificationController()) {
    _con = controller;
  }

  @override
  void initState() {
    //_con.listenForCartsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/Pages', arguments: 1);
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Icon(
            Icons.refresh,
            color: this.widget.iconColor,
            size: 35,
          ),
          // Container(
          //   child: Text(
          //     _con.unReadNotificationsCount.toString(),
          //     textAlign: TextAlign.center,
          //     style: Theme.of(context).textTheme.caption.merge(
          //           TextStyle(
          //               color: Theme.of(context).primaryColor,
          //               fontSize: 8,
          //               height: 1.3),
          //         ),
          //   ),
          //   padding: EdgeInsets.all(0),
          //   decoration: BoxDecoration(
          //       color: this.widget.labelColor,
          //       borderRadius: BorderRadius.all(Radius.circular(10))),
          //   constraints: BoxConstraints(
          //       minWidth: 13, maxWidth: 13, minHeight: 13, maxHeight: 13),
          // ),
        ],
      ),
      color: Colors.transparent,
    );
  }
}
