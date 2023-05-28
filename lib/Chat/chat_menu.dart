// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/size_configuration.dart';
// import 'package:kingcustomer/Screens/Chat/chat_inbox.dart';
// import 'package:kingcustomer/models/contractor_model.dart';
// import 'package:kingcustomer/providers/message_provider.dart';
// import 'package:kingcustomer/widgets/are_you_sure.dart';
// import 'package:provider/provider.dart';

// import '../../helper/size_configuration.dart';
// import '../../models/chat_model.dart';
// import '../../providers/chat_provider.dart';
// import '../../providers/contractor_provider.dart';

class ChatMenu extends StatefulWidget {
  const ChatMenu({super.key});

  @override
  State<ChatMenu> createState() => _ChatMenuState();
}

class _ChatMenuState extends State<ChatMenu> {
  @override
  Widget build(BuildContext context) {
    // final chatProvider = Provider.of<ChatProvider>(context);

    // final msgProvider = Provider.of<MessageProvider>(context);
    // final chatList = chatProvider.getList;
    // final userProvider = Provider.of<ContractorsProvider>(context);

    // Future<void> _onRefresh() async {
    //   setState(() {});
    //   await chatProvider.fetch();
    // }

    // final user = userProvider.getUserByID(chatList[index].otherID);
    return Scaffold(
        appBar: AppBar(
          leadingWidth: getProportionateScreenWidth(40),
          leading: Image.asset(
            "assets/images/logo-black-half.png",
            fit: BoxFit.contain,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Chats",
            style: TextStyle(
              color: Colors.black,
              fontSize: (kToolbarHeight / 100) * 40,
            ),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        body:
            //  ListView.builder(
            //   itemCount: chatList.length,
            //   itemBuilder: (context, int index) => ChangeNotifierProvider.value(
            //     value: chatList[index],
            //     child: ChatMenuTile(
            //       onLongPress: () => showDialog(
            //         barrierDismissible: false,
            //         context: context,
            //         builder: (context) => AreYouSure(
            //             title: "Remove This Conversarion?",
            //             onPressed: () async {
            //               await chatProvider.deleteChat(
            //                   otherID: chatList[index].otherID);
            //               await msgProvider.deleteAllMessages(
            //                   otherID: chatList[index].otherID);

            //               Navigator.pop(context);
            //             }),
            //       ),
            //       chat: chatList[index],
            //       subtitle: userProvider
            //           .getUserByID(chatList[index].otherID!)
            //           .services!
            //           .first,
            //       user: userProvider.getUserByID(chatList[index].otherID!),
            //       image: CachedNetworkImageProvider(userProvider
            //           .getUserByID(chatList[index].otherID!)
            //           .profileImageURL!),
            //     ),
            //   ),
            // ),
            Container());
  }
}

// class ChatMenuTile extends StatelessWidget {
//   const ChatMenuTile({
//     Key? key,
//     required this.user,
//     required this.subtitle,
//     this.image,
//     required this.chat,
//     required this.onLongPress,
//   }) : super(key: key);
//   final ContractorsModel user;
//   final ChatModel chat;
//   final String subtitle;
//   final ImageProvider<Object>? image;
//   final VoidCallback onLongPress;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onLongPress: onLongPress,
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Inbox(user: user)),
//         );
//       },
//       title: Text(user.name!),
//       leading: CircleAvatar(
//         foregroundImage: image,
//       ),
//     );
//   }
// }
