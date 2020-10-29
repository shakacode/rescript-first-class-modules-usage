module type Icon = {
  @react.component
  let make: (~size: Size.t) => React.element
}

@react.component
let make = (~size: Size.t, ~icon: option<module(Icon)>=?, ~onClick, ~children) => {
  <button className={size->Size.className} onClick>
    {switch icon {
    | Some(module(Icon)) => <Icon size />
    | None => React.null
    }}
    children
  </button>
}
