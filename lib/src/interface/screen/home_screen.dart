import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jbase_package/jbase_package.dart';
import 'package:jbase_user_interface/src/interface/component/modal/create_entity_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ControlPlane _controlPlane = ControlPlane(ControlPlaneSetting());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.circleQuestion),
            onPressed: () {},
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.github),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const CreateEntityModal());
        },
        child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Card(
            child: SizedBox(
              width: 350,
              child: Column(
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
                    itemCount: _controlPlane.entities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                  )),
                ],
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
