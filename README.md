# Homebrew Tap Setup

This directory contains the template for the `jordond/homebrew-tap` repository.

## Setup Instructions

### 1. Create the Homebrew Tap Repository

Create a new repository at: https://github.com/new

- **Name:** `homebrew-tap`
- **Owner:** `jordond`
- **Visibility:** Public

### 2. Initialize the Repository

Copy the contents of this directory to the new repository:

```bash
# Clone the new repo
git clone https://github.com/jordond/homebrew-tap.git
cd homebrew-tap

# Copy the Formula directory
cp -r /path/to/jolt/homebrew/Formula .

# Create a README
echo "# Homebrew Tap

Homebrew formulae for jolt and other tools.

## Installation

\`\`\`bash
brew tap jordond/tap
brew install jolt
\`\`\`

Or install directly:

\`\`\`bash
brew install jordond/tap/jolt
\`\`\`
" > README.md

# Commit and push
git add .
git commit -m "Initial formula for jolt"
git push
```

### 3. Create a Personal Access Token

1. Go to: https://github.com/settings/tokens/new
2. Create a new **classic** token with:
   - **Note:** `HOMEBREW_TAP_TOKEN`
   - **Scopes:** `repo` (full control of private repositories)
3. Copy the token

### 4. Add the Secret to the Jolt Repository

1. Go to: https://github.com/jordond/jolt/settings/secrets/actions
2. Click "New repository secret"
3. **Name:** `HOMEBREW_TAP_TOKEN`
4. **Value:** Paste the token from step 3
5. Click "Add secret"

### 5. Test the Workflow

Create a new release on the jolt repository. The workflow will:

1. Build binaries for all platforms
2. Upload them to the release
3. Automatically update the Homebrew formula in `jordond/homebrew-tap`

## Usage

Once set up, users can install jolt via:

```bash
# Tap the repository (one-time)
brew tap jordond/tap

# Install jolt
brew install jolt

# Or install directly without tapping
brew install jordond/tap/jolt
```

## Updating

The formula is automatically updated when a new release is created on the jolt repository.

## Structure

```
homebrew-tap/
├── Formula/
│   └── jolt.rb    # Homebrew formula (auto-updated by CI)
└── README.md
```
