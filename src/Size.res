type t =
  | SM
  | MD

let className = x =>
  switch x {
  | SM => "sm"
  | MD => "md"
  }
