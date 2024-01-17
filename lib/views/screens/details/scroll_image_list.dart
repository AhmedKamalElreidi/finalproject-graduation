part of 'detail_screen_imports.dart';

class ScrollImageList extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final List<String> imageList;
  final DetailsNavigationType type;

  ScrollImageList(
      {Key key,
      @required this.deviceInfo,
      @required this.imageList,
      this.type = DetailsNavigationType.Unit})
      : super(key: key);

  @override
  _ScrollImageListState createState() => _ScrollImageListState();
}

class _ScrollImageListState extends State<ScrollImageList> {
  double index = 0;
  final sliderKey = GlobalKey<CarouselSliderState>();
  final cachedProviders = <CachedNetworkImageProvider>[];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: widget.deviceInfo.localWidth,
          child: CarouselSlider(
            items: widget.imageList.map((imageLink) {
              //add image link to new provider
              if (cachedProviders.length < 3) {
                cachedProviders.add(CachedNetworkImageProvider(imageLink));
              }
              return Container(
                color: Colors.white,
                width: widget.deviceInfo.localWidth,
                height: widget.deviceInfo.localHeight / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: GestureDetector(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageLink,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    onTap: () {
                      NavigationServices.navigateTo(FullScreenImageView,
                          arguments: Arguments(
                              providers: cachedProviders,
                              initialPage: index.round()));
                    },
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: false,
              onPageChanged: (newIndex, reason) {
                setState(() {
                  index = newIndex.toDouble();
                });
              },
              height: widget.deviceInfo.localHeight,
              viewportFraction: 1.1,
              autoPlayCurve: Curves.easeInOut,
              autoPlayInterval: Duration(seconds: 10),
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
          ),
        ),
        //dots or indicators of images
        dots(index, widget.imageList.length)
      ],
    );
  }

  Widget dots(double index, int length) => DotsIndicator(
        dotsCount: length,
        position: index,
        decorator:
            DotsDecorator(color: Colors.grey, activeColor: Colors.red.shade700),
        onTap: (position) {
          //jump to the clicked index of dot
          sliderKey.currentState.pageController.animateToPage(position.toInt(),
              duration: Duration(
                milliseconds: 500,
              ),
              curve: Curves.fastLinearToSlowEaseIn);
        },
      );
}
