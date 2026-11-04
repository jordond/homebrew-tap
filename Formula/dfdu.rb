class Dfdu < Formula
  desc "Disk usage browser for the terminal"
  homepage "https://github.com/jordond/dfdu"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.0/dfdu-aarch64-apple-darwin.tar.xz"
      sha256 "70b379a47526f1fb772ccda6862bdba6c92d0879f9b614f1a879c7067050367e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.0/dfdu-x86_64-apple-darwin.tar.xz"
      sha256 "d8c5da38d3f70f5872cd9ef603586c7ab639ec7df9bc38b3293c55b8247627b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.0/dfdu-aarch64-unknown-linux-musl.tar.xz"
      sha256 "83cd0fc6b900d7c510be50de67c4bcf3e32d6ffb21091c417fd1378ed579995f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.0/dfdu-x86_64-unknown-linux-musl.tar.xz"
      sha256 "939bda3096e9741ea7644b4f2cd89f1e3eab9db0b613b71aa0cb036f24b340f0"
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
