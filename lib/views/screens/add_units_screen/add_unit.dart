part of 'add_unit_text_field.dart';

class AddUnit extends StatefulWidget {
  final UnitType addingType;

  const AddUnit(this.addingType);
  @override
  AddUnitState createState() => AddUnitState();
}

class AddUnitState extends State<AddUnit> {
  static ResellHelper helper = ResellHelper();

  //list of widget each one responsible of pick new image
  static List<ImagePickerWidget> imagePickerList;

  ///list of global key of type _ImagePickerWidgetState,
  /// are used to access images inside this widget
  ///we have 3 images can be added so each one has its own key of state
  ///will use this list later at helper class to reset images after add is done
  static List<GlobalKey<_ImagePickerWidgetState>> keysList;

  //override initial state function to initialize each on below
  @override
  void initState() {
    helper = ResellHelper();

    keysList = [
      GlobalKey<_ImagePickerWidgetState>(),
      GlobalKey<_ImagePickerWidgetState>(),
      GlobalKey<_ImagePickerWidgetState>(),
    ];
    imagePickerList = [
      ImagePickerWidget(
        imageNumber: 1,
        key: keysList[0],
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //will pop scope to detect if user try to go back and do some functions if needed
    return WillPopScope(
      onWillPop: () async {
        //load resell units again to ensure if user add new unit that it's added
        context.read<ProductsBloc>().add(LoadResellUnits());
        // true means okay you can go back
        return true;
      },
      child: Scaffold(
          appBar: MyCustomAppBar(
            leadingIcon: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                size: 32,
                color: Colors.black,
              ),
              onPressed: () {
                //load resell units again to ensure if user add new unit that it's added
                context.read<ProductsBloc>().add(LoadResellUnits());
                //go back
                NavigationServices.back();
                //reset form
                helper.cancel();
              },
            ),
            title: widget.addingType == UnitType.NormalUnit
                ? 'Add new unit'
                : "Add Unit for sell or rent",
            color: Theme.of(context).scaffoldBackgroundColor,
            showLeading: false,
          ),
          body: BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) => FutureBuilder(
              //load user data to initialize email, phone , name
              future: ProductsRepository()
                  .getUserData(FirebaseAuth.instance.currentUser.uid)
                  .timeout(Duration(seconds: 10)),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  helper.initial(snapshot.data);
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ResponsiveBuilder(
                      builder: (context, deviceInfo) => ListView(children: [
                        Container(
                          height: deviceInfo.screenHeight * .8,
                          width: deviceInfo.screenWidth,
                          child: Form(
                            key: helper.formKey,
                            child: SingleChildScrollView(
                              child: Column(children: [
                                ///row of images widget picker
                                RowOfAddedImages(),
                                //title text field
                                titleTile,
                                //tile of category
                                CustomTileResell(
                                    mainTitle: '',
                                    list: ['villa', 'apartment'],
                                    value: helper.category,
                                    hintText: 'Unit Type',
                                    dialogTileOnPressed: (value) {
                                      setState(() {
                                        helper.category = value;
                                      });
                                      Navigator.pop(context);
                                    },
                                    trailingOnPressed: () {
                                      helper.category = null;
                                      setState(() {});
                                    }),
                                //multi selected  amenities
                                Container(
                                  height: 90,
                                  width: deviceInfo.localWidth * .98,
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () async {
                                      helper.amenities =
                                          await helper._showMultiSelect(
                                              context, helper.amenities);
                                      //update the ui after picked
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Icon(
                                          helper.amenities.isEmpty
                                              ? Icons.circle
                                              : Icons.check_circle,
                                          color: helper.amenities.isEmpty
                                              ? Colors.grey
                                              : Colors.green,
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Expanded(
                                          child: CustomText(
                                            fontSize: 18,
                                            maxLines: 5,
                                            // textAlign: TextAlign.left/,
                                            text: helper.amenities.isNotEmpty
                                                ? helper.amenities.join(', ')
                                                : 'Amenities',
                                            textColor: helper.amenities.isEmpty
                                                ? Colors.grey
                                                : Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                //Control whether the given child is visible.
                                Visibility(
                                  visible:
                                      widget.addingType == UnitType.NormalUnit,
                                  child: CustomTileResell(
                                      mainTitle: '',
                                      list: context
                                          .read<ProductsBloc>()
                                          .compounds
                                          .map(
                                            (_compound) => _compound.name,
                                          )
                                          .toList(),
                                      value: helper.compoundName,
                                      hintText: 'Compound',
                                      dialogTileOnPressed: (value) {
                                        setState(() {
                                          helper.compoundName = value;
                                        });
                                        Navigator.pop(context);
                                      },
                                      trailingOnPressed: () {
                                        helper.compoundName = null;
                                        setState(() {});
                                      }),
                                ),
                                //area text field getter
                                areaTile,

                                //bathrooms text field getter
                                bathRoomsTile,
                                //bed rooms text field getter
                                bedRoomTile,
                                //level text field  getter
                                levelTile,

                                //Furnished
                                CustomTileResell(
                                    mainTitle: '',
                                    list: ['Yes', 'No'],
                                    value: helper.isFurnishes == true
                                        ? 'yes'
                                        : helper.isFurnishes == null
                                            ? null
                                            : 'no',
                                    hintText: 'Furnished',
                                    dialogTileOnPressed: (value) {
                                      setState(() {
                                        value.toLowerCase() == 'yes'
                                            ? helper.isFurnishes = true
                                            : helper.isFurnishes = false;
                                      });
                                      Navigator.pop(context);
                                    },
                                    trailingOnPressed: () {
                                      helper.category = null;
                                      setState(() {});
                                    }),

                                //description text field getter
                                descriptionTile,
                                //name text field getter
                                nameTile,
                                //email text field getter
                                emailTile,
                                //phone text field getter

                                phoneTile,
                                //price text field getter

                                priceTile,
                              ]),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //if all failed are filled and at least one image added
                            if (helper.formKey.currentState.validate() &&
                                (ImagePickerWidget.image1 != null) &&
                                widget.addingType != null) {
                              switch (widget.addingType) {
                                case UnitType.NormalUnit:
                                  context
                                      .read<ProductsBloc>()
                                      .add(AddNewProduct(
                                        unit: helper.fillUpUnit(
                                          context,
                                          UnitType.NormalUnit,
                                        ),
                                        image: ImagePickerWidget.image1,
                                        image2: ImagePickerWidget.image2,
                                        image3: ImagePickerWidget.image3,
                                      ));
                                  break;
                                case UnitType.ResellUnit:
                                  context
                                      .read<ProductsBloc>()
                                      .add(AddNewResellUnit(
                                        unit: helper.fillUpUnit(
                                            context, UnitType.ResellUnit),
                                        image: ImagePickerWidget.image1,
                                        image2: ImagePickerWidget.image2,
                                        image3: ImagePickerWidget.image3,
                                      ));
                                  break;
                              }
                              ///dialog (white box) displayed after adding unit
                              /// let user know if adding done correctly or errors occurred
                              ResellHelper.showCustomDialog(
                                context,
                              );

                              setState(() {
                                helper.cancel();
                              });
                            } else
                              CustomDialog.showAlertDialog(context,
                                  "Please add image and fill all data");
                          },
                          child: Container(
                            height: 75,
                            width: double.infinity,
                            color: Colors.blue,
                            alignment: Alignment.center,
                            child: CustomText(
                              text: 'Submit',
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: CustomText(
                      text: 'Error happened please check internet',
                      textColor: Colors.indigo,
                    ),
                  );
                } else
                  return Center(child: CircularProgressIndicator.adaptive());
              },
            ),
          )),
    );
  }

  @override
  void dispose() {
    helper.disposeAll();
    super.dispose();
  }
}
