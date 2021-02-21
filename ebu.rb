require "formula"

class Ebu < Formula
  url "http://green.ribbon.to/~ikazuhiro/dic/files/ebu-4.5-20200413.tar.gz"
  homepage "http://green.ribbon.to/~ikazuhiro/dic/ebu.html"
  sha256 "bd9ceaef2a0a43049aead871b3bf9b56cadee59ad2478b13c77130fe8694c1f1"
  version "4.5-20200413"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
