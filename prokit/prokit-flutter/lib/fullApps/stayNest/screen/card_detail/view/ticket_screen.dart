import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../main.dart';

class TicketScreen extends StatelessWidget {
  TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        title: const Text('Ticket'),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? Colors.white : Colors.black,
        ),
        backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      ),
      body: Column(
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Royale President Hotel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        20.height,
                        QrImageView(
                          data: 'Royale President Hotel Ticket for Daniel Austin',
                          size: 200,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Column(
                    children: [
                      _buildInfoRow(
                        'Name',
                        'Daniel Austin',
                        'Phone Number',
                        '+1 111 467 378 399',
                      ),
                      12.height,
                      _buildInfoRow(
                        'Check in',
                        'Dec 16, 2024',
                        'Check out',
                        'Dec 20, 2024',
                      ),
                      12.height,
                      _buildInfoRow('Hotel', 'Royale President', 'Guest', '3'),
                    ],
                  ).paddingAll(20),
                ],
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B61F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {},
              child: const Text(
                'Download Ticket',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          40.height,
        ],
      ).paddingAll(20),
    );
  }

  Widget _buildInfoRow(
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoColumn(label1, value1),
        _buildInfoColumn(label2, value2),
      ],
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          4.height,
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
