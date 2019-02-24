import 'package:dva_dart/dva_dart.dart';
import 'state.dart';

DvaModel playPageModel = DvaModel(

    /// nameSpace is the key to `DvaModel`, it should be uniqe and rememberable.
    nameSpace: 'play',

    /// initialState, which will contain your State's initial function or constructor by default.
    initialState: PlayerState.initial(),

    /// reducers which will require you update the state.
    reducers: {
      /// reducer is a `MapEntry<String,Function>`, if you are familiar with dva.js, you should have know this.
      /// however I really dont fully implement dva_dart with redux_saga, like `select` is not ready yet.
      /// use `(DvaState state, Payload<T> payload)` as the template.
      /// since Payload is construct with Payload.payload, you should return payload.payload as the latest state
      'updateState': (DvaState state, Payload<PlayerState> payload) {
        return payload.payload;
      }
    },
    effects: {
      /// effects is a `Map<String,Future>`, here we introduce the `async*` and `yield`,
      ///  because we want every side effect is sended to `Stream` for reducer to listen.
      'play': (Payload<String> payload) async* {
        /// `PutEffect` is the function you pass invoke the state reducer, remember, to use it everytime.
        /// you can pass the key with `otherModel/reducerKey` to interact with other model.
        /// which is powerful and useful.
        ///
        /// other than `PutEffect`, we also have a `CallEffect` but not really show in this example.
        /// which is used to hook up with network apis like `http` or `graphQl` or somthing async ones.
        /// I'll try to do those examples as well in the future.
        yield PutEffect(
            key: 'updateState',
            payload: Payload<PlayerState>(PlayerState.playing()));
      },
      'stop': (Payload<String> payload) async* {
        yield PutEffect(
            key: 'updateState',
            payload: Payload<PlayerState>(PlayerState.stopped()));
      },
      'pause': (Payload<String> payload) async* {
        yield PutEffect(
            key: 'updateState',
            payload: Payload<PlayerState>(PlayerState.paused()));
      }
    });
