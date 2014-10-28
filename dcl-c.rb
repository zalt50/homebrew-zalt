require 'formula'

class DclC < Formula
  url 'http://www.gfd-dennou.org/arch/dcl/dcl-5.4.8-C.tar.gz'
  homepage 'http://www.gfd-dennou.org/index.html.en'
  sha256 '04271b061bd63b203521bf9b367f3191560ba95baaff93fc5fbf8d2f534cc9cd'
  version '5.4.8'

  depends_on 'gtk+'

  def install
    ENV.deparallelize
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
