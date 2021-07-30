part of 'initialize_stream_chat_cubit.dart';

abstract class InitializeStreamChatState extends Equatable {
  const InitializeStreamChatState();
}

class InitializeStreamChatInitial extends InitializeStreamChatState {
  @override
  List<Object> get props => [];
}

class StreamChatLoading extends InitializeStreamChatState {
  @override
  List<Object> get props => [];
}

class StreamChatSuccess extends InitializeStreamChatState {
  final StreamChatClient client;

  StreamChatSuccess(this.client);
  @override
  List<Object> get props => [client];
}

class StreamChatFailure extends InitializeStreamChatState {
  @override
  List<Object> get props => [];
}

class StreamChannelSuccess extends InitializeStreamChatState {
  final Channel channel;

  StreamChannelSuccess(this.channel);
  @override
  List<Object> get props => [channel];
}

class StreamChannelLoading extends InitializeStreamChatState {
  StreamChannelLoading();
  @override
  List<Object> get props => [];
}

class StreamChannelError extends InitializeStreamChatState {
  final String err;
  StreamChannelError(this.err);
  @override
  List<Object> get props => [err];
}

class StreamChannelInitial extends InitializeStreamChatState {
  StreamChannelInitial();
  @override
  List<Object> get props => [];
}
