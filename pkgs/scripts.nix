{
  pkgs,
  lib,
  args ? "-no-warn -no-autocorrect -b",
  langs ? "eng+jpn+jpn_vert+kor+kor_vert+deu+rus",
}: let
  inherit (pkgs) writeShellScriptBin writeShellScript grim slurp wtype tesseract5;
  _ = lib.getExe;
in {
  clipShow = writeShellScript "clipShow" ''
    export CLIP=true
    tmp_dir="/tmp/cliphist"
    rm -rf "$tmp_dir"
    mkdir -p "$tmp_dir"

    read -r -d "" prog <<EOF
    /^[0-9]+\s<meta http-equiv=/ { next }
    match(\$0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
        system("echo " grp[1] "\\\\\t | cliphist decode >$tmp_dir/"grp[1]"."grp[3])
        print \$0"\0icon\x1f$tmp_dir/"grp[1]"."grp[3]
        next
    }
    1
    EOF
    cliphist list | gawk "$prog" | rofi -dmenu -i -p '' -theme preview | cliphist decode | wl-copy
  '';
}
