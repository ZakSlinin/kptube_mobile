import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/models/video/video.dart';
import 'package:kptube_mobile/features/main/data/repositories/abstract_main_repository.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';
part 'main_events.dart';
part 'main_states.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final AbstractMainRepository mainRepository;
  List<VideoPreview> _allVideos = [];

  MainBloc({required this.mainRepository}) : super(MainInitial()) {
    on<GetMainEvent>(_onGetMain);
    on<VideoTap>(_onVideoTap);
    on<NavigateToHomeEvent>(_onNavigateToHome);
    on<SearchVideosEvent>(_onSearchVideos);
  }

  Future<void> _onGetMain(GetMainEvent event, Emitter<MainState> emit) async {
    try {
      print('MainBloc: Starting to load videos...');
      emit(MainLoading());

      print('MainBloc: Calling repository to get videos...');
      _allVideos = await mainRepository.getVideosMain();
      print('MainBloc: Received ${_allVideos.length} videos from repository');

      if (_allVideos.isEmpty) {
        print('MainBloc: No videos received from repository');
      } else {
        print('MainBloc: First video details:');
        print('- Owner: ${_allVideos.first.owner}');
        print('- Name: ${_allVideos.first.name}');
        print('- Preview URL: ${_allVideos.first.preview}');
      }

      _allVideos.shuffle();
      emit(MainSuccess(_allVideos));
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

  void _onNavigateToHome(NavigateToHomeEvent event, Emitter<MainState> emit) {
    emit(MainNavigateToHome());
  }

  void _onSearchVideos(SearchVideosEvent event, Emitter<MainState> emit) {
    if (event.query.isEmpty) {
      emit(MainSuccess(_allVideos));
      return;
    }

    final searchResults =
        _allVideos.where((video) {
          final name = video.name?.toLowerCase() ?? '';
          final owner = video.owner?.toLowerCase() ?? '';
          final query = event.query.toLowerCase();

          return name.contains(query) || owner.contains(query);
        }).toList();

    emit(MainSuccess(searchResults));
  }
}
