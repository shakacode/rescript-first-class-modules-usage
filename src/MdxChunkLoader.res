module Component = {
  module type t = module type of MdxChunk
  let loader = () => Module.load("./MdxChunk.bs.js")
}

include Loadable.Make(Component)
