// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';

@immutable
sealed class AnimalEvent {}

class GetAnimal extends AnimalEvent {}

class CreateNewAnimal extends AnimalEvent {
 final String name;
  CreateNewAnimal({
    required this.name,
  });

}
