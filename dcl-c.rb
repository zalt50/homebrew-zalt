require "formula"

class DclC < Formula
  url "http://www.gfd-dennou.org/arch/dcl/dcl-7.0.0-C.tar.gz"
  homepage "http://gfd-dennou.org/index.html.en"
  sha256 "673f38612a27c9bc7867e854d3d21be765f4d6beb349a571e8379d6242c1217e"
  version "7.0.0"

  depends_on "gtk+"

  def install
    ENV.deparallelize
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
