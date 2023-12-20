import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';
import 'package:progressprodis/global/user/user_data.dart';

class AddNewGroupView extends StatefulWidget {
  const AddNewGroupView({super.key});

  @override
  State<AddNewGroupView> createState() => _AddNewGroupViewState();
}

class _AddNewGroupViewState extends State<AddNewGroupView> {
  final searchController = TextEditingController();
  List<int> selected = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Modular.to.pop(),
            child: const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text("Atras"),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => Modular.to.pop(selected),
                  child: const Text(
                    "Agregar",
                    style: TextStyle(fontSize: 13),
                  ),
                ))
          ],
          backgroundColor: AppColors.primaryDarkColor,
        ),
        body: Column(children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: TextField(
              textAlign: TextAlign.left,
              controller: searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: 'Buscar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                fillColor: Colors.grey.withOpacity(0.2),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  20,
                  (index) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.withOpacity(0.2),
                      border: Border.all(
                        width: 2,
                        style: selected.contains(index)
                            ? BorderStyle.solid
                            : BorderStyle.none,
                        color: selected.contains(index)
                            ? AppColors.lila
                            : AppColors.transparent,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (selected.contains(index)) {
                            selected.remove(index);
                          } else {
                            selected.add(index);
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                UserData.profile,
                                scale: 3,
                              ),
                              radius: 25,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Integrante",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Integrante",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          selected.contains(index)
                              ? SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 136, 199, 114),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      iconSize: 16,
                                      icon: const Icon(Icons.check),
                                      onPressed: () {},
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
