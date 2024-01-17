part of 'add_unit_text_field.dart';

//created class contain data and widgets to help in the main add unit screen widget
class ResellHelper {
  //units type or category
  final List<String> categoriesList = ['Villa', 'Apartment'];
  //empty list of string when adding data will fill it
  List<String> amenities = [];
  //amenities static types to be used in picker
  final amenitiesList = [
    'Balcony',
    'Central A/C & Heating',
    'Security',
    'Electricity Meter',
    'Water Meter',
    'Natural Gas',
    'Covered Parking',
    'Land Line',
    'Private Garden',
    'Pets Allowed',
    'Elevator',
    'Pool'
  ];
  String category, compoundName;
  double rate;
  bool isFurnishes;
  //controller for each text field
  final emailController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final priceController = TextEditingController();
  final areaController = TextEditingController();
  final bathController = TextEditingController();
  final bedRoomController = TextEditingController();
  final levelController = TextEditingController();
  //form key to used to check for validation
  final formKey = GlobalKey<FormState>();

  ///this function used to clean all controllers and
  ///variables after adding is done or leave the adding screen
  void cancel() {
    this.levelController.clear();
    this.bedRoomController.clear();
    this.bathController.clear();
    this.areaController.clear();
    this.amenities.clear();
    this.emailController.clear();
    this.titleController.clear();
    this.descriptionController.clear();
    this.nameController.clear();
    this.phoneController.clear();

    /// are used to access images inside this widget
    ///here used to reset images after add is done
    ///image that carry the file or image file
    AddUnitState.keysList.forEach((element) {
      if (element.currentState != null) if (element.currentState.image != null)
        element.currentState.resetImage();
    });

    this.priceController.clear();

    ///after pick image each one assigned to on of the below images
    ///so this code use to ensure those files also are null after
    ///adding is done
    ImagePickerWidget.image1 = null;
    ImagePickerWidget.image2 = null;
    ImagePickerWidget.image3 = null;
    this.isFurnishes = null;
    this.compoundName = null;
    this.category = null;
  }

  ///this function used to fill up model of unit to make adding easier
  ///and return filled unit model to use it later in adding function
  ///working such as :(toJson): in the models
  UnitsModel fillUpUnit(BuildContext context, UnitType addingType) {
    var unit = UnitsModel(amenities: []);
    unit.type = this.category;
    unit.title = this.titleController.text.trim();
    unit.rate = 0;

    ///if we adding resell unit will add an empty lat and long (location)
    ///else : we will get compound location of this unit
    /// that loaded and stored at products bloc
    unit.location = (addingType == UnitType.ResellUnit)
        ? LocationModel()
        : context
            .read<ProductsBloc>()
            .compounds
            .singleWhere((element) => element.name == compoundName)
            .location;

    unit.supplierPhone = phoneController.text;

    ///if :its a normal unit will add compound id  of this unit
    ///else: will add 'none' word
    unit.compoundId = addingType == UnitType.NormalUnit
        ? context
            .read<ProductsBloc>()
            .compounds
            .where((element) => element.name == compoundName)
            .first
            .id
        : 'none';
    unit.compoundName = compoundName ?? 'none';
    unit.rate = 0.0;
    //area of unit
    unit.area = this.areaController.text + ' m2';
    unit.supplierEmail = this.emailController.text;
    unit.supplierName = this.nameController.text;
    unit.price = priceController.text.trim();
    unit.description = descriptionController.text;

    ///supplier id = current user id
    unit.supplierId = FirebaseAuth.instance.currentUser.uid;

    //fill unit amenities list from the picked list
    this.amenities.forEach((element) {
      unit.amenities.add(element);
    });

    unit.bathRooms = int.parse(this.bathController.text);
    unit.bedRooms = int.parse(this.bedRoomController.text);
    unit.furnishes = this.isFurnishes;
    unit.level = int.parse(this.levelController.text);
    return unit;
  }

  //dispose all controllers
  void disposeAll() {
    this.levelController.dispose();
    this.bedRoomController.dispose();
    this.bathController.dispose();
    this.areaController.dispose();
    AddUnitState.keysList.forEach((element) {
      if (element.currentState != null) element.currentState.resetImage();
    });
    this.emailController.dispose();
    this.titleController.dispose();
    this.descriptionController.dispose();
    this.nameController.dispose();
    this.phoneController.dispose();
    this.priceController.dispose();
  }

  ///initialize email, name, and phone be current user data.
  void initial(UserDataModel user) async {
    this.emailController.text = user.email;
    this.nameController.text = '${user.firstName} ${user.lastName}';
    this.phoneController.text = user.phone;
  }

  ///display multi select amenities to picked on adding
  Future<List<String>> _showMultiSelect(
      BuildContext context, List<String> value) async {
    List<String> newList = <String>[];

    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return Container(
          child: MultiSelectBottomSheet(
            listType: MultiSelectListType.CHIP,
            initialValue: value,
            selectedColor: Colors.blue.shade800.withOpacity(.5),
            title: Text(
              'Select Amenities',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.indigo),
            ),
//looping on static amenities types list and display item or type
            items: amenitiesList
                .map((item) => MultiSelectItem<String>(
                      item,
                      item,
                    ))
                .toList(),
            onConfirm: (items) {
              newList = items;
            },
          ),
        );
      },
    );
    return newList;
  }

  ///dialog (white box) displayed after adding unit
  ///let user know if adding done correctly or errors occurred
  static void showCustomDialog(
    BuildContext context,
  ) {
    CustomDialog.showAlertDialog(
      context,
      '',
      content: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          child: BlocBuilder<ProductsBloc, ProductsState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ProductsLoadingState)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (state is NewProductAdded) {
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_done_rounded,
                        color: Colors.green,
                        size: 55,
                      ),
                      CustomText(text: "Done", textColor: Colors.green)
                    ],
                  ),
                );
              } else if (state is ErrorState) {
                return Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 40,
                      ),
                      Text("Error occur")
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          child: CustomText(
            text: 'okay',
            textColor: Colors.deepPurpleAccent,
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
