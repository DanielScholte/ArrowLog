import 'package:arrow_log/widgets/card_button.dart';
import 'package:flutter/material.dart';

class ArrowLogDismissibleButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final Function(String) onRename;
  final Widget child;
  final String name;
  final String value;
  final EdgeInsets padding;
  final EdgeInsets margin;


  final Key key;

  ArrowLogDismissibleButton({
    @required this.key,
    @required this.onTap,
    @required this.onDelete,
    @required this.child,
    @required this.name,
    @required this.value,
    @required this.onRename,
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
          onDismissed: (_) => onDelete(),
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              TextEditingController textController = TextEditingController(
                text: value
              );

              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Enter a new name"),
                    content: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'Api Key',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor.withOpacity(.6),
                            width: 1.0
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor.withOpacity(1),
                            width: 2.0,
                          )
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("Cancel", style: TextStyle(fontSize: 18.0),),
                      ),
                      FlatButton(
                        onPressed: () {
                          if (textController.text != value) {
                            onRename(textController.text);
                          }
                          
                          Navigator.of(context).pop(false);
                        },
                        child: Text("Rename", style: TextStyle(fontSize: 18.0),),
                      ),
                    ],
                  );
                },
              );
            }

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
          background: getRenameBackground(),
          secondaryBackground: getDeleteBackground(),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget getRenameBackground() {
    return Container(
      color: Colors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          Text(
            'Rename $name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0
            ),
          ),
        ],
      ),
    );
  }

  Widget getDeleteBackground() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Delete $name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0
            ),
          ),
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