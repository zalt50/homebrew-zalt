class TmuxMemCpu < Formula
  desc "CPU and RAM monitor for use with tmux"
  homepage "https://github.com/mandre/tmux-mem-cpu"
  url "https://github.com/mandre/tmux-mem-cpu/archive/v2.1.0.tar.gz"
  sha256 "de6507aa9bb5a4db7c5bfd4de46808af80723eec950e26db8d68128eb9bb13c8"

  head "https://github.com/mandre/tmux-mem-cpu.git"

  depends_on "cmake" => :build

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
