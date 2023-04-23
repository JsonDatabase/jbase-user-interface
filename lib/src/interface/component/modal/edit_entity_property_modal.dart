import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_dropdown_box.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_text_box.dart';
import 'package:jbase_user_interface/src/state_management/control_plane_cubit.dart';

class EditEntityPropertyModal extends StatefulWidget {
  final EntityProperty entityProperty;
  const EditEntityPropertyModal({Key? key, required this.entityProperty})
      : super(key: key);

  @override
  _EditEntityPropertyModalState createState() =>
      _EditEntityPropertyModalState();
}

class _EditEntityPropertyModalState extends State<EditEntityPropertyModal> {
  final TextEditingController _defaultValueController = TextEditingController();
  String columnType = "";

  @override
  void initState() {
    _defaultValueController.text = widget.entityProperty.defaultValue ?? '';
    columnType = widget.entityProperty.databaseManagementSystemColumnType;
    super.initState();
  }

  void _saveEntityProperty() {
    final String defaultValue = _defaultValueController.text;
    if (defaultValue.isEmpty) {
      widget.entityProperty.defaultValue = null;
    } else {
      widget.entityProperty.defaultValue = defaultValue;
    }
    widget.entityProperty.databaseManagementSystemColumnType = columnType;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 700,
        height: 350,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Entity Property',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 20),
            LabelTextBox(
              labelText: 'Property Name',
              enabled: false,
              controller: TextEditingController(
                  text: widget.entityProperty.key.toString()),
            ),
            const SizedBox(height: 20),
            LabelTextBox(
              labelText: 'Default Value',
              controller: _defaultValueController,
            ),
            const SizedBox(height: 20),
            LabelDropdownBox(
              labelText: 'Column Type',
              items: context
                  .read<ControlPlaneCubit>()
                  .state
                  .databaseManagementSystem
                  .columnDataTypes(),
              selectedItem: columnType,
              onChanged: (value) {
                setState(() {
                  columnType = value ?? "";
                });
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      const Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: _saveEntityProperty,
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
