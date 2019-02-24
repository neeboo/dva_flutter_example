import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dva_dart/dva_dart.dart' as Dva;
import 'package:dva_flutter/connector.dart';
import '../../models/states.dart';
import 'page.dart';

/// container is to wrap up the dvaConnector
/// which will return a `Widget` by default
/// the params should be context by default and others inheriated from parant.

Widget playPageContainer({context, routeTo}) {
  return DvaConnector(
    /// we use `context` to pass store to current connector, is a must
    context: context,

    /// then we should always use key to tag the connecter
    key: Key('PlayPage'),

    /// listenTo is the List<String> to identify what models you are listening to, do not leave blank for these version.
    listenTo: ['counter', 'play'],

    /// builder is the main function you have to write by yourselve.
    /// here we have 3 parameters to the function, `context` you have known,
    /// `models` is the ones contains all the models you are listening to.
    /// and `dispatch` is the main function you interact with the DvaModel.

    builder: (BuildContext context, DvaModels models, dispatch) {
      /// first, remember that, if you want to use the specific type from your State, remember to import them.
      /// and we use `models.setState(String key)` to get the state of model
      PlayerState playerState = models.getState('play');
      CounterState counterState = models.getState('counter');

      return PlayPage(
        /// now you can pass the state from the model to your widget
        counter: counterState.counter,

        /// first you create an action
        /// `Action action = Dva.createAction(String nameSpace/effectKey)(Payload<T> payload)`
        /// then use `dispatch(Action)` to dispatch them to `DvaModel`
        /// `nameSpace/effect` will define which effect you are interact with.
        play: () => dispatch(Dva.createAction('play/play')(null)),
        pause: () => dispatch(Dva.createAction('play/pause')(null)),
        stop: () => dispatch(Dva.createAction('play/stop')(null)),
        jump: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true, builder: (context) => routeTo),
            ),
        status: playerState.status,
        asyncAdd: (int counter) => dispatch(
            Dva.createAction('counter/asyncAdd')(Dva.Payload(counter))),
      );
    },
  );
}
