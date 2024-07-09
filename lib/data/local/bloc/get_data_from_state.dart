// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_data_from_bloc.dart';

@immutable
sealed class GetDataFromState {}

final class LoadingStateFrom extends GetDataFromState {}
class LocalStorageState extends GetDataFromState {
   List<AnimalModel> Data;
  LocalStorageState({
    required this.Data,
  });
}



