import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/form/label_check_box.dart';
import 'package:jbase_user_interface/src/state_management/control_plane_cubit.dart';
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
  DatabaseCredentialStorage databaseCredentialStorage =
      DatabaseCredentialStorage.inMemory;
  final TextEditingController _dbHostTextEditingController =
      TextEditingController();
  final TextEditingController _dbPortTextEditingController =
      TextEditingController();
  final TextEditingController _dbNameTextEditingController =
      TextEditingController();
  final TextEditingController _dbUsernameTextEditingController =
      TextEditingController();
  final TextEditingController _dbPasswordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    ControlPlaneSetting controlPlaneSetting =
        context.read<ControlPlaneCubit>().state.setting;
    databaseType = controlPlaneSetting.databaseType;
    primaryKeyStrategy = controlPlaneSetting.primaryKeyStrategy;
    primaryKeyIncrementStrategy =
        controlPlaneSetting.primaryKeyIncrementStrategy;
    primaryKeySizeStrategy = controlPlaneSetting.primaryKeySizeStrategy;
    databaseCredentialStorage = controlPlaneSetting.databaseCredentialStorage;
    _dbHostTextEditingController.text =
        controlPlaneSetting.databaseCredential.host;
    _dbPortTextEditingController.text =
        controlPlaneSetting.databaseCredential.port;
    _dbNameTextEditingController.text =
        controlPlaneSetting.databaseCredential.database;
    _dbUsernameTextEditingController.text =
        controlPlaneSetting.databaseCredential.username;
    _dbPasswordTextEditingController.text =
        controlPlaneSetting.databaseCredential.password;

    super.initState();
  }

  void _updateSettings() {
    ControlPlaneSetting controlPlaneSetting = ControlPlaneSetting(
        databaseType: databaseType,
        primaryKeyStrategy: primaryKeyStrategy,
        primaryKeyIncrementStrategy: primaryKeyIncrementStrategy,
        primaryKeySizeStrategy: primaryKeySizeStrategy,
        databaseCredentialStorage: databaseCredentialStorage,
        databaseCredential: DatabaseCredential(
            host: _dbHostTextEditingController.text,
            port: _dbPortTextEditingController.text,
            database: _dbNameTextEditingController.text,
            username: _dbUsernameTextEditingController.text,
            password: _dbPasswordTextEditingController.text));
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
                    })
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
                    controller: _dbHostTextEditingController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LabelTextBox(
                    labelText: 'Port',
                    controller: _dbPortTextEditingController,
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
                    controller: _dbUsernameTextEditingController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LabelTextBox(
                    labelText: 'Password',
                    controller: _dbPasswordTextEditingController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LabelTextBox(
                    labelText: 'Database',
                    controller: _dbNameTextEditingController,
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
                    value: databaseCredentialStorage ==
                        DatabaseCredentialStorage.inMemory,
                    onChanged: (value) => setState(() {
                          databaseCredentialStorage =
                              DatabaseCredentialStorage.inMemory;
                        })),
                const SizedBox(width: 10),
                LabelCheckBox(
                    labelText: 'Secure Local Storage',
                    value: databaseCredentialStorage ==
                        DatabaseCredentialStorage.secureLocalStorage,
                    onChanged: (value) => setState(() {
                          databaseCredentialStorage =
                              DatabaseCredentialStorage.secureLocalStorage;
                        })),
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
