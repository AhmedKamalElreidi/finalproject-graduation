import 'package:flutter/cupertino.dart';

class Background extends StatefulWidget {
  final Widget child;
  final bool isTopImageFound;
  final String image;

  const Background({
    Key key,
    @required this.child,
    this.isTopImageFound = true,
    this.image,
  }) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  Image image1;
  Image image2;
  Image image3; //background image
  @override
  void initState() {
    image1 = Image.asset(
      "assets/images/main_top.png",
    );
    image2 = Image.asset("assets/images/login_bottom.png");
    image3 = Image.asset(widget.image ?? "assets/images/login.png");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: Image(
              image: image2.image,
              width: size.width * 0.4,
            ),
          ),
          ListView(
            physics: BouncingScrollPhysics(),
             children: [
              Image(
                image: image3.image,
                height: size.height * 0.35,
                // width: size.width * 0.7,
              ),
               widget.child,
            ],
          ),
          Visibility(
            visible: widget.isTopImageFound == true,
            child: Positioned(
              top: 0,
              left: 0,
              child: Image(
                image: image1.image,
                width: size.width * 0.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
