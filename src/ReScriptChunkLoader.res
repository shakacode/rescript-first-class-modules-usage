module Component = {
  module type t = module type of ReScriptChunk
  let loader = () => Module.load("./ReScriptChunk.bs.js")
}

include Loadable.Make(Component)
