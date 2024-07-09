// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_data_from_bloc.dart';

@immutable
sealed class GetDataFromEvent {}


class GetLocalDataEvent extends GetDataFromEvent{

}

class LoadMoretDataEvent extends GetDataFromEvent {
int pageId;
  LoadMoretDataEvent({
    required this.pageId,
  });
}

