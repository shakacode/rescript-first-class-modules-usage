module Component = {
  module type t = module type of JsxChunk
  let loader = () => Module.load("./JsxChunk.bs.js")
}

include Loadable.Make(Component)
