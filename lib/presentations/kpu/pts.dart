import 'package:flutter/material.dart';
import 'package:testing/utils/ColorAsset.dart';

class PtsPage extends StatefulWidget {
  const PtsPage({super.key});

  @override
  State<PtsPage> createState() => _PtsPageState();
}

class _PtsPageState extends State<PtsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/decorations/PTS.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 100,
                height: 450,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 24,
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SchedulePage(),
                  //   ),
                  // );
                },
                child: const Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorAsset.GREEN,
                  elevation: 0,
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    60,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
