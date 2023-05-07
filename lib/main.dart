import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linker/constant.dart';
import 'package:linker/hive_data_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
  
  Hive.registerAdapter(LinksAdapter());
  
  await Hive.openBox<Links>('linkbox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String lable;
  late String link;
  late final Box box,alllinks;

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('linkbox');
  }

   void addlink() {

Links newlink = Links(lable, link);
box.add(newlink);


   }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              ValueListenableBuilder(valueListenable: box.listenable(), builder: (context,Box boxnew,widget){
                if (boxnew.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          }

          else {
            return ListView.builder(
              itemCount: boxnew.length,
              itemBuilder: (context, index) {
                var currentBox = boxnew;
                var Linkdata = currentBox.getAt(index)!;
                return InkWell(
                 
                  onLongPress: () => _deletelink(index),
                  child: ListTile(
                    title: Text(Linkdata.lable),
                    subtitle: Text(Linkdata.link),
                    trailing: IconButton(
                      onPressed: () => _launch(Linkdata),
                      icon: Icon(
                        Icons.launch,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }


              })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          AlertDialog(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close))
            ],
            title: const Text('Add link'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  enableIMEPersonalizedLearning: true,
                  autocorrect: true,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    lable = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter link lable')),
              const SizedBox(
                height: 30.0,
              ),
               TextField(
                  enableIMEPersonalizedLearning: true,
                  autocorrect: true,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    link = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter link')),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(onPressed: (){
                addlink();
              }, child: Text('Save'))
            ],
            ),
          );
        }),
      ),
    );
  }
  
  
  _deletelink(int index) {}
  
  _launch(int index) {}
  
 
}
