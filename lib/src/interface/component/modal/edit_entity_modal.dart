import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_dropdown_box.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_text_box.dart';
import 'package:jbase_user_interface/src/state_management/control_plane_cubit.dart';

class EditEntityModal extends StatefulWidget {
  final Entity entity;
  const EditEntityModal({Key? key, required this.entity}) : super(key: key);

  @override
  _EditEntityModalState createState() => _EditEntityModalState();
}

class _EditEntityModalState extends State<EditEntityModal> {
  final TextEditingController _entityNameController = TextEditingController();
  String? _primaryKey;
  @override
  void initState() {
    _entityNameController.text = widget.entity.name;
    List<EntityProperty> primaryKeyProperties = widget.entity.properties
        .where((element) => element.isPrimaryKey)
        .toList();
    if (primaryKeyProperties.isNotEmpty) {
      _primaryKey = primaryKeyProperties.first.key;
    }

    super.initState();
  }

  void _saveEntity() {
    final String entityName = _entityNameController.text;
    widget.entity.name = entityName;
    if (_primaryKey != null) {
      widget.entity.properties.forEach((element) {
        element.isPrimaryKey = element.key == _primaryKey;
      });
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 700,
        height: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Entity',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 20),
            LabelTextBox(
                labelText: 'Entity / Table Name',
                controller: _entityNameController),
            const SizedBox(height: 20),
            LabelDropdownBox(
              labelText: 'Primary Key',
              items: widget.entity.properties.map((e) => e.key).toList(),
              selectedItem: _primaryKey,
              onChanged: (value) {
                setState(() {
                  _primaryKey = value;
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
                  onPressed: _saveEntity,
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
