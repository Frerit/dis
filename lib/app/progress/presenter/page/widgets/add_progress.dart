import 'package:flutter/material.dart';
import 'package:progressprodis/app/progress/domain/models/add_model.dart';

class AddProgress extends StatelessWidget {
  const AddProgress({Key? key, required this.onTap}) : super(key: key);

  final Function(AddPressedType type) onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 370,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 19, 19, 20),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 3,
            width: 100,
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.add_task),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Crear Tarea",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          const Divider(),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.add_comment),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Asignar Cliente",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          const Divider(),
          InkWell(
            onTap: () => onTap(AddPressedType.addGroup),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(Icons.add_home),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Crear Grupo",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.add_link),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Crear Plantilla",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          const Divider(),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(Icons.add_moderator),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Crear Plan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
