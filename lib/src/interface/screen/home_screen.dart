import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/form/LabelCheckBox.dart';
import 'package:jbase_user_interface/src/interface/component/modal/create_entity_modal.dart';
import 'package:jbase_user_interface/src/state_managment/control_plane_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Entity? _selectedEntity;

  void _showCreateEntityModal() {
    showDialog(
        context: context, builder: (context) => const CreateEntityModal());
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
                buildWhen: (previous, current) => true,
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
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedEntity!.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: const FaIcon(FontAwesomeIcons.trash),
                                onPressed: () {
                                  context
                                      .read<ControlPlaneCubit>()
                                      .removeEntity(_selectedEntity!.name);
                                  setState(() {
                                    _selectedEntity = null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _selectedEntity!.properties.length,
                            itemBuilder: (BuildContext context, int index) {
                              final EntityProperty property =
                                  _selectedEntity!.properties[index];
                              return ListTile(
                                title: Text(property.key),
                                subtitle: Text(property.toString()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 400,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Database Management System",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        LabelCheckBox(
                            labelText: 'MySQL',
                            value: false,
                            onChanged: (value) {}),
                        LabelCheckBox(
                            labelText: 'Postgres',
                            value: false,
                            onChanged: (value) {}),
                        LabelCheckBox(
                            labelText: 'Microsoft SQL Server',
                            value: false,
                            onChanged: (value) {}),
                        LabelCheckBox(
                            labelText: 'Oracle',
                            value: false,
                            onChanged: (value) {}),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Database Management System",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        LabelCheckBox(
                            labelText: 'MySQL',
                            value: false,
                            onChanged: (value) {}),
                        LabelCheckBox(
                            labelText: 'Postgres',
                            value: false,
                            onChanged: (value) {}),
                        LabelCheckBox(
                            labelText: 'Microsoft SQL Server',
                            value: false,
                            onChanged: (value) {}),
                        LabelCheckBox(
                            labelText: 'Oracle',
                            value: false,
                            onChanged: (value) {}),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
