require "formula"

class Ebu < Formula
  url "http://green.ribbon.to/~ikazuhiro/dic/files/ebu-4.4.3-20150301.tar.gz"
  homepage "http://green.ribbon.to/~ikazuhiro/dic/ebu.html"
  sha256 "207fef55ebf1240b411dc3dd5dca01fb7b953e9f8b4b95d2e432e821db5e9fcc"
  version "4.4.3-20150301"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
