type App* = tuple[
  nim: string,       ## compiler to use
  srcFile: string,   ## script to run
  # non-doc comment: this won't appear in `help`
  show: bool,        ## show informative compiler info
  synth: string ]    ## synthetic inferred from other args

const dfl* = (nim: "nimcc", srcFile: "", show: false, synth: "")

proc logic*(a: var App) =
  a.synth = a.nim & " FOOBAR"

when isMainModule:    #Q: why can one not say {.outputFile: "InitOb".}?
  import cligen
  var app = initFromCL(dfl, xCmdName = "InitOb", xdoc = "do some app",
                       xsuppress = @[ "synth" ], xshort = {"show": 'S'},
                       xhelp = { "nim":       "compiler to use",
                                 "srcFile":  "script to run",
                                 "show": "show informative compiler info" })
  #var app = initFromCL(App())  #also works if type defaults are ok
  app.logic()
  echo "app: ", app
