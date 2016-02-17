require "formula"

class DclC < Formula
  url "http://gfd-dennou.org/library/dcl/dcl-6.0.4-C.tar.gz"
  homepage "http://gfd-dennou.org/index.html.en"
  sha256 "62003ae11c4d4a88e5112d7055d5abdce71cc9cb274b823b77053aca2b486ea1"
  version "6.0.4"

  depends_on "gtk+"

  def install
    ENV.deparallelize
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
