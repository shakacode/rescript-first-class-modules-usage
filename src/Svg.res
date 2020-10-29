@react.component
let make = (~size: Size.t, ~children) => {
  <svg className={size->Size.className} viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
    children
  </svg>
}
