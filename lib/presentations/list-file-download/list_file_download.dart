import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/archive-file/archive_file_bloc.dart';
import 'package:testing/blocs/archive-file/archive_file_event.dart';
import 'package:testing/blocs/archive-file/archive_file_state.dart';
import 'package:testing/utils/ColorAsset.dart';

class ListFileDownloadPage extends StatefulWidget {
  const ListFileDownloadPage({super.key});

  @override
  State<ListFileDownloadPage> createState() => _ListFileDownloadPageState();
}

class _ListFileDownloadPageState extends State<ListFileDownloadPage> {
  late ArchiveFileBloc archiveFileBloc;

  List<String> data = [
    'Kalender Akademik',
    'Formulir Pendaftaran',
    'Panduan Pembayaran SPP',
    'Penduan Daftar Ulang',
    'Brosur Promosi',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    archiveFileBloc = BlocProvider.of<ArchiveFileBloc>(context);
    archiveFileBloc.add(OnGetArchiveFile());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 120,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
            ),
            margin: const EdgeInsets.only(bottom: 24),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: const Text(
              'File yang dapat diunduh',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ArchiveFileBloc, ArchiveFileState>(
              builder: (context, state) {
                if (state is ArchiveFileSuccess) {
                  return ListView.builder(
                    itemCount: state.archiveFileModel.data.length,
                    itemBuilder: (context, index) {
                      final item = state.archiveFileModel.data[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorAsset.GREEN,
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              55,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(item.title),
                        ),
                      );
                    },
                  );
                } else if (state is ArchiveFileError) {
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
        ],
      ),
    );
  }
}
