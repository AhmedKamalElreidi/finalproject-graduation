part of 'products_imports.dart';

class ProductCard extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String productTitle;

  final String productPrice;
  final double productRate;
  final double fontSize;
  final String image;
  final Color shadowColor;
  final TextStyle textStyle;
  final double elevation;
  final double cardHeight;
  final double cardWidth;
  final String imageAssetName;

  const ProductCard(
      {Key key,
      this.elevation,
      this.fontSize,
      @required this.deviceInfo,
      this.shadowColor,
      @required this.productTitle,
      this.productPrice,
      this.productRate,
      this.imageAssetName,
      this.image,
      this.textStyle,
      this.cardHeight,
      this.cardWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: shadowColor ?? Colors.white,
      elevation: elevation ?? 2,
      child: FittedBox(
        child: Container(
          height: cardHeight ?? deviceInfo.localHeight * .18,
          width: cardWidth ?? deviceInfo.localWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                    child: Icon(
                  Icons.error,
                  color: Colors.red,
                )),
                height: deviceInfo.localHeight / 4,
                width: deviceInfo.localWidth / 2.5,
                fit: BoxFit.fitHeight,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: deviceInfo.screenWidth * .01,
                    left: deviceInfo.screenWidth * .02),
                height: deviceInfo.localHeight * .25,
                width: deviceInfo.localWidth * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: productTitle,
                      textStyle: textStyle ??
                          Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: fontSize ?? 20,
                                shadows: [
                                  Shadow(color: Colors.indigo, blurRadius: 3.2)
                                ],
                                color: Colors.indigo,
                              ),
                      maxLines: 3,
                    ),
                    Visibility(
                      visible: productRate != null,
                      child: RatingBarIndicator(
                        rating: productRate ?? 0,
                        //TODO:
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: deviceInfo.localHeight / 35,
                        direction: Axis.horizontal,
                      ),
                    ),
                    Visibility(
                      visible: productPrice != null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomText(
                          text: productPrice ?? '',
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
