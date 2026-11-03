# The Homebrew cask of the GUI, filled per release by .github/scripts/brew-cask.sh and pushed
# to jordond/homebrew-tap by the gui-release workflow.
cask "dfdu-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.4.0"
  sha256 arm:   "7d012815f15bf49611f68f5579718e4d0e466da37dccbe5bee011564d9eaab0d",
         intel: "75df26c5a10708bb5122466b6535303c326e6971a44d80a6fa7a915bbe80fff2"

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
