require 'formula'

class Eblook < Formula
  url 'http://ikazuhiro.s206.xrea.com/filemgmt_data/files/eblook-1.6.1%2Bmedia-20130919.tar.gz'
  homepage 'http://green.ribbon.to/~ikazuhiro/lookup/lookup.html#EBLOOK'
  sha256 'd66fb9ac372d11f7b66f5019998ed02d86db0d44ce886f13542f9ee6bbe748f4'
  version '1.6.1+media-20130919'
  
  depends_on 'eb'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--infodir=#{info}",
                          "--without-eb-conf",
                          "--with-ebu-conf=#{etc}/ebu.conf"
    system "make install"
  end
end
