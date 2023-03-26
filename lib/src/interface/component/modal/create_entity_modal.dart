import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_user_interface/src/interface/component/form/textbox.dart';
import 'package:jbase_user_interface/src/state_managment/control_plane_cubit.dart';

class CreateEntityModal extends StatefulWidget {
  const CreateEntityModal({Key? key}) : super(key: key);

  @override
  _CreateEntityModalState createState() => _CreateEntityModalState();
}

class _CreateEntityModalState extends State<CreateEntityModal> {
  final TextEditingController _entityNameController = TextEditingController();
  final TextEditingController _entityJSONController = TextEditingController();

  void _createEntity() {
    final String entityName = _entityNameController.text;
    final String entityJSON = _entityJSONController.text;
    context.read<ControlPlaneCubit>().addEntity(entityName, entityJSON);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        height: 500,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create Entity',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 10),
            Textbox(
                labelText: 'Entity Name', controller: _entityNameController),
            const SizedBox(height: 10),
            Textbox(
                labelText: 'Entity JSON',
                controller: _entityJSONController,
                numberOfLines: 15),
            const SizedBox(height: 10),
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
                  onPressed: _createEntity,
                  child: const Text('Create'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
