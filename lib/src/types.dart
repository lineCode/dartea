part of dartea;

/// function for sending messages into the program loop
typedef Dispatch<TMsg> = void Function(TMsg msg);

/// callback for side-effects
typedef Effect<TMsg> = void Function(Dispatch<TMsg> dispatch);

/// function for initializing model
typedef Init<TModel, TMsg> = Upd<TModel, TMsg> Function();

/// function for creating widgets tree
typedef View<TModel, TMsg> = Widget Function(
    BuildContext ctx, Dispatch<TMsg> dispatch, TModel model);

/// function for error handling in runtime loop
typedef OnError = void Function(StackTrace stacktrace, Exception exception);

/// function for updating state(model)
typedef Update<TModel, TMsg> = Upd<TModel, TMsg> Function(
    TMsg msg, TModel model);

/// function for handling app Flutter lifecycle events and updating state(model)
typedef LifeCycleUpdate<TModel, TMsg> = Upd<TModel, TMsg> Function(
    AppLifecycleState appState, TModel model);

/// function for subsrcibing on external sources
typedef Subscribe<TModel, TMsg, TSubHolder> = TSubHolder Function(
    TSubHolder currentSub, Dispatch<TMsg> dispatch, TModel model);

/// function for render created widgets tree (typicaly through runApp)
typedef RenderView = void Function(Widget root);

/// Simple tuple of Model*Cmds (for init or update functions)
class Upd<TModel, TMsg> {
  final TModel model;
  final Cmd<TMsg> effects;
  Upd(this.model, {this.effects = const Cmd.none()});
}

/// The same as [Upd] but with addional messages for communication child with parent
class UpdChild<TModel, TMsg, TParentMsg> {
  final TModel model;
  final Cmd<TMsg> effects;
  final List<TParentMsg> toParent;
  UpdChild(this.model,
      {this.effects = const Cmd.none(), this.toParent = const []});
}
