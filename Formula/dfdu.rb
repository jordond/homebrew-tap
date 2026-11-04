class Dfdu < Formula
  desc "Disk usage browser for the terminal"
  homepage "https://github.com/jordond/dfdu"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.1/dfdu-aarch64-apple-darwin.tar.xz"
      sha256 "6e630e0544ee55e9a327dd797b5fe52c90982a6c607434092a430eae1d55d99b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.1/dfdu-x86_64-apple-darwin.tar.xz"
      sha256 "de79c4ad1df48dafd8bcdbd841053853423f299be086f6350d08c051ffb3e453"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.1/dfdu-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d75f83fa57b4bf37219084b30e7a2b4db24f3e9e3e856a03703f1eb69da6286c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.5.1/dfdu-x86_64-unknown-linux-musl.tar.xz"
      sha256 "62a2611768135e33a437d8684a99f238242064730b1e97ab10766d50b9aadded"
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
