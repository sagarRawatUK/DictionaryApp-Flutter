part of 'connnectivity_cubit.dart';

@immutable
abstract class ConnnectivityState {}

class ConnnectivityInitial extends ConnnectivityState {}

class ConnnectivityConnected extends ConnnectivityState {}

class ConnnectivityDisconnected extends ConnnectivityState {}
