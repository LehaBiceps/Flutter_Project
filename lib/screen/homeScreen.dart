import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_1/requests/api.dart';
import '../theme/theme.dart';


class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: icon ? darkTheme : lightTheme,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[500],
              centerTitle: true,
              title: const Text("Фото Марса", style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
              )),
              actions: [
                IconButton(onPressed: () {
                  setState(() {
                    icon = !icon;
                  });
                }, icon: Icon(icon ? iconDark : iconLight))
              ],
              leading: IconButton(onPressed: (){
                Navigator.pushReplacementNamed(context, "/notes");
              },icon: const Icon(Icons.add),),
            ),
            body: BlocProvider(
              create: (BuildContext context) => NasaCubit(),
              child: BlocBuilder<NasaCubit, NasaState>(
                builder: (context, state) {
                  if (state is NasaLoadingState) {
                    BlocProvider.of<NasaCubit>(context).loadData();
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is NasaLoadedState) {
                    return ListView.builder(
                      itemCount: state.data.photos!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 200,
                              width: 200,
                              child: Image.network(
                                  state.data.photos![index].imgSrc!),
                            )
                        );
                      },
                    );
                  }
                  if (state is NasaErrorState) {
                    return const Center(child: Text("Произошла ошибка"));
                  }
                  return const SizedBox();
                },),
            ),
        )
    );
  }
}