{ lib, tinycc, writeShellScriptBin }:
writeShellScriptBin "tcc" ''
  # turn ld flags into tcc flags
  tcc_ldflags() {
    while [ $# -gt 0 ]; do

      case "$1" in
        -rpath) echo "-Wl,-rpath,$2"; shift ;;
        -L*)    echo "$1 -Wl,-rpath,''${1#-L}" ;;
        *)      echo "$1" ;;
      esac

      shift
    done
  }

  exec ${lib.getExe tinycc} $NIX_CFLAGS_COMPILE $(tcc_ldflags $NIX_LDFLAGS) "$@"
''
