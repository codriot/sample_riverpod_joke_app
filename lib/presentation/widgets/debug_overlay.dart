import 'package:flutter/material.dart';
import '../../core/config/flavor_config.dart';
import 'debug_console_widget.dart';

/// Debug Overlay Widget
/// Sadece development ve staging ortamlarında görünür
/// Sağ altta hareket ettirilebilir bir böcek ikonu gösterir
class DebugOverlay extends StatefulWidget {
  final Widget child;

  const DebugOverlay({super.key, required this.child});

  @override
  State<DebugOverlay> createState() => _DebugOverlayState();
}

class _DebugOverlayState extends State<DebugOverlay> {
  Offset _position = const Offset(20, 100);
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    // Production'da debug widget'ı gösterme
    if (!FlavorConfig.isInitialized || FlavorConfig.instance.flavor.isProduction) {
      return widget.child;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  _isDragging = true;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _position += details.delta;

                  // Ekran sınırlarını kontrol et
                  final size = MediaQuery.of(context).size;
                  _position = Offset(
                    _position.dx.clamp(0.0, size.width - 60),
                    _position.dy.clamp(0.0, size.height - 60),
                  );
                });
              },
              onPanEnd: (_) {
                setState(() {
                  _isDragging = false;
                });
              },
              onTap: _isDragging ? null : _showDebugConsole,
              child: _DebugButton(isDragging: _isDragging),
            ),
          ),
        ],
      ),
    );
  }

  void _showDebugConsole() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DebugConsoleWidget(),
    );
  }
}

/// Debug button widget
class _DebugButton extends StatelessWidget {
  final bool isDragging;

  const _DebugButton({required this.isDragging});

  @override
  Widget build(BuildContext context) {
    final flavor = FlavorConfig.instance.flavor;

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isDragging ? Colors.red : _getFlavorColor(),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.bug_report, color: Colors.white, size: 28),
          Text(
            _getFlavorLabel(),
            style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Color _getFlavorColor() {
    final flavor = FlavorConfig.instance.flavor;
    if (flavor.isDebug) {
      return Colors.green;
    } else if (flavor.isStaging) {
      return Colors.orange;
    }
    return Colors.blue;
  }

  String _getFlavorLabel() {
    final flavor = FlavorConfig.instance.flavor;
    if (flavor.isDebug) {
      return 'DEV';
    } else if (flavor.isStaging) {
      return 'STG';
    }
    return 'PROD';
  }
}
