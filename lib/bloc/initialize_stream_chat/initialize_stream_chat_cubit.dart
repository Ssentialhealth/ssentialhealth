import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:start_jwt/json_web_token.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'initialize_stream_chat_state.dart';

class InitializeStreamChatCubit extends Cubit<InitializeStreamChatState> {
  InitializeStreamChatCubit() : super(InitializeStreamChatInitial());

  StreamChatClient _client = StreamChatClient(
    '5ce52vsjkw26',
    logLevel: Level.OFF,
    tokenProvider: provider,
  );

  StreamChatClient get client => _client;

  void loadInitial() {
    emit(StreamChannelInitial());
  }

  void initializeUser(String streamUserID, String userCategory) async {
    //TODO: inProduction | add real data
    emit(StreamChatLoading());
    final userID = streamUserID.split(' ').first + streamUserID.split(' ').last;
    try {
      await _client.disconnect();
      await _client.connectUserWithProvider(
        // User(
        //   id: 'TestLewis',
        //   extraData: {
        //     "userCategory": 'individual',
        //   },
        // ),
        User(
          id: 'DrTestDoctor47',
          extraData: {
            "userCategory": 'doctor',
          },
        ),
      );

      emit(StreamChatSuccess(_client));
    } catch (e) {
      emit(StreamChatFailure());
      print("initalize stream error" + e.toString());
    }
  }

  void initializeChannel(String streamUserID, String streamDocID, String userCategory) async {
    //TODO: inProduction | add real data
    emit(StreamChannelLoading());
    // final docID = streamDocID.split(' ').first;
    // final userID = streamUserID.split(' ').first;

    final docID = 'DrTestDoctor47';
    final userID = 'TestLewis';
    try {
      await client.disconnect();

      await client.connectUserWithProvider(
        User(
          id: docID,
          extraData: {
            "userCategory": 'doctor',
          },
        ),
      );

      await client.disconnect();

      await client.connectUserWithProvider(
        User(
          id: userID,
          extraData: {
            "userCategory": 'individual',
          },
        ),
      );

      final channel = client.channel(
        'messaging',
        id: docID,
      );

      await channel.create();
      await channel.addMembers([docID, userID]);
      await channel.watch();
      emit(StreamChannelSuccess(channel, docID));
    } catch (err) {
      emit(StreamChannelError(err.toString()));
      print("create channel failed | $err");
    }
  }
}

Future<String> provider(String id) async {
  final JsonWebTokenCodec jwt = JsonWebTokenCodec(secret: 'abjt7zac5yd2sjjrnnxckfph8c23jdxr2qkfk7sndhhjp9jpk9845e54pty38qct');
  final payload = {
    "user_id": id,
  };
  return jwt.encode(payload);
}
