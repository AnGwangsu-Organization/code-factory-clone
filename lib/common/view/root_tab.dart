
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTab extends StatelessWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: SafeArea(
          child: Container(
            child: const Text('Root Tab'),
          ),
        )
    );
  }
}
