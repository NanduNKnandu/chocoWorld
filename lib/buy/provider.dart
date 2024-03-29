import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedStatusProvider extends ChangeNotifier {
  late String _selectedStatus;

  String get selectedStatus => _selectedStatus;

  set selectedStatus(String status) {
    _selectedStatus = status;
    notifyListeners();
  }
}
