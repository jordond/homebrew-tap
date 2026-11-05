# The Homebrew cask of the GUI, filled per release by .github/scripts/brew-cask.sh and pushed
# to jordond/homebrew-tap by the gui-release workflow.
cask "dfdu-gui" do
  arch arm: "aarch64", intel: "x86_64"

  version "0.6.0"
  sha256 arm:   "e634d2c33a895dd265c13b0adbaa9d51e20d6fade3f47fbcb2aa122e6705cee6",
         intel: "2ecc1575a4e1742d9142ff0773b823af5c67bc8f52bc7321f67866aded9acc31"

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
