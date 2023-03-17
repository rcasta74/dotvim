vim9script

var java_args = [
    '-configuration', $HOME .. '/.cache/jdtls/conf',
    '-data', $HOME .. '/.cache/jdtls/data'
  ]
var java_lombok = globpath($HOME .. "/.cache/lsp/java", "**/lombok*.jar", v:false, v:true)
if !java_lombok->empty()
  java_args += [
    '-javaagent:' .. java_lombok[0],
  ]
endif

g:MyLspServers += [
  {
    'filetype': ['java', 'pom'],
    'path': $HOME .. '/.local/jdtls/bin/jdtls',
    'args': java_args
  }
]

