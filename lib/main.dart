import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'requests/api.dart';


void main()
{
  runApp(const NasaApp());
}

class NasaApp extends StatefulWidget {
  const NasaApp({super.key});

  @override
  State<NasaApp> createState() => _NasaAppState();
}

bool _icon = false;

IconData _iconLight = Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;

ThemeData _lightTheme = ThemeData(
  primarySwatch: Colors.amber,
  brightness: Brightness.light,
);

ThemeData _darkTheme = ThemeData(
  primarySwatch: Colors.red,
  brightness: Brightness.dark,
);

class _NasaAppState extends State<NasaApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _icon ? _darkTheme : _lightTheme,
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
           IconButton(onPressed: ()
           {
              setState(()
              {
               _icon = !_icon;
              });
           }, icon: Icon(_icon ? _iconDark : _iconLight))
         ],
        ),
       body: BlocProvider(
          create: (BuildContext context) => NasaCubit(),
          child: BlocBuilder<NasaCubit, NasaState>(builder: (context, state)
         {
           if (state is NasaLoadingState)
           {
             BlocProvider.of<NasaCubit>(context).loadData();
             return const Center(child: CircularProgressIndicator());
           }
           if (state is NasaLoadedState)
           {
             return ListView.builder(
               itemCount: state.data.photos!.length,
               itemBuilder: (context, index)
                {
                  return Container(
                    height: 200,
                    width: 200,
                    child: Image.network(state.data.photos![index].imgSrc!),
                  );
                },
             );
            }
           if (state is NasaErrorState)
           {
             return const Center(child: Text("Произошла ошибка"));
           }
           return const Text("");
         },),
       )
     )
    );
  }
}
