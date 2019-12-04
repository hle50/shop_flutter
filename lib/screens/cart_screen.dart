import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

import '../widgets/cart_item.dart';
import './orders_screen.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final myCart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${myCart.totalAmount}',
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text(
                      'Order now',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          myCart.items.values.toList(), myCart.totalAmount);
                      myCart.clear();
                      Navigator.of(context).pushNamed(OrdersScreen.routeName);
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: myCart.itemCount,
              itemBuilder: (ctx, i) => ItemCard(
                  myCart.items.values.toList()[i].id,
                  myCart.items.values.toList()[i].price,
                  myCart.items.values.toList()[i].quantity,
                  myCart.items.values.toList()[i].title,
                  myCart.items.keys.toList()[i]),
            ),
          )
        ],
      ),
    );
  }
}
