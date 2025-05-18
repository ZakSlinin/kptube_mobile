import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/features/main/data/repositories/abstract_main_repository.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';
part 'main_events.dart';
part 'main_states.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AbstractMainRepository mainRepository;

  MainBloc({required this.mainRepository}) : super(MainInitial()) {
    on<GetMainEvent>(_onGetMain);
    on<VideoTap>(_onVideoTap);
  }

  Future<void> _onGetMain(GetMainEvent event, Emitter<MainState> emit) async {
    try {
      print('MainBloc: Starting to load videos...');
      emit(MainLoading());

      print('MainBloc: Calling repository to get videos...');
      final videos = await mainRepository.getVideosMain();
      print('MainBloc: Received ${videos.length} videos from repository');

      if (videos.isEmpty) {
        print('MainBloc: No videos received from repository');
      } else {
        print('MainBloc: First video details:');
        print('- Owner: ${videos.first.owner}');
        print('- Name: ${videos.first.name}');
        print('- Preview URL: ${videos.first.preview}');
      }

      videos.shuffle();

      emit(MainSuccess(videos));
      print('MainBloc: Emitted MainSuccess state');
    } catch (e, stackTrace) {
      print('MainBloc: Failed to load videos');
      print('Error: $e');
      print('Stack trace: $stackTrace');
      emit(MainFailed());
    }
  }

  Future<void> _onVideoTap(VideoTap event, Emitter<MainState> emit) async {
    try {
      print('MainBloc: video tapped with owner: ${event.Video_ID}');
      emit(MainVideoTap(Video_ID: event.Video_ID));
      print('MainBloc: emitted MainVideoTap state');
    } catch (e) {
      print('Error: $e');
    }
  }
}
