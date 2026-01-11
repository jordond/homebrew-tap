class Jolt < Formula
  desc 'A beautiful TUI for monitoring battery and energy usage'
  homepage 'https://getjolt.sh'
  version '0.3.0'
  license 'MIT'

  on_macos do
    if Hardware::CPU.arm?
      url 'https://github.com/jordond/jolt/releases/download/0.3.0/jolt-aarch64-apple-darwin'
      sha256 'PLACEHOLDER_SHA256'

      def install
        bin.install 'jolt-aarch64-apple-darwin' => 'jolt'
      end
    else
      url 'https://github.com/jordond/jolt/releases/download/0.3.0/jolt-x86_64-apple-darwin'
      sha256 'PLACEHOLDER_SHA256'

      def install
        bin.install 'jolt-x86_64-apple-darwin' => 'jolt'
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jolt --version")
  end
end
