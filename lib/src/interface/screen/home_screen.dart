import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/modal/control_plane_setting_modal.dart';
import 'package:jbase_user_interface/src/interface/component/modal/create_entity_modal.dart';
import 'package:jbase_user_interface/src/interface/component/modal/edit_entity_modal.dart';
import 'package:jbase_user_interface/src/interface/component/modal/edit_entity_property_modal.dart';
import 'package:jbase_user_interface/src/state_management/control_plane_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Entity? _selectedEntity;
  Future<void> _showCreateEntityModal() async {
    await showDialog(
        context: context, builder: (context) => const CreateEntityModal());
    setState(() {});
  }

  Future<void> _showEditEntityModal() async {
    await showDialog(
        context: context,
        builder: (context) => EditEntityModal(entity: _selectedEntity!));
    setState(() {});
  }

  Future<void> _showEditEntityPropertyModal(
      EntityProperty entityProperty) async {
    await showDialog(
        context: context,
        builder: (context) =>
            EditEntityPropertyModal(entityProperty: entityProperty));
    setState(() {});
  }

  Future<void> _showControlPlaneSettingModal() async {
    await showDialog(
        context: context,
        builder: (context) => const ControlPlaneSettingModal());
    setState(() {});
  }

  void _openGithubLink() {
    launchUrlString('https://github.com/JsonDatabase');
  }

  void _openWikiLink() {
    launchUrlString(
        'https://github.com/JsonDatabase/jbase-user-interface/wiki');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.circleQuestion),
            onPressed: _openWikiLink,
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: _openGithubLink,
          ),
          IconButton(
              onPressed: _showControlPlaneSettingModal,
              icon: const FaIcon(FontAwesomeIcons.gear))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateEntityModal,
        child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Card(
            child: SizedBox(
              width: 350,
              child: BlocBuilder<ControlPlaneCubit, ControlPlane>(
                builder: (context, state) {
                  final bool noEntities = state.entities.isEmpty;
                  if (noEntities) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('No Entities'),
                        TextButton(
                          onPressed: _showCreateEntityModal,
                          child: const Text('Create Entity'),
                        ),
                      ],
                    );
                  }
                  return Column(
                    key: UniqueKey(),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search',
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: state.entities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Entity entity = state.entities[index];
                          return ListTile(
                            leading: const FaIcon(FontAwesomeIcons.table),
                            onTap: () {
                              setState(() {
                                _selectedEntity = entity;
                              });
                            },
                            title: Text(entity.name),
                            subtitle: Text(
                                '${entity.propertyCount} properties · ${entity.entityPropertyCount} entity properties'),
                          );
                        },
                      )),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _selectedEntity == null
                ? Container()
                : Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedEntity!.name,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ControlPlaneCubit>()
                                            .removeEntity(
                                                _selectedEntity!.name);
                                        setState(() {
                                          _selectedEntity = null;
                                        });
                                      },
                                      child: const Text("Delete")),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: _showEditEntityModal,
                                      child: const Text("Edit",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ))),
                                ],
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Key',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Type',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Default Value',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Column Type',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Primary Key',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    ..._selectedEntity!.properties
                                        .map((entityProperty) => Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            entityProperty.key),
                                                      ),
                                                      if (entityProperty
                                                              .isEntity ||
                                                          entityProperty.isList)
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _selectedEntity =
                                                                    entityProperty
                                                                        .value;
                                                              });
                                                            },
                                                            child: Text(
                                                              entityProperty
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if (!entityProperty
                                                              .isEntity &&
                                                          !entityProperty
                                                              .isList)
                                                        Expanded(
                                                          child: Text(
                                                              entityProperty
                                                                  .toString()),
                                                        ),
                                                      Expanded(
                                                        child: Text(entityProperty
                                                                .defaultValue ??
                                                            'N/A'),
                                                      ),
                                                      Expanded(
                                                        child: Text(entityProperty
                                                            .databaseManagementSystemColumnType),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                            entityProperty
                                                                    .isPrimaryKey
                                                                ? 'Yes'
                                                                : 'No'),
                                                      ),
                                                      if (entityProperty
                                                              .isList ||
                                                          entityProperty
                                                              .isEntity)
                                                        const SizedBox(
                                                            width: 100),
                                                      if (!(entityProperty
                                                              .isList ||
                                                          entityProperty
                                                              .isEntity))
                                                        InkWell(
                                                          onTap: () {
                                                            _showEditEntityPropertyModal(
                                                                entityProperty);
                                                          },
                                                          child: const SizedBox(
                                                              width: 100,
                                                              child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .edit)),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(),
                                              ],
                                            ))
                                        .toList(),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ]),
      ),
    );
  }
}
