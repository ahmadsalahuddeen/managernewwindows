import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/order_controller2.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';

class Orders2Widget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  Orders2Widget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _Orders2WidgetState createState() => _Orders2WidgetState();
}

class _Orders2WidgetState extends StateMVC<Orders2Widget> {
  OrderController2 _con;

  _Orders2WidgetState() : super(OrderController2()) {
    _con = controller;
  }
  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print("Cant open whatsapp");
  }

  Future<void> _launched;
  String _phone = "9061517113";
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _con.listenForOrders();
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
          'New Orders',
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
                        return OrderItemWidget(
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
      floatingActionButton: SpeedDial(
        /// both default to 16
        // marginEnd: 18,
        marginBottom: 10,
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        /// This is ignored if animatedIcon is non null
        icon: Icons.call,
        activeIcon: Icons.close_outlined,
        iconTheme: IconThemeData(size: 30),

        /// The label of the main button.
        // label: Text("Open Speed Dial"),
        /// The active label of the main button, Defaults to label if not specified.
        // activeLabel: Text("Close Speed Dial"),
        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
        /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
        //buttonSize: 56.0,
        //visible: true,

        /// If true user is forced to close dial manually
        /// by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,

        overlayColor: Theme.of(context).primaryColor,
        overlayOpacity: 0.6,
        //onOpen: () => print('OPENING DIAL'),
        //onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Theme.of(context).primaryColor,
        //elevation: 8.0,
        shape: CircleBorder(),
        orientation: SpeedDialOrientation.Up,
        // childMarginBottom: 2,
        // childMarginTop: 2,
        //animatedIcon: AnimatedIcons.menu_close,
        // overlayOpacity: 0.6,
        children: [
          SpeedDialChild(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Theme.of(context).primaryColor,
            labelBackgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.call),
            label: "Call",
            onTap: () => setState(() {
              _launched = _makePhoneCall('tel:$_phone');
            }),
          ),

          SpeedDialChild(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Theme.of(context).primaryColor,
            labelBackgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              FontAwesomeIcons.whatsapp,
            ),
            label: "WhatsApp",
            onTap: () =>
                launchWhatsapp(number: "+919061517113", message: "hello"),
          ),

          // SpeedDialChild(
          //   backgroundColor: Theme.of(context).accentColor,
          //   foregroundColor: Theme.of(context).primaryColor,
          //   labelBackgroundColor: Theme.of(context).primaryColor,
          //   child: Icon(FontAwesomeIcons.instagram),
          //   label: "Instagram",
          //   onTap: () => _launchURL2(),
          // ),

          // SpeedDialChild(

          //   child:  Icon(FontAwesomeIcons.globe,),
          //   label: "Support / Help",
          //   onTap: () => _launchURL(),
          // ),
          // SpeedDialChild(
          //   backgroundColor: Theme.of(context).accentColor,
          //   foregroundColor: Theme.of(context).primaryColor,
          //   labelBackgroundColor: Theme.of(context).primaryColor,
          //   child: Icon(Icons.share),
          //   label: "Share The App",
          //   onTap: () => Share.share(
          //       "Download Fazmart Now https://play.google.com/store/apps/details?id=com.fazmart&hl=en_IN&gl=US"),
          // ),
        ],
      ),
    );
  }
}
