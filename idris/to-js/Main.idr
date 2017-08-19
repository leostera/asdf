module Main

record Timeout where
  constructor MkTimeout
  unTimeout : Ptr


js_apply : (s : String) -> (ty : Type) -> { auto prf : FTy FFI_JS [] ty } -> ty
js_apply s ty = foreign FFI_JS s ty

setTimeout : (() -> JS_IO ()) -> (ms : Int) -> JS_IO Timeout
setTimeout f ms = do
  timeout <- js_apply "setTimeout(%0, %1)"
                      (JsFn (() -> JS_IO ()) -> Int -> JS_IO Ptr)
                      (MkJsFn f)
                      ms
  pure $ MkTimeout timeout

log : String -> JS_IO ()
log = js_apply "console.log(%0)" (String -> JS_IO())

data Component : Type -> Type where
  MkComponent : String -> List Prop -> Component

data ReactElement : Type where
  MkReactElement : (tag : String) ->
                   (props : List ReactProp) ->
                   (children : List Reactelement) ->
                   ReactElement


interface Render a (MkFFI b) where
  render : a -> (MkFFI b)


createElement : String -> JS_IO Ptr
createElement el = js_apply "React.createElement(%0, {}, [\"Hello Wurld\"])"
                            (String -> JS_IO Ptr)
                            el

render : Ptr -> JS_IO ()
render = js_apply "ReactDOM.render(%0, document.getElementById(\"root\"))"
                  (Ptr -> JS_IO ())

main : JS_IO ()
main = do _  <- setTimeout (\x => log "timed") 1000
          el <- createElement "h1"
          render el
