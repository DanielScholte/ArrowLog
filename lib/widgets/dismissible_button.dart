import 'package:arrow_log/widgets/card_button.dart';
import 'package:flutter/material.dart';

class ArrowLogDismissibleButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDismiss;
  final Widget child;
  final String name;
  final EdgeInsets padding;
  final EdgeInsets margin;


  final Key key;

  ArrowLogDismissibleButton({
    @required this.key,
    @required this.onTap,
    @required this.onDismiss,
    @required this.child,
    @required this.name,
    this.padding = const EdgeInsets.all(12.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  });

  @override
  Widget build(BuildContext context) {
    return ArrowLogCardButton(
      padding: EdgeInsets.zero,
      onTap: onTap,
      margin: margin,
      includeArrow: false,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Dismissible(
          key: key,
          onDismissed: (_) => onDismiss(),
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm"),
                  content: Text("Are you sure you wish to delete this $name?"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Cancel", style: TextStyle(fontSize: 18.0),),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Delete", style: TextStyle(fontSize: 18.0, color: Colors.red),)
                    ),
                  ],
                );
              },
            );
          },
          background: getDismissableBackground(true),
          secondaryBackground: getDismissableBackground(false),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget getDismissableBackground(bool left) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: left ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          if (left)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          Text(
            'Delete $name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0
            ),
          ),
          if (!left)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}