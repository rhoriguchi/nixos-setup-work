{ citrix_workspace, fetchurl, stdenv, bison, glib, libxml2, flex, pkg-config, perl, python3, dpkg, xorg, gst_all_1 }:
let
  version = "0.10.36";

  gstreamer = stdenv.mkDerivation rec {
    inherit version;

    pname = "gstreamer";

    src = fetchurl {
      url = "https://gstreamer.freedesktop.org/src/${pname}/${pname}-${version}.tar.xz";
      sha256 = "sha256-kVGqEIwXcFQ4eIV2P6DkM+dngPfFZVxwpTkPKmxocdo=";
    };

    nativeBuildInputs = [ bison flex glib libxml2 pkg-config perl python3 ];

    patches = [ ./gstreamer/priv_gst_parse_yylex_arguments.patch ];
  };

  gst-plugins-base = stdenv.mkDerivation rec {
    inherit version;

    pname = "gst-plugins-base";

    src = fetchurl {
      url = "https://gstreamer.freedesktop.org/src/${pname}/${pname}-${version}.tar.xz";
      sha256 = "sha256-H+RcOJSQMAHU0AiwcT2rCJ9Tcm3LWELVtAwllamE5ko=";
    };

    nativeBuildInputs = [ glib gstreamer libxml2 pkg-config ];

    patches = [ ./gst-plugins-base/fix_build_input.patch ];
  };
in citrix_workspace.overrideAttrs (oldAttrs: {
  src = assert oldAttrs.version == "21.9.0.25"; ./citrix_workspace_21.9.0.25.tar.gz;

  hxdSrc = ./hdx_realtime_media_engine/hdx_realtime_media_engine_2.9.400-2702.deb;

  buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ gst_all_1.gstreamer gst-plugins-base xorg.libXv ];

  nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ dpkg ];

  installPhase = (oldAttrs.installPhase or "") + ''
    cp linuxx64/linuxx64.cor/util/gst_{play,read}0.10 $out/opt/citrix-icaclient/util

    dpkg -x $hxdSrc deb

    mkdir -p $out/opt/citrix-icaclient
    cp deb/usr/local/bin/HDXRTME.so $out/opt/citrix-icaclient/

    mkdir -p $out/opt/citrix-icaclient/rtme
    cp deb/usr/local/bin/{DialTone_US.wav,EULA.rtf,InboundCallRing.wav,RTMediaEngineSRV} $out/opt/citrix-icaclient/rtme/

    patchelf deb/usr/local/bin/RTMEconfig \
      --set-interpreter "${stdenv.cc.bintools.dynamicLinker}"
    cp $out/opt/citrix-icaclient/config/module.ini module.ini
    deb/usr/local/bin/RTMEconfig -install -ignoremm
    cp -f new_module.ini $out/opt/citrix-icaclient/config/module.ini

    mkdir -p $out/lib/udev/rules.d
    cp deb/usr/local/bin/50-hid.rules $out/lib/udev/rules.d
  '';
})
