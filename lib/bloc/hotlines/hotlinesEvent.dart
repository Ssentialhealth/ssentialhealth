import 'package:equatable/equatable.dart';

abstract class HotlinesEvent extends Equatable{
  const HotlinesEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchHotline extends HotlinesEvent {
  const FetchHotline();
}
