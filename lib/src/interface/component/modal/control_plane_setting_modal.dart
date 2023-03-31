import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/form/LabelCheckBox.dart';
import 'package:jbase_user_interface/src/interface/component/form/textbox.dart';
import 'package:jbase_user_interface/src/state_managment/control_plane_cubit.dart';

class ControlPlaneSettingModal extends StatefulWidget {
  const ControlPlaneSettingModal({Key? key}) : super(key: key);

  @override
  _ControlPlaneSettingModalState createState() =>
      _ControlPlaneSettingModalState();
}

class _ControlPlaneSettingModalState extends State<ControlPlaneSettingModal> {
  DatabaseType databaseType = DatabaseType.mysql;
  PrimaryKeyStrategy primaryKeyStrategy = PrimaryKeyStrategy.auto;
  PrimaryKeyIncrementStrategy primaryKeyIncrementStrategy =
      PrimaryKeyIncrementStrategy.auto;
  PrimaryKeySizeStrategy primaryKeySizeStrategy = PrimaryKeySizeStrategy.auto;
  @override
  void initState() {
    ControlPlaneSetting controlPlaneSetting =
        context.read<ControlPlaneCubit>().state.setting;
    databaseType = controlPlaneSetting.databaseType;
    primaryKeyStrategy = controlPlaneSetting.primaryKeyStrategy;
    primaryKeyIncrementStrategy =
        controlPlaneSetting.primaryKeyIncrementStrategy;
    primaryKeySizeStrategy = controlPlaneSetting.primaryKeySizeStrategy;
    super.initState();
  }

  void _updateSettings() {
    ControlPlaneSetting controlPlaneSetting = ControlPlaneSetting(
        databaseType: databaseType,
        primaryKeyStrategy: primaryKeyStrategy,
        primaryKeyIncrementStrategy: primaryKeyIncrementStrategy,
        primaryKeySizeStrategy: primaryKeySizeStrategy);
    context.read<ControlPlaneCubit>().state.setSetting(controlPlaneSetting);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 900,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 10),
            const Text(
              "Database Management System",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelCheckBox(
                    labelText: 'MySQL',
                    value: databaseType == DatabaseType.mysql,
                    onChanged: (value) {
                      setState(() {
                        databaseType = DatabaseType.mysql;
                      });
                    }),
                const SizedBox(width: 10),
                LabelCheckBox(
                    labelText: 'Postgres',
                    value: databaseType == DatabaseType.postgresql,
                    onChanged: (value) {
                      setState(() {
                        databaseType = DatabaseType.postgresql;
                      });
                    }),
                const SizedBox(width: 10),
                LabelCheckBox(
                    labelText: 'Microsoft SQL Server',
                    value: databaseType == DatabaseType.sqlserver,
                    onChanged: (value) {
                      setState(() {
                        databaseType = DatabaseType.sqlserver;
                      });
                    }),
                const SizedBox(width: 10),
                LabelCheckBox(
                    labelText: 'Oracle',
                    value: databaseType == DatabaseType.oracle,
                    onChanged: (value) {
                      setState(() {
                        databaseType = DatabaseType.oracle;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Primary Key Strategy",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelCheckBox(
                    labelText: 'Auto',
                    value: primaryKeyStrategy == PrimaryKeyStrategy.auto,
                    onChanged: (value) {
                      setState(() {
                        primaryKeyStrategy = PrimaryKeyStrategy.auto;
                      });
                    }),
                const SizedBox(width: 10),
                LabelCheckBox(
                    labelText: 'None',
                    value: primaryKeyStrategy == PrimaryKeyStrategy.none,
                    onChanged: (value) {
                      setState(() {
                        primaryKeyStrategy = PrimaryKeyStrategy.none;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Primary Key Increment Strategy",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelCheckBox(
                    labelText: 'Auto',
                    value: primaryKeyIncrementStrategy ==
                        PrimaryKeyIncrementStrategy.auto,
                    onChanged: (value) {
                      setState(() {
                        primaryKeyIncrementStrategy =
                            PrimaryKeyIncrementStrategy.auto;
                      });
                    }),
                const SizedBox(width: 10),
                LabelCheckBox(
                    labelText: 'Manual',
                    value: primaryKeyIncrementStrategy ==
                        PrimaryKeyIncrementStrategy.manual,
                    onChanged: (value) {
                      setState(() {
                        primaryKeyIncrementStrategy =
                            PrimaryKeyIncrementStrategy.manual;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Primary Key Size Strategy",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelCheckBox(
                    labelText: 'Auto',
                    value:
                        primaryKeySizeStrategy == PrimaryKeySizeStrategy.auto,
                    onChanged: (value) {
                      setState(() {
                        primaryKeySizeStrategy = PrimaryKeySizeStrategy.auto;
                      });
                    }),
              ],
            ),
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
                  onPressed: _updateSettings,
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
