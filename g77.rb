require "formula"

class StandardHomebrewLocation < Requirement
  def message; <<-EOS.undent
    hpc port of g77 won't work outside of /usr/local

    Because this uses pre-compiled binaries, it will not work if
    Homebrew is installed somewhere other than /usr/local
    EOS
  end

  def satisfied?
    HOMEBREW_PREFIX.to_s == "/usr/local"
  end
end

class G77 < Formula
  homepage "http://hpc.sourceforge.net"
  url "http://downloads.sourceforge.net/project/hpc/hpc/g77/g77-intel-bin.tar.gz"
  version "3.4"
  sha256 "d29b45f2b2f374aa12cad202a305acd1453425ec86eeb52b05bbbbfe497ee427"

  depends_on StandardHomebrewLocation.new

  def install
    safe_system "mv local/* #{prefix}"
  end
end
