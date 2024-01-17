part of 'add_unit_text_field.dart';

///getters of custom resell field (Abbreviation)


ResellTextField get titleTile => ResellTextField(
      controller: AddUnitState.helper.titleController,
      title: 'Title',
      keyBoardType: TextInputType.name,
    );

ResellTextField get areaTile => ResellTextField(
      controller: AddUnitState.helper.areaController,
      title: 'Area in meters',
      keyBoardType: TextInputType.number,
    );
ResellTextField get bathRoomsTile => ResellTextField(
      controller: AddUnitState.helper.bathController,
      title: 'Bathrooms',
      keyBoardType: TextInputType.number,
    );
ResellTextField get bedRoomTile => ResellTextField(
      controller: AddUnitState.helper.bedRoomController,
      title: 'Bedrooms',
      keyBoardType: TextInputType.number,
    );
ResellTextField get levelTile => ResellTextField(
      controller: AddUnitState.helper.levelController,
      title: 'Level',
      keyBoardType: TextInputType.number,
    );

ResellTextField get descriptionTile => ResellTextField(
      icon: Icons.details,
      controller: AddUnitState.helper.descriptionController,
      title: 'Description',
      keyBoardType: TextInputType.text,
    );
ResellTextField get nameTile => ResellTextField(
      controller: AddUnitState.helper.nameController,
      keyBoardType: TextInputType.name,
      title: 'Name',
      icon: Icons.person_pin,
    );
ResellTextField get emailTile => ResellTextField(
      controller: AddUnitState.helper.emailController,
      keyBoardType: TextInputType.emailAddress,
      title: 'Email',
      icon: Icons.mail,
    );
ResellTextField get phoneTile => ResellTextField(
      controller: AddUnitState.helper.phoneController,
      title: 'Phone',
      icon: Icons.phone,
      keyBoardType: TextInputType.phone,
    );
ResellTextField get priceTile => ResellTextField(
      controller: AddUnitState.helper.priceController,
      title: 'Price',
      icon: Icons.monetization_on,
      keyBoardType: TextInputType.number,
    );
