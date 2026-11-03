class Dfdu < Formula
  desc "Disk usage browser for the terminal"
  homepage "https://github.com/jordond/dfdu"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.4.0/dfdu-aarch64-apple-darwin.tar.xz"
      sha256 "5fd62398661195fda771a4baed7553e84c2309eb0543a7236147e5961f5af709"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.4.0/dfdu-x86_64-apple-darwin.tar.xz"
      sha256 "ab023a94ce3b069bbfb1da46aab5068f3ecbf6232cae254b4d0ee624cf2699f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.4.0/dfdu-aarch64-unknown-linux-musl.tar.xz"
      sha256 "692c9a9744b0bd4234022ab7ec9889b4694e03124b4719b44d11345be1779360"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.4.0/dfdu-x86_64-unknown-linux-musl.tar.xz"
      sha256 "691c0d865432b283d45fcbe6bd7b5155b88ebe1f97d413563c8a953a74b2131e"
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
