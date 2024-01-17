part of 'detail_screen_imports.dart';

class ImageViewerScreen extends StatelessWidget {
///This widget used to display photos in full screen
  const ImageViewerScreen(
      {Key key, @required this.providers, this.initialPage = 0})
      : super(key: key);
  final List<CachedNetworkImageProvider> providers;
  final int initialPage;
  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ResponsiveBuilder(
              builder: (context, deviceInfo) => Container(
                child: SizedBox(
                  height: deviceInfo.localHeight,
                  width: deviceInfo.localWidth,
                  ///widget add from carousel plugin use to create scroll widgets
                  child: CarouselSlider.builder(
                    itemBuilder: (context, index, realIndex) =>
                        InteractiveViewer(
                      child: Image(
                        loadingBuilder: (context, child, loadingProgress) {
                          //loading finished return child of image
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              ///display loading progress
                            value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        image: providers[index],
                        width: deviceInfo.localWidth,
                        height: deviceInfo.localHeight * .5,
                      ),
                          maxScale: 4,
                          scaleEnabled: true,
                    ),
                    itemCount: providers.length,
                    options: CarouselOptions(
                        autoPlay: false,
                        height: deviceInfo.localHeight,
                        viewportFraction: 1.1,
                        autoPlayCurve: Curves.easeInOut,
                        initialPage: initialPage,
                        autoPlayInterval: Duration(seconds: 0),
                        enableInfiniteScroll: false),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => NavigationServices.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
