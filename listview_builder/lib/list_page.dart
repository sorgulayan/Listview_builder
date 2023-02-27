import 'package:flutter/material.dart';
import 'package:listview_builder/scheme_colors.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class Student {
  String name;
  String surname;
  String number;

  Student({required this.name, required this.surname, required this.number});
}

TextEditingController nameController = TextEditingController();
TextEditingController surnameController = TextEditingController();
TextEditingController numberController = TextEditingController();

List<Student> students = List.empty(growable: true);

int selectedIndex = -1;

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: const Text('List Builder'),
          backgroundColor: UIColors.PRIMARY_COLOR),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: surnameController,
              decoration: const InputDecoration(
                  hintText: 'Surname',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              maxLength: 15,
              decoration: const InputDecoration(
                  hintText: 'Number',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //
                    String name = nameController.text.trim();
                    String surname = surnameController.text.trim();
                    String number = numberController.text.trim();
                    if (name.isNotEmpty && number.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        surnameController.text = '';
                        numberController.text = '';
                        students.add(Student(
                            name: name, surname: surname, number: number));
                      });
                    }
                    //
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: UIColors.PRIMARY_COLOR,
                      padding: const EdgeInsets.all(18)),
                  child: const Text('Add'),
                ),
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String surname = surnameController.text.trim();
                      String number = numberController.text.trim();
                      if (name.isNotEmpty && number.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          surnameController.text = '';
                          numberController.text = '';
                          students[selectedIndex].name = name;
                          students[selectedIndex].surname = surname;
                          students[selectedIndex].number = number;
                          selectedIndex = -1;
                        });
                      }
                      //
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: UIColors.PRIMARY_COLOR,
                        padding: const EdgeInsets.all(18)),
                    child: const Text('Edit')),
              ],
            ),
            const SizedBox(height: 10),
            students.isEmpty
                ? const Text(
                    "There isn't any person",
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0
              ? const Color.fromARGB(255, 210, 35, 22)
              : Colors.blueAccent,
          foregroundColor: Colors.white,
          child: Text(
            students[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${students[index].name} ${students[index].surname}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(students[index].number),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    nameController.text = students[index].name;
                    surnameController.text = students[index].surname;
                    numberController.text = students[index].number;
                    setState(() {
                      selectedIndex = index;
                    });
                    //
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      students.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
