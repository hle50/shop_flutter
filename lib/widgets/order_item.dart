import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem item;

  OrderItem(this.item);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.item.amount}'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy').format(widget.item.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
                height: min(widget.item.products.length * 20.0 + 100, 180.0),
                child: ListView(
                  children: widget.item.products
                      .map((f) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(f.title, style: TextStyle(fontWeight: FontWeight.bold),),
                                Text('${f.quantity} x ${f.price}')
                              ],
                            ),
                          ))
                      .toList(),
                ))
        ],
      ),
    );
  }
}
