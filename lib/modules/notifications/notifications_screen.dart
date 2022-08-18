import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:social/shared/cubit/app_cubit/app_cubit.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..initRecorder(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                StreamBuilder<RecordingDisposition>(
                  builder: (context, snapshot) {
                    final duration = snapshot.hasData
                        ? snapshot.data!.duration
                        : Duration.zero;

                    String twoDigits(int n) => n.toString().padLeft(2, '0');

                    final twoDigitMinutes =
                        twoDigits(duration.inMinutes.remainder(60));
                    final twoDigitSeconds =
                        twoDigits(duration.inSeconds.remainder(60));

                    return Text(
                      '$twoDigitMinutes:$twoDigitSeconds',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  stream: cubit.recorder.onProgress,
                ),
                const SizedBox(height: 10.0),
                IconButton(
                  onPressed: () async {
                    if (cubit.recorder.isRecording) {
                      await cubit.stopRecorder(context);
                    } else {
                      await cubit.startRecord();
                    }
                  },
                  icon: cubit.recorder.isRecording
                      ? const Icon(Icons.stop, size: 40.0)
                      : const Icon(Icons.mic, size: 40.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
