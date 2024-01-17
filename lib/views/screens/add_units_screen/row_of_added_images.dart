part of 'add_unit_text_field.dart';
///row of images contains image and button on pressed will add other image to list
class RowOfAddedImages extends StatefulWidget {
  @override
  _RowOfAddedImagesState createState() => _RowOfAddedImagesState();
}

class _RowOfAddedImagesState extends State<RowOfAddedImages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FittedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: AddUnitState.imagePickerList),
            ),
            Positioned(
              right: 0,
              top: 1,
              height: 40,
              child: Visibility(
                visible: AddUnitState.imagePickerList.length < 3,
                child: FloatingActionButton(
                  heroTag: 'add',
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (AddUnitState.imagePickerList.length < 3) {
                      final index = AddUnitState.imagePickerList
                              .indexOf(AddUnitState.imagePickerList.last) +
                          2;
                      AddUnitState.imagePickerList.add(ImagePickerWidget(
                        key: AddUnitState.keysList[index - 1],
                        imageNumber: index,
                      ));
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              height: 40,
              child: Visibility(
                visible: AddUnitState.imagePickerList.length > 1,
                child: FloatingActionButton(
                  heroTag: 'remove',
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (AddUnitState.imagePickerList.length > 1) {
                      AddUnitState.imagePickerList
                          .remove(AddUnitState.imagePickerList.last);
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
