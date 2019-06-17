import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spike_scoped_model_flutter/models/loading_model.dart';

typedef T Func0<T>();

class LoadingWidget extends StatelessWidget {
  const LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (context, child, LoadingModel model) {
        return (model.value)
            ? Container(
                decoration: const BoxDecoration(color: Color(0x44000000)),
                child: Center(child: const CircularProgressIndicator()),
              )
            : Container();
      },
    );
  }
}
