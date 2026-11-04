# The Homebrew cask of the GUI, filled per release by .github/scripts/brew-cask.sh and pushed
# to jordond/homebrew-tap by the gui-release workflow.
cask "dfdu-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.5.2"
  sha256 arm:   "3df9e99bb5833d165741ea994fba7efb79872997e5254b82bb60b8eef026c2c4",
         intel: "faad0747e9507a7c9a0e667409cde4b4b148ae520fd1614f726427b5ff4395a0"

  url "https://github.com/jordond/dfdu/releases/download/v#{version}/dfdu-gui-#{arch}-apple-darwin.dmg"
  name "dfdu"
  desc "Disk usage browser"
  homepage "https://dfdu.app/"

  depends_on macos: ">= :ventura"

  app "dfdu.app"

  caveats <<~EOS
    To scan every folder as an administrator, open View > Full disk access in dfdu. It
    installs a helper that macOS asks you to allow in System Settings > General > Login
    Items. Remove the helper in that window before uninstalling the app.
  EOS
end
