require 'formula'

class Eb < Formula
  url 'http://green.ribbon.to/~ikazuhiro/dic/files/ebu-4.4.3-20120704.tar.gz'
  homepage 'http://green.ribbon.to/~ikazuhiro/dic/ebu.html'
  sha256 'e1c9370e47622fc6c210e6ccb71bbf980cd50f22b90f7d6d4c6691237d8fc503'
  version 'u-4.4.3-20120704'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
