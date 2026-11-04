# The Homebrew cask of the GUI, filled per release by .github/scripts/brew-cask.sh and pushed
# to jordond/homebrew-tap by the gui-release workflow.
cask "dfdu-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.5.1"
  sha256 arm:   "66cedd7c0e0cd83ac76eac1d38902e9015a6a83388f52d7bef55d67ba009174f",
         intel: "1fff1acfb4fd8457cef9f4fe44217136cfdbc03ba78b3251a5a4191bd4b97832"

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
