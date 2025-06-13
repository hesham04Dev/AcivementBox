
// import '/models/PrimaryContainer.dart';
// import '/rootProvider/locale_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:localization_lite/translate.dart';
// import 'package:provider/provider.dart';



// class LangDialog extends StatelessWidget {
//   const LangDialog({super.key});
//   // int langId = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: SizedBox(
//         height: 155,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(

//               itemBuilder: (context, index) => Align( child:TextButton(
//                     onPressed: () async{
//                      await context
//                           .read<LocaleProvider>()
//                           .languageChanged(index,context);
//                       Navigator.pop(context);
//                     },
//                     child: PrimaryContainer(
//                       child: Text(
//                         Translate.supportedLangs[index],
//                         style: const TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ),
//                   ) ,alignment: AlignmentDirectional.centerStart,) ,
//               itemCount: Translate.supportedLangs.length,
//              ),
//         ),
//       ),
//     );
//   }
// }

import '/models/PrimaryContainer.dart';
import '/rootProvider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:localization_lite/translate.dart';
import 'package:provider/provider.dart';



class LangDialog extends StatelessWidget {
  const LangDialog({super.key});
  // int langId = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // height: 155,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.8, 
          minHeight: 155, // Set a minimum height
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scrollbar(
            
            thumbVisibility: true,
            child: SingleChildScrollView(
              
              child: Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(Translate.supportedLangs.length, (index)=>PrimaryContainer(
                padding: 0,
                child: TextButton(
                  onPressed: () async{
               await context
                    .read<LocaleProvider>()
                    .languageChanged(index,context);
                Navigator.pop(context);
              },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Translate.supportedLangs[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),),
                      ),
            ),
          ),
      ),)
    );
  }
}
