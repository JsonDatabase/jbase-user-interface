import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_user_interface/src/state_management/control_plane_cubit.dart';

class ViewFullDDLModal extends StatefulWidget {
  const ViewFullDDLModal({
    Key? key,
  }) : super(key: key);

  @override
  _ViewFullDDLModalState createState() => _ViewFullDDLModalState();
}

class _ViewFullDDLModalState extends State<ViewFullDDLModal> {
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
            Text('Full DDL',
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
                  Text(context.read<ControlPlaneCubit>().state.generateDDL()),
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
                        Clipboard.setData(ClipboardData(
                            text: context
                                .read<ControlPlaneCubit>()
                                .state
                                .generateDDL()));
                      },
                      child: const Text('Copy DDL'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<ControlPlaneCubit>().state.executeDDL();
                      },
                      child: const Text('Execute DDL'),
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
