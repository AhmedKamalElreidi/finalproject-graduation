part of 'home_assets.dart';

class LoadedListImages extends StatefulWidget {
  @override
  _LoadedListImagesState createState() => _LoadedListImagesState();
}

class _LoadedListImagesState extends State<LoadedListImages> {
  List<Image> imageList = <Image>[];

  @override
  void initState() {
    HomeAssets.imageListAssets.forEach((imageLink) {
      imageList.add(Image.asset(
        imageLink,
      ));
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Future.delayed(Duration(seconds: 1));
    imageList.forEach((_image) {
      precacheImage(_image.image, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * .7,
      child: CarouselSlider(
        items: List.generate(
            imageList.length,
            (index) => Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: imageList[index].image,
                              fit: BoxFit.cover,
                              height: size.height / 3,
                              width: size.width /*310*/,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 2),
                            child: CustomText(
                              text: HomeAssets.titlesList[index],
                              fontSize: 20,
                              maxLines: 3,
                              fontFamily: 'openSans',
                              textAlign: TextAlign.justify,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.indigo.shade900,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: size.height * .4,
                        margin: const EdgeInsets.all(10),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: CustomText(
                          text: HomeAssets.detailsList[index],
                          // fontSize: 16,
                          padding: EdgeInsets.zero,
                          maxLines: 10,
                          textAlign: TextAlign.left,

                          textStyle:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    wordSpacing: 1,
                                    fontSize: 18,
                                    height: 1.4,
                                    // fontFamily: 'akaya'
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    )
                  ],
                )),
        options: CarouselOptions(
          autoPlay: true,
          height: size.height,
          viewportFraction: 1,
          autoPlayCurve: Curves.easeInOut,
          autoPlayInterval: Duration(seconds: 10),
          initialPage: 0,
          enableInfiniteScroll: true,
        ),
      ),
    );
  }
}
