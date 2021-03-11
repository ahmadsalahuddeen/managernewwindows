import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/order_controller.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/order.dart';
import '../models/route_argument.dart';
import 'FoodOrderItemWidget.dart';

class OrderItem2Widget extends StatefulWidget {
  final bool expanded;
  final Order order;
  final ValueChanged<void> onCanceled;

  OrderItem2Widget({Key key, this.expanded, this.order, this.onCanceled})
      : super(key: key);

  @override
  _OrderItem2WidgetState createState() {
    return _OrderItem2WidgetState();
  }
}

class _OrderItem2WidgetState extends StateMVC<OrderItem2Widget> {
  // OrderController _con;

  // _OrderItemWidgetState() : super(OrderController()) {
  //   _con = controller;
  // }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: widget.order.active ? 1 : 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 14),
                padding: EdgeInsets.only(top: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Theme(
                  data: theme,
                  child: ExpansionTile(
                    initiallyExpanded: widget.expanded,
                    title: Column(
                      children: <Widget>[
                        Text('#${widget.order.id}',
                            style: Theme.of(context).textTheme.headline4.merge(
                                TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor))),
                        Text(
                          DateFormat('dd-MM-yyyy | h: mm a  ')
                              .format(widget.order.dateTime),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Helper.getPrice(
                            Helper.getTotalOrdersPrice(widget.order), context,
                            style: Theme.of(context).textTheme.headline4),
                        // Text(
                        //   '${widget.order.payment.method}',
                        //   style: Theme.of(context).textTheme.caption,
                        // )
                      ],
                    ),
                    children: <Widget>[
                      Column(
                          children: List.generate(
                        widget.order.foodOrders.length,
                        (indexFood) {
                          return FoodOrderItemWidget(
                              heroTag: 'mywidget.orders',
                              order: widget.order,
                              foodOrder:
                                  widget.order.foodOrders.elementAt(indexFood));
                        },
                      )),
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      //   child: Column(
                      //     children: <Widget>[
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: Text(
                      //         S.of(context).delivery_fee,
                      //         style:
                      //             Theme.of(context).textTheme.bodyText1,
                      //       ),
                      //     ),
                      //     Helper.getPrice(
                      //         widget.order.deliveryFee, context,
                      //         style:
                      //             Theme.of(context).textTheme.subtitle1)
                      //   ],
                      //),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: Text(
                      //         '${S.of(context).tax} (${widget.order.tax}%)',
                      //         style:
                      //             Theme.of(context).textTheme.bodyText1,
                      //       ),
                      //     ),
                      //     Helper.getPrice(
                      //         Helper.getTaxOrder(widget.order), context,
                      //         style:
                      //             Theme.of(context).textTheme.subtitle1)
                      //   ],
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: Text(
                      //         S.of(context).total,
                      //         style:
                      //             Theme.of(context).textTheme.bodyText1,
                      //       ),
                      //     ),
                      //     Helper.getPrice(
                      //         Helper.getTotalOrdersPrice(widget.order),
                      //         context,
                      //         style:
                      //             Theme.of(context).textTheme.headline4)
                      //   ],
                      // ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              Container(
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: <Widget>[
                    if (widget.order.canCancelOrder())
                      // FlatButton(
                      //   color: Colors.red, //Theme.of(context).accentColor,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(5))),
                      //   onPressed: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         // return object of type Dialog
                      //         return AlertDialog(
                      //           title: Wrap(
                      //             spacing: 10,
                      //             children: <Widget>[
                      //               Icon(Icons.report, color: Colors.orange),
                      //               Text(
                      //                 S.of(context).confirmation,
                      //                 style: TextStyle(color: Colors.orange),
                      //               ),
                      //             ],
                      //           ),
                      //           content: Text('Cancel the order ?'),
                      //           contentPadding: EdgeInsets.symmetric(
                      //               horizontal: 30, vertical: 25),
                      //           actions: <Widget>[
                      //             FlatButton(
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.all(
                      //                       Radius.circular(5)),
                      //                   side: BorderSide(
                      //                       color: Theme.of(context)
                      //                           .accentColor
                      //                           .withOpacity(0.5))),
                      //               child: new Text(
                      //                 S.of(context).yes,
                      //                 style: TextStyle(
                      //                     color: Theme.of(context).hintColor),
                      //               ),
                      //               onPressed: () {
                      //                 widget.onCanceled(widget.order);
                      //                 Navigator.of(context).pop();
                      //               },
                      //             ),
                      //             SizedBox(
                      //               width: 10,
                      //             ),
                      //             FlatButton(
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.all(
                      //                       Radius.circular(5)),
                      //                   side: BorderSide(
                      //                       color: Theme.of(context)
                      //                           .accentColor
                      //                           .withOpacity(0.5))),
                      //               child: new Text(
                      //                 'No',
                      //                 style: TextStyle(
                      //                     color: Theme.of(context).hintColor),
                      //               ),
                      //               onPressed: () {
                      //                 Navigator.of(context).pop();
                      //               },
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     );
                      //   },
                      //   textColor: Theme.of(context).primaryColor,
                      //   child: Wrap(
                      //     children: <Widget>[Text(S.of(context).cancel + " ")],
                      //   ),
                      //   padding: EdgeInsets.symmetric(horizontal: 10),
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                    FlatButton(
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/OrderDetails',
                            arguments: RouteArgument(id: widget.order.id));
                      },
                      textColor: Theme.of(context).primaryColor,
                      child: Text(S.of(context).view),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    // if (widget.order.canEditOrder())
                    //   FlatButton(
                    //     color: Colors.green,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(5))),
                    //     onPressed: () {
                    //       Navigator.of(context).pushNamed('/OrderEdit',
                    //           arguments: RouteArgument(id: widget.order.id));
                    //     },
                    //     textColor: Theme.of(context).primaryColor,
                    //     child: Text('Accept'),
                    //     padding:
                    //         EdgeInsets.symmetric(horizontal: 49, vertical: 0),
                    //   ),
                    // SizedBox(
                    //   width: 15,
                    // ),
                    // if (widget.order.canEditOrder())
                    //   FlatButton(
                    //     onPressed: () {
                    //       _con.doUpdateOrder(_con.order);
                    //     },
                    //     textColor: Theme.of(context).hintColor,
                    //     child: Text('accept'),
                    //     padding: EdgeInsets.symmetric(horizontal: 0),
                    //   ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(start: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 28,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: widget.order.active ? Colors.green : Colors.redAccent),
          alignment: AlignmentDirectional.center,
          child: Text(
            widget.order.active
                ? '${widget.order.orderStatus.status}'
                : S.of(context).canceled,
            maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: Theme.of(context).textTheme.caption.merge(
                TextStyle(height: 1, color: Theme.of(context).primaryColor)),
          ),
        ),
      ],
    );
  }
}
