class Dfdu < Formula
  desc "Disk usage browser for the terminal"
  homepage "https://github.com/jordond/dfdu"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.2/dfdu-aarch64-apple-darwin.tar.xz"
      sha256 "33b4b8bcb7217b0398570db5059555bd486241821d011f6b1970f031294982ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.2/dfdu-x86_64-apple-darwin.tar.xz"
      sha256 "30bad7b0fbc94bb06aa45e009f68aabde0bbfe42b4db16c71398575421ce1de4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.2/dfdu-aarch64-unknown-linux-musl.tar.xz"
      sha256 "fb6595e92c3e7c7544e1ebc1bc277e48af56d78e66bb71c682e65aa480cf0f70"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.2/dfdu-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8d262ed0a81e6cceeeaaacc31ee9021964b0a37785fb91c2229a298f3e28ca3d"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dfdu"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dfdu"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dfdu"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dfdu"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    man1.install Dir["man/*.1"]
    bash_completion.install "completions/dfdu.bash" => "dfdu"
    zsh_completion.install "completions/_dfdu"
    fish_completion.install "completions/dfdu.fish"
    leftover_contents = Dir["*"] - doc_files - ["man", "completions"]

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dfdu --version")
  end
end
