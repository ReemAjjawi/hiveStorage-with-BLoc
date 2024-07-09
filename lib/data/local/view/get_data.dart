// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../bloc/get_data_from_bloc.dart';

// class GetFromLocal extends StatefulWidget {
//   const GetFromLocal({super.key});

//   @override
//   State<GetFromLocal> createState() => _GetFromLocalState();
// }

// class _GetFromLocalState extends State<GetFromLocal> {
//     final ScrollController scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//                 int i=0;

//     scrollController.addListener(() {
//       if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//         context.read<GetDataFromBloc>().add(LoadMoretDataEvent(pageId:i++));
//       }
//     });
//   }

//     @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:BlocConsumer<GetDataFromBloc, GetDataFromState>(
//               listener: (context, state) {},
//               builder: (context, state) {
//                 if (state is LoadingState ) {
//                  return CircularProgressIndicator();}
//                  else if( state is LocalStorageState)
//                 {
//                    return ListView.builder(
//                     controller: scrollController,
//                     itemCount: state.Data.length+1,
//                     itemBuilder: (context, index) {
//                     if(index<state.Data.length){
//                   return    ListTile(
//                       //   leading: Image.network(state.animals[index].image),
//                       title: Text(state.Data[index].name),
//                     );
                    
//                     } 
//                     else return CircularProgressIndicator() ;
//                       }  );
//                 } else {
//                   return Container(
//                     child: Text("hiiiiiiiii"),
//                   );
//                 }
//               },
//             ) ,)
//     ;
//   }
// }