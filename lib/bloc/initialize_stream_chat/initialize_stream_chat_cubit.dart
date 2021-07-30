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

  void initializeUser(String streamUserID) async {
    print(streamUserID);
    emit(StreamChatLoading());
    // final userID = streamUserID.split(' ').first + streamUserID.split(' ').last;
    final userID = 'TestLewis';
    try {
      await _client.disconnect();
      await _client.connectUserWithProvider(
        User(
          id: userID,
        ),
      );
      emit(StreamChatSuccess(_client));
    } catch (e) {
      emit(StreamChatFailure());
      print("initalize stream error" + e.toString());
    }
  }

  void initializeChannel(String streamDocID, String streamUserID) async {
    emit(StreamChannelLoading());

    // final docID = streamDocID.split(' ').first + streamDocID.split(' ')?.last;
    // final docID = 'NewDoctorsTest' + '${Random().nextInt(40).toString()}';
    final docID = 'TestDoctor12';
    // final userID = streamUserID.split(' ').first;
    final userID = 'TestLewis';

    try {
      await client.disconnect();

      await client.connectUserWithProvider(
        User(
          id: docID,
        ),
      );

      await client.disconnect();

      await client.connectUserWithProvider(
        User(
          id: userID,
        ),
      );

      final channel = client.channel(
        'messaging',
        id: docID,
      );

      await channel.create();
      await channel.inviteMembers([docID], Message(text: '$userID wants to consult you!', parentId: userID));
      await channel.addMembers([docID, userID]);
      // await channel.rejectInvite();

      // print('inviteResponse.message');
      // print(inviteResponse.message?.user?.id);
      // print('acceptResponse.message');
      // inviteResponse.members.forEach((element) async {
      //   print(element.user.id);
      //   if (rejectResponse.members.isNotEmpty) {
      //     print('denied');
      //   }
      //   await channel.addMembers(
      //     [docID, userID],
      //   );
      // });
      // final sdds = await channel.acceptInvite();

      await channel.watch();
      emit(StreamChannelSuccess(channel));
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
