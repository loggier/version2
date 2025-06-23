import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class StreamingScreen extends StatefulWidget {
  final List<String> videoUrls;

  const StreamingScreen({super.key, required this.videoUrls});

  @override
  State<StreamingScreen> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  final List<VlcPlayerController> _controllers = [];
  final List<VoidCallback> _listeners = []; // Para remover luego si quieres

  @override
  void initState() {
    super.initState();

    // Crea un controlador por cada URL
    for (var url in widget.videoUrls) {
      print('URL: $url');
      final controller = VlcPlayerController.network(
        url,
        hwAcc: HwAcc.disabled,
        autoPlay: true, // Empieza a reproducir automáticamente
        autoInitialize: true,
        options: VlcPlayerOptions(
          advanced: VlcAdvancedOptions([
            VlcAdvancedOptions.networkCaching(100),
            VlcAdvancedOptions.liveCaching(1000),
            VlcAdvancedOptions.fileCaching(1000)
          ]),
          extras: [
            // Desactiva el título superpuesto
            '--no-video-title-show',
            // Otros flags de VLC que pueden ayudar, por ejemplo:
            '--repeat', // Repetir en bucle si se detiene
            '--live-caching=3000', // Ajusta en milisegundos si quieres un buffer mayor
          ],
          http: VlcHttpOptions([
            VlcHttpOptions.httpReconnect(true),
            VlcHttpOptions.httpContinuous(true),
          ]),
          rtp: VlcRtpOptions([
            VlcRtpOptions.rtpOverRtsp(true),
            ':rtsp-tcp',
          ]),
        ),
      );

      _controllers.add(controller);
    }
  }

  @override
  void dispose() {
    // Liberar los controladores al cerrar
    // Primero removemos listeners, luego dispose
    for (int i = 0; i < _controllers.length; i++) {
      final ctrl = _controllers[i];
      ctrl.dispose();
    }
    super.dispose();
  }

  /// Play/Pause específico de cada video
  void togglePlayPause(int index) {
    final ctrl = _controllers[index];
    print(ctrl.getVideoTrack());
    print(ctrl.value.isPlaying);
    if (ctrl.value.isPlaying) {
      ctrl.pause();
    } else {
      print('play');

      ctrl.play();
    }
    setState(() {});
  }

  /// Ajustar volumen con Slider (0 a 1.0)
  void setVolume(int index, double value) {
    _controllers[index].setVolume((value * 100).toInt());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Se ajusta al contenido
      children: [
        for (int index = 0; index < _controllers.length; index++) ...[
          // Video centrado con fondo negro
          Center(
            child: SizedBox(
              width: 340,
              height: 220,
              child: Container(
                color: Colors.black,
                child: VlcPlayer(
                  controller: _controllers[index],
                  aspectRatio: 16 / 9,
                  placeholder: const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),

          // Controles (Play/Pause, Mute, Slider, Max Volumen)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón Play/Pause
              IconButton(
                icon: Icon(
                  _controllers[index].value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: () => togglePlayPause(index),
              ),

              // Ícono para mutear (volumen 0)
              IconButton(
                icon: const Icon(Icons.volume_off),
                onPressed: () {
                  _controllers[index].setVolume(0);
                  setState(() {});
                },
              ),

              // Slider de volumen (0 a 1.0)
              SizedBox(
                width: 120,
                child: Slider(
                  value: (_controllers[index].value.volume ?? 0) / 100.0,
                  onChanged: (val) => setVolume(index, val),
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                ),
              ),

              // Ícono para poner volumen máximo (100)
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  _controllers[index].setVolume(100);
                  setState(() {});
                },
              ),
            ],
          ),

          // Línea divisoria entre videos (opcional)
          if (index < _controllers.length - 1) const Divider(),
        ],
      ],
    );
  }
}
