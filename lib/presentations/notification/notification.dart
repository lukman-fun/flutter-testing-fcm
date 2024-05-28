import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:testing/blocs/notification/notification_bloc.dart';
import 'package:testing/blocs/notification/notification_event.dart';
import 'package:testing/blocs/notification/notification_state.dart';
import 'package:testing/utils/ColorAsset.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late NotificationBloc notificationBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    notificationBloc.add(OnGetNotification());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        titleSpacing: 0,
        backgroundColor: ColorAsset.GREEN,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorAsset.GREEN,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationSuccess) {
                return ListView.builder(
                  itemCount: state.notificationModel.data.length,
                  itemBuilder: (context, index) {
                    final item = state.notificationModel.data[index];

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: ColorAsset.GREEN,
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(item.subTitle),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              const Text('1 Jam'),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                      ],
                    );
                  },
                );
              } else if (state is NotificationError) {
                return Center(
                  child: Text(state.error),
                );
              }
              return const Center(
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: ColorAsset.GREEN,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
