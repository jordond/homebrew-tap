class Dfdu < Formula
  desc "Disk usage browser for the terminal"
  homepage "https://github.com/jordond/dfdu"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.6.0/dfdu-aarch64-apple-darwin.tar.xz"
      sha256 "65b0121e0e15eeea12aeef2be97aa1ef9e0d4782dacb8998fa093661ecac1831"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.6.0/dfdu-x86_64-apple-darwin.tar.xz"
      sha256 "416008555412bce15b48c2d1b5f8a57caca2403d005096e3ba3bd4aecc4b9353"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jordond/dfdu/releases/download/v0.6.0/dfdu-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e203465df8b2eff4dbc2ef49757c88d4db195973fae70dd62d37bfa11942dd2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jordond/dfdu/releases/download/v0.6.0/dfdu-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8641acdbbc91bae6f6e60bfff5a17e3dcc466c31e30bd2906edc128f9acd59c9"
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
