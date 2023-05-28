import 'package:flutter/material.dart';
// import 'package:kingcustomer/Screens/Chat/aggrement_message.dart';
// import 'package:kingcustomer/Screens/loginSignup/mytextfield.dart';
// import 'package:kingcustomer/models/contractor_model.dart';
// import 'package:kingcustomer/providers/message_provider.dart';
// import 'package:provider/provider.dart';
// import '../../helper/size_configuration.dart';
// import '../../providers/agreement_provider.dart';
// import '../../providers/chat_provider.dart';
// import '../../widgets/are_you_sure.dart';
import '../core/size_configuration.dart';
import '../core/mytextfield.dart';

class Inbox extends StatefulWidget {
  const Inbox({
    super.key,
  });

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  final TextEditingController _textController = TextEditingController();

  final bool isOpposite = true;

  @override
  Widget build(BuildContext context) {
    // Future<void>.delayed(const Duration(seconds: 1))
    //     .then((value) => _onRefresh());
    // final messageProvider = Provider.of<MessageProvider>(context);
    // final messageList = messageProvider.getSortedList(widget.user.userID);
    // messageProvider.fetch();
    // final agreementProvider = Provider.of<AgreementProvider>(context);
    // agreementProvider.fetch();
    // final chatProvider = Provider.of<ChatProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
            // "${widget.user.name}",
            "Video Call",
            style: const TextStyle(
              color: Colors.white,
              fontSize: (kToolbarHeight / 100) * 40,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.dstATop),
                      image: AssetImage("Assets/TELEHEALTH-1.jpeg"))),
              //  color: Colors.orangeAccent[700],
              width: getProportionateScreenWidth(900),
              height: getProportionateScreenHeight(800),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child:

              //   ListView.separated(
              //     reverse: true,
              //     separatorBuilder: (context, index) => SizedBox(
              //       height: getProportionateScreenHeight(10),
              //     ),
              //     scrollDirection: Axis.vertical,
              //     itemCount: messageList.length,
              //     itemBuilder: (context, int index) => ChangeNotifierProvider.value(
              //       value: messageList[index],
              //       child: messageList[index].agreementID == ""
              //           ? messageList[index].type!
              //               ? GestureDetector(
              //                   onLongPress: () => showDialog(
              //                     context: context,
              //                     builder: (context) => AreYouSure(
              //                         title: "Delete this message?",
              //                         onPressed: () async {
              //                           await messageProvider.deleteMessage(
              //                               messageID: messageList[index].messageID,
              //                               messagetxt:
              //                                   messageList[index].messageTxt);
              //                           Navigator.pop(context);
              //                         }),
              //                   ),
              //                   child: MyMessages(
              //                     text: messageList[index].messageTxt!,
              //                   ),
              //                 )
              //               : GestureDetector(
              //                   onLongPress: () => showDialog(
              //                         barrierDismissible: false,
              //                         context: context,
              //                         builder: (context) => AreYouSure(
              //                             title: "Delete this message? ",
              //                             onPressed: () async {
              //                               await messageProvider.deleteMessage(
              //                                   messageID:
              //                                       messageList[index].messageID,
              //                                   messagetxt:
              //                                       messageList[index].messageTxt);
              //                               Navigator.pop(context);
              //                             }),
              //                       ),
              //                   child: OppositeMessages(
              //                       text: messageList[index].messageTxt!))
              //           : GestureDetector(
              //               onLongPress: () => showDialog(
              //                 barrierDismissible: false,
              //                 context: context,
              //                 builder: (context) => AreYouSure(
              //                     title: "Delete this Agreement? ",
              //                     onPressed: () async {
              //                       await messageProvider.deleteMessage(
              //                           messageID: messageList[index].messageID,
              //                           messagetxt: messageList[index].messageTxt);
              //                       Navigator.pop(context);
              //                     }),
              //               ),
              //               child:
              //                   AgreementMsg(text: messageList[index].agreementID!),
              //             ),
              //     ),
              //     physics: const BouncingScrollPhysics(),
              //   ),
              // ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
        ),
      ),
    );
  }
}
