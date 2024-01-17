part of 'recommend_imports.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;

  final Function(bool newValue) onChanged;
  final String title;
  final String header;
  final String subTitle;
  static int _type = 0;

  const CustomCheckBox(
      {Key key,
      @required this.header,
      @required this.value,
      @required this.onChanged,
      @required this.title,
      @required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      child: ResponsiveBuilder(
        builder: (context, deviceInfo) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(deviceInfo.localHeight * .05),
              child: CustomText(
                text: header,
                fontSize: deviceInfo.mediaQuery.size.width * .055,
                textColor: Colors.blue.shade900.withOpacity(.8),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceInfo.localWidth * .04,
                      vertical: MediaQuery.of(context).size.height * .01),
                  child: IgnorePointer(
                    ignoring: value == true,
                    child: GestureDetector(
                      onDoubleTap: () {},
                      child: Icon(
                        value == true
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.circle,
                        color: Colors.blue.shade600,
                      ),
                      onTap: () {
                        _type = 1;
                        if (onChanged != null) handleChange();
                      },
                    ),
                  ),
                ),
                CustomText(
                  text: title,
                  fontSize: deviceInfo.mediaQuery.size.width * .04,
                  textColor: Colors.black,
                  // padding: EdgeInsets.all(deviceInfo.mediaQuery.size.aspectRatio*4,)
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceInfo.localWidth * .04,
                      vertical: MediaQuery.of(context).size.height * .005),
                  child: IgnorePointer(
                    ignoring: value == false,
                    // ignoringSemantics:  value==false,
                    child: GestureDetector(
                      onDoubleTap: () {},
                      child: Icon(
                        value == false
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.circle,
                        color: Colors.blue.shade600,
                      ),
                      onTap: () {
                        _type = 2;
                        if (onChanged != null) handleChange();
                      },
                    ),
                  ),
                ),
                CustomText(
                  text: subTitle,
                  fontSize: deviceInfo.mediaQuery.size.width * .04,
                  textColor: Colors.black,
                  // padding: EdgeInsets.all(deviceInfo.mediaQuery.size.aspectRatio*4,)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleChange() {
    if (value == null) {
      if (_type == 1)
        onChanged(true);
      else
        onChanged(false);
    } else if (value == true) {
      onChanged(false);
    } else if (value == false) {
      onChanged(true);
    }
  }
}
