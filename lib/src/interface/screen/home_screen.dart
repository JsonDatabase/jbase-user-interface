import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/modal/create_entity_modal.dart';
import 'package:jbase_user_interface/src/state_managment/control_plane_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                            title: Text(entity.name),
                            subtitle: Text(
                                '${entity.properties.length} properties · '),
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
            child: Card(
              child: Column(
                children: [],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
