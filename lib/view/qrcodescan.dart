import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScan extends StatefulWidget {
  const QrCodeScan({Key? key}) : super(key: key);

  @override
  State<QrCodeScan> createState() => _QrCodeScanState();
}

class _QrCodeScanState extends State<QrCodeScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView()),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (result != null)
                    Text(
                        'Barcode Type: ${result!.format}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    children: [
                      _buildFlashButton(),
                      const SizedBox(width: 20),
                      _buildFlipCameraButton(),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView() {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: _onPermissionSet,
    );
  }

  Widget _buildFlashButton() {
    return ElevatedButton(
      onPressed: () async {
        await controller?.toggleFlash();
        setState(() {});
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          return states.contains(MaterialState.disabled)
              ? Colors.black
              : Colors.white;
        }),
      ),
      child: FutureBuilder(
        future: controller?.getFlashStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            bool? flashStatus = snapshot.data;
            String flashText = flashStatus != null
                ? (flashStatus ? 'Flash On' : 'Flash Off')
                : 'Unknown';
            return Text(flashText);
          }
        },
      ),
    );
  }

  Widget _buildFlipCameraButton() {
    return ElevatedButton(
      onPressed: () async {
        await controller?.flipCamera();
        setState(() {});
      },
      child: const Text('Flip Camera'),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
