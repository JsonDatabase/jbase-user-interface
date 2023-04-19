import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_check_box.dart';
import 'package:jbase_user_interface/src/state_managment/control_plane_cubit.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_text_box.dart';

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
            Row(
              children: [
                Text('Settings',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .titleLarge!
                        .copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Text('DDL Generation Strategy',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 5),
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
            Row(children: [
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
            ]),
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
            const SizedBox(height: 10),
            Text('Database Connection',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: LabelTextBox(
                    labelText: 'Host',
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LabelTextBox(
                    labelText: 'Port',
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: LabelTextBox(
                    labelText: 'Username',
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LabelTextBox(
                    labelText: 'Password',
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LabelTextBox(
                    labelText: 'Database',
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              "Credential Storage",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                LabelCheckBox(
                    labelText: 'In-Memory',
                    value: false,
                    onChanged: (value) {}),
                const SizedBox(width: 10),
                LabelCheckBox(
                    labelText: 'Secure Local Storage',
                    value: false,
                    onChanged: (value) {}),
              ],
            ),
            const SizedBox(height: 10),
            Text('Other Settings',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 5),
            const Text(
              "Project File",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Import'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Export'),
                ),
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
