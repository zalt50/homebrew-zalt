require "formula"

class Eblook < Formula
  url "http://green.ribbon.to/~ikazuhiro/lookup/files/eblook-1.6.1+media-20150724.tar.gz"
  homepage "http://green.ribbon.to/~ikazuhiro/lookup/lookup.html#EBLOOK"
  sha256 "08e154eae27cc061e0c67dc9c0c346707defbb2bbfdb757ee00f22af4c059e1b"
  version "1.6.1+media-20150724"

  depends_on "eb"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--infodir=#{info}",
                          "--without-eb-conf",
                          "--with-ebu-conf=#{etc}/ebu.conf"
    system "make install"
  end
end
