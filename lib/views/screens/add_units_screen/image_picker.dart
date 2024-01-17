part of 'add_unit_text_field.dart';

//widget used to pick single image of product
class ImagePickerWidget extends StatefulWidget {
  final int imageNumber;
  static File image1, image2, image3;

  const ImagePickerWidget({Key key, this.imageNumber = 1}) : super(key: key);
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final picker = ImagePicker();
  File image;

  ///this function make image file =  null
  ///meaning that it doesn't have image
  void resetImage() {
    image = null;
    setState(() {});
  }

  ///this method used to pick image from phone either from camera or gallery.
  ///using image picker plugin .
  Future getImage(ImageSource imageSource) async {
    ///pick image from image source and store it in picked file
    final pickedFile = await picker.getImage(source: imageSource);
    setState(() {
      ///not null means that user picked image
      if (pickedFile != null) {
        image = File(pickedFile.path);

        ///image number ==> number of image in the images row
        if (widget.imageNumber == 1)
          ImagePickerWidget.image1 = File(pickedFile.path);
        else if (widget.imageNumber == 2)
          ImagePickerWidget.image2 = File(pickedFile.path);
        else
          ImagePickerWidget.image3 = File(pickedFile.path);
      } else {
        CustomDialog.showAlertDialog(context, 'No image was selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .14,
      width: MediaQuery.of(context).size.width * .3,
      margin: EdgeInsets.symmetric(horizontal: 5),

      //widget help to use multiple ui with same code and it gives as device info
      child: ResponsiveBuilder(
        builder: (context, deviceInfo) => Container(
          decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(10)),
          height: deviceInfo.orientation == Orientation.landscape
              ? deviceInfo.localHeight / 5
              : deviceInfo.localHeight / 5,
          width: deviceInfo.localWidth * .4,

          //Creates a widget that detects gestures or pressed.
          child: GestureDetector(
            child: Card(
              ///if no image selected then will display asset image
              ///else : display image from file == > picked image file
              child: image == null
                  ? Image.asset(
                      'assets/images/add.png',
                      fit: BoxFit.contain,
                    )
                  : Image.file(image),
            ),
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text(
                    "Picker",
                    style: TextStyle(color: Colors.indigo),
                  ),
                  content: Text('Choose image source'
                      // 'choose the source of image'
                      ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        getImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      isDefaultAction: true,
                      child: Text(
                        'Camera',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Gallery', // "Gallery"
                        style: TextStyle(color: Colors.indigo),
                      ),
                    )
                  ],
                ),
              );
              // await getImage();
            },
          ),
        ),
      ),
    );
  }
}
