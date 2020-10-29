module type Component = {
  module type t
  let loader: unit => Promise.t<module(t)>
}

let delay = 200

module Make = (Component: Component) => {
  type state =
    | LoadingModule([#withFeedback | #withoutFeedback])
    | Ok(module(Component.t))
    | Error

  type action =
    | ProvideFeedback
    | RenderComponent(module(Component.t))
    | Fail

  let reducer = (state, action) =>
    switch action {
    | ProvideFeedback =>
      switch state {
      | LoadingModule(#withoutFeedback) => LoadingModule(#withFeedback)
      | LoadingModule(#withFeedback) | Ok(_) | Error => state
      }
    | RenderComponent(component) => Ok(component)
    | Fail => Error
    }

  @react.component
  let make = (~children: module(Component.t) => React.element) => {
    let (state, dispatch) = reducer->React.useReducer(LoadingModule(#withoutFeedback))

    React.useEffect0(() => {
      let timeoutId = delay->Js.Global.setTimeout(() => ProvideFeedback->dispatch, _)

      Component.loader()->Promise.result->Promise.wait(x =>
        switch x {
        | Ok(component) => {
            timeoutId->Js.Global.clearTimeout
            RenderComponent(component)->dispatch
          }
        | Error(_) => Fail->dispatch
        }
      )

      Some(() => timeoutId->Js.Global.clearTimeout)
    })

    switch state {
    | LoadingModule(#withoutFeedback) => React.null
    | LoadingModule(#withFeedback) => "Loading..."->React.string
    | Ok(component) => component->children
    | Error => "Oh no"->React.string
    }
  }
}
