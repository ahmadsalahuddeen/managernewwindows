import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/elements/OrderItemWidget2.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/order_controller2.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';

class OrderpreparingWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrderpreparingWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrderpreparingWidgetState createState() => _OrderpreparingWidgetState();
}

class _OrderpreparingWidgetState extends StateMVC<OrderpreparingWidget> {
  OrderController2 _con;

  _OrderpreparingWidgetState() : super(OrderController2()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrders2();
    _con.listenForStatistics();
    _con.listenForOrderStatus(insertAll: false);
    _con.selectedStatuses = ['0'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Preparing',
          style: Theme.of(context).textTheme.headline4.merge(
                TextStyle(color: Theme.of(context).hintColor),
              ),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshOrders,
        child: ListView(
          children: [
            // Center(
            //     child: Text(
            //   'New Orders',
            //   style: Theme.of(context).textTheme.headline4.merge(
            //         TextStyle(color: Theme.of(context).hintColor),
            //       ),
            // )),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 15,
            //   ),
            //   child:
            // Center(
            //   child: ListTile(
            //     dense: true,
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 0, horizontal: 40),
            //     // leading: Icon(
            //     //   Icons.restaurant_menu,
            //     //   color: Theme.of(context).hintColor,
            //     // ),
            //     title: Text(
            //       "Restaurants",
            //       style: Theme.of(context).textTheme.headline4,
            //     ),
            //     subtitle: Text(
            //       "Click on the Hotel to get more details about it   ",
            //       maxLines: 2,
            //       style: Theme.of(context).textTheme.caption,
            //     ),
            //   ),
            // ),
            //),
            //StatisticsCarouselWidget(statisticsList: _con.statistics),
            Stack(
              children: [
                // _con.orderStatuses.isEmpty
                //     ? SizedBox(height: 90)
                //     : Container(
                //         height: 90,
                //         child: ListView(
                //           primary: false,
                //           shrinkWrap: true,
                //           scrollDirection: Axis.horizontal,
                //           children:
                //               List.generate(_con.orderStatuses.length, (index) {
                //             var _status = _con.orderStatuses.elementAt(index);
                //             var _selected =
                //                 _con.selectedStatuses.contains(_status.id);
                //             return Padding(
                //               padding:
                //                   const EdgeInsetsDirectional.only(start: 20),
                //               child: RawChip(
                //                 elevation: 0,
                //                 label: Text(_status.status),
                //                 labelStyle: _selected
                //                     ? Theme.of(context)
                //                         .textTheme
                //                         .bodyText2
                //                         .merge(TextStyle(
                //                             color:
                //                                 Theme.of(context).primaryColor))
                //                     : Theme.of(context).textTheme.bodyText2,
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal: 12, vertical: 15),
                //                 backgroundColor: Theme.of(context)
                //                     .focusColor
                //                     .withOpacity(0.1),
                //                 selectedColor: Theme.of(context).accentColor,
                //                 selected: _selected,
                //                 shape: StadiumBorder(
                //                     side: BorderSide(
                //                         color: Theme.of(context)
                //                             .accentColor
                //                             .withOpacity(0.9))),
                //                 showCheckmark: false,
                //                 onSelected: (bool value) {
                //                   setState(() {
                //                     if (_status.id == '0') {
                //                       _con.selectedStatuses = ['0'];
                //                     } else {
                //                       _con.selectedStatuses.removeWhere(
                //                           (element) => element == '0');
                //                     }
                //                     if (value) {
                //                       _con.selectedStatuses.add(_status.id);
                //                     } else {
                //                       _con.selectedStatuses.removeWhere(
                //                           (element) => element == _status.id);
                //                     }
                //                     _con.selectStatus(_con.selectedStatuses);
                //                   });
                //                 },
                //               ),
                //             );
                //           }),
                //         ),
                //       ),
                if (_con.orders.isEmpty)
                  EmptyOrdersWidget()
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.orders.length,
                      itemBuilder: (context, index) {
                        var _order = _con.orders.elementAt(index);
                        return OrderItem2Widget(
                          expanded: index == 0 ? true : true,
                          order: _order,
                          onCanceled: (e) {
                            _con.doCancelOrder(_order);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
