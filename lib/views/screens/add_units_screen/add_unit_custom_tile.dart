part of 'add_unit_text_field.dart';
///custom list tile when click on it displays alert dialog
///contains available options when user select on set this value to its value
///take a list and loop on it to display its values as text
///if on pressed function not pass(null) will display dialog , else use to on pressed that passed
class CustomTileResell extends StatefulWidget {
  final String value, hintText, mainTitle;
  final List<String> list;
  final Function onPressed;
  const CustomTileResell(
      {Key key,
      this.value,
      this.trailingOnPressed,
      this.dialogTileOnPressed(String value),
      this.list,
      this.hintText,
      this.mainTitle,
      this.onPressed})
      : super(key: key);

  final Function trailingOnPressed;
  final Function dialogTileOnPressed;

  @override
  _CustomTileResellState createState() => _CustomTileResellState();
}

class _CustomTileResellState extends State<CustomTileResell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: ListTile(
        tileColor: Colors.white,
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: widget.mainTitle,
              textColor: Colors.indigo,
            ),
            widget.value != null
                ? TextButton(
                    onPressed: () {
                      widget.trailingOnPressed();
                    },
                    child: Icon(Icons.highlight_remove_outlined))
                : Container(),
          ],
        ),
        leading: Icon(
          widget.value == null ? Icons.circle : Icons.check_circle,
          color: widget.value == null ? Colors.grey : Colors.green,
        ),
        minLeadingWidth: 5,
        horizontalTitleGap: 25,
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        onTap: () {
          //dismiss keyboard
          FocusScope.of(context).unfocus();
          //if on pressed function not pass(null) will display dialog , else use to on pressed that passed
          if (widget.onPressed == null) {
            showDialog(
                context: context,
                builder: (context) {
                  return ResponsiveBuilder(
                    builder: (context, deviceInfo) => FutureBuilder(
                      future: Future.delayed(Duration(seconds: 2)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                              child: Card(
                            child: Container(
                              height: deviceInfo.localHeight * .2,
                              width: deviceInfo.localWidth * .7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                    Color.fromRGBO(
                                        Random().nextInt(230) + 20,
                                        Random().nextInt(230) + 20,
                                        Random().nextInt(230) + 20,
                                        .80),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text('Loading...'),
                                  ),
                                ],
                              ),
                            ),
                          ));
                        else {
                          return Container(
                            width: deviceInfo.localWidth,
                            height: deviceInfo.localHeight,
                            child: AlertDialog(
                              title: Center(
                                child: CustomText(
                                  text: 'Pick one ',
                                  textColor: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: CustomText(
                                    text: 'Cancel',
                                    textColor: Colors.green.shade400,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                              content: Container(
                                width: deviceInfo.localWidth,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: widget.list
                                        .map((_widget) => ListTile(
                                              onTap: () => widget
                                                  .dialogTileOnPressed(_widget),
                                              title: CustomText(
                                                text: _widget,
                                                textColor: Colors.black54,
                                              ),
                                              // leading: Container(),
                                              trailing: Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                });
          } else
            widget.onPressed();
        },
        title: CustomText(
          text: widget.value ?? '${widget.hintText}',
          fontSize: 20,
          textColor: widget.value == null ? Colors.grey : Colors.black,
        ),
      ),
    );
  }
}
