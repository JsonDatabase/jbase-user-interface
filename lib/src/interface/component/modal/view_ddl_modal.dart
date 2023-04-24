import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_dropdown_box.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_text_box.dart';
import 'package:jbase_user_interface/src/state_management/control_plane_cubit.dart';

class ViewDDLModal extends StatefulWidget {
  final Entity entity;
  const ViewDDLModal({Key? key, required this.entity}) : super(key: key);

  @override
  _ViewDDLModalState createState() => _ViewDDLModalState();
}

class _ViewDDLModalState extends State<ViewDDLModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 700,
        height: 900,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Entity DDL',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(context
                      .read<ControlPlaneCubit>()
                      .state
                      .databaseManagementSystem
                      .generateEntityDDL(widget.entity)),
                  const SizedBox(height: 10),
                  Text(context
                      .read<ControlPlaneCubit>()
                      .state
                      .databaseManagementSystem
                      .generateEntityStoredProcedures(widget.entity)),
                ],
              ),
            )),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(
                            text: context
                                .read<ControlPlaneCubit>()
                                .state
                                .databaseManagementSystem
                                .generateEntityStoredProcedures(
                                    widget.entity)));
                      },
                      child: const Text('Copy SP'),
                    ),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(
                            text: context
                                .read<ControlPlaneCubit>()
                                .state
                                .databaseManagementSystem
                                .generateEntityDDL(widget.entity)));
                      },
                      child: const Text('Copy DDL'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
