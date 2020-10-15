class Dovecot < Formula
  desc "IMAP/POP3 server"
  homepage "https://dovecot.org/"
  url "https://dovecot.org/releases/2.3/dovecot-2.3.10.1.tar.gz"
  sha256 "6642e62f23b1b23cfac235007ca6e21cb67460cca834689fad450724456eb10c"

  livecheck do
    url "https://dovecot.org/download"
    regex(/href=.*?dovecot[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 "e8d7b6bf587b5673826b467c3a30b148a191ed94246797609fcdad42e3ad40e4" => :catalina
    sha256 "3b05663fc50f7669b2f16f6b55821f6fb2abf54fea8a858301ed7d5dbf7de7b5" => :mojave
    sha256 "3f35d37650ccc397e11584b5a31ef13157e63b7db3b4886a5f3b7c4fb73a3e7b" => :high_sierra
  end

  depends_on "openssl@1.1"
  uses_from_macos "bzip2"
  uses_from_macos "sqlite"

  resource "pigeonhole" do
    url "https://pigeonhole.dovecot.org/releases/2.3/dovecot-2.3-pigeonhole-0.5.9.tar.gz"
    sha256 "36da68aae5157b83e21383f711b8977e5b6f5477f369f71e7e22e76a738bbd05"
  end

  patch :DATA

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-dependency-tracking
      --libexecdir=#{libexec}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --with-bzlib
      --with-pam
      --with-sqlite
      --with-ssl=openssl
      --with-zlib
      --with-solr
    ]

    system "./configure", *args
    system "make", "install"

    resource("pigeonhole").stage do
      args = %W[
        --disable-dependency-tracking
        --with-dovecot=#{lib}/dovecot
        --prefix=#{prefix}
      ]

      system "./configure", *args
      system "make"
      system "make", "install"
    end
  end

  def caveats
    <<~EOS
      For Dovecot to work, you may need to create a dovecot user
      and group depending on your configuration file options.
    EOS
  end

  plist_options startup: true

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>KeepAlive</key>
          <false/>
          <key>RunAtLoad</key>
          <true/>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_sbin}/dovecot</string>
            <string>-F</string>
          </array>
          <key>StandardErrorPath</key>
          <string>#{var}/log/dovecot/dovecot.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/dovecot/dovecot.log</string>
          <key>SoftResourceLimits</key>
          <dict>
          <key>NumberOfFiles</key>
          <integer>1000</integer>
          </dict>
          <key>HardResourceLimits</key>
          <dict>
          <key>NumberOfFiles</key>
          <integer>1024</integer>
          </dict>
        </dict>
      </plist>
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/dovecot --version")
  end
end

__END__
--- dovecot-2.3.10.1-orig/src/plugins/fts/fts-parser-tika.c	2020-05-13 00:44:05.000000000 +0900
+++ dovecot-2.3.10.1/src/plugins/fts/fts-parser-tika.c	2020-06-13 14:13:38.000000000 +0900
@@ -77,7 +77,7 @@
 		http_set.request_timeout_msecs = 60*1000;
 		http_set.ssl = &ssl_set;
 		http_set.debug = user->mail_debug;
-		tika_http_client = http_client_init(&http_set);
+		tika_http_client = http_client_init_private(&http_set);
 	}
 	*http_url_r = tuser->http_url;
 	return 0;
--- dovecot-2.3.10.1-orig/src/plugins/fts-solr/solr-connection.c	2020-05-13 00:44:05.000000000 +0900
+++ dovecot-2.3.10.1/src/plugins/fts-solr/solr-connection.c	2020-06-13 14:15:27.000000000 +0900
@@ -103,7 +103,7 @@
 		http_set.ssl = ssl_client_set;
 		http_set.debug = solr_set->debug;
 		http_set.rawlog_dir = solr_set->rawlog_dir;
-		solr_http_client = http_client_init(&http_set);
+		solr_http_client = http_client_init_private(&http_set);
 	}
 
 	*conn_r = conn;
