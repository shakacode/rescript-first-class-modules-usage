type state = {
  rescriptChunk: Visibility.t,
  jsxChunk: Visibility.t,
  mdxChunk: Visibility.t,
}

type action =
  | ShowExternalReScriptChunk
  | HideExternalReScriptChunk
  | ShowExternalJsxChunk
  | HideExternalJsxChunk
  | ShowExternalMdxChunk
  | HideExternalMdxChunk

let reducer = (state, action) =>
  switch action {
  | ShowExternalReScriptChunk => {...state, rescriptChunk: Shown}
  | HideExternalReScriptChunk => {...state, rescriptChunk: Hidden}
  | ShowExternalJsxChunk => {...state, jsxChunk: Shown}
  | HideExternalJsxChunk => {...state, jsxChunk: Hidden}
  | ShowExternalMdxChunk => {...state, mdxChunk: Shown}
  | HideExternalMdxChunk => {...state, mdxChunk: Hidden}
  }

@react.component
let make = () => {
  let (state, dispatch) =
    reducer->React.useReducer({rescriptChunk: Hidden, jsxChunk: Hidden, mdxChunk: Hidden})

  <div className="container">
    <div className="row">
      {switch state.rescriptChunk {
      | Shown => <>
          <Button size=MD icon=module(LoadIcon) onClick={_ => HideExternalReScriptChunk->dispatch}>
            {"Hide dynamically loaded ReScript component"->React.string}
          </Button>
          <ReScriptChunkLoader>
            {(module(ReScriptChunk)) => <ReScriptChunk />}
          </ReScriptChunkLoader>
        </>
      | Hidden => <>
          <Button size=MD icon=module(LoadIcon) onClick={_ => ShowExternalReScriptChunk->dispatch}>
            {"Show dynamically loaded ReScript component"->React.string}
          </Button>
        </>
      }}
    </div>
    <div className="row">
      {switch state.jsxChunk {
      | Shown => <>
          <Button size=MD icon=module(LoadIcon) onClick={_ => HideExternalJsxChunk->dispatch}>
            {"Hide dynamically loaded JSX component"->React.string}
          </Button>
          <JsxChunkLoader> {(module(JsxChunk)) => <JsxChunk />} </JsxChunkLoader>
        </>
      | Hidden => <>
          <Button size=MD icon=module(LoadIcon) onClick={_ => ShowExternalJsxChunk->dispatch}>
            {"Show dynamically loaded JSX component"->React.string}
          </Button>
        </>
      }}
    </div>
    <div className="row">
      {switch state.mdxChunk {
      | Shown => <>
          <Button size=MD icon=module(LoadIcon) onClick={_ => HideExternalMdxChunk->dispatch}>
            {"Hide dynamically loaded MDX component"->React.string}
          </Button>
          <MdxChunkLoader> {(module(MdxChunk)) => <MdxChunk />} </MdxChunkLoader>
        </>
      | Hidden => <>
          <Button size=MD icon=module(LoadIcon) onClick={_ => ShowExternalMdxChunk->dispatch}>
            {"Show dynamically loaded MDX component"->React.string}
          </Button>
        </>
      }}
    </div>
  </div>
}
