#!/bin/bash
set -e  # Exit on any error



# ======================================
# Check if Docker and DDEV are installed
# ======================================

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Docker is installed
if ! command_exists "docker"; then
    echo "Error: Docker is not installed. Please install Docker before running the script."
    exit 1
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker before running the script."
    exit 1
fi

# Check if DDEV is installed
if ! command_exists "ddev"; then
    echo "Error: DDEV is not installed. Please install DDEV before running the script."
    exit 1
fi



# ======================================
# Create and enter the project directory
# ======================================
while true; do
    read -rp "Enter a project name: " folder_name

    if [[ -d "$folder_name" ]]; then
        if [[ -n "$(find "$folder_name" -mindepth 1 -print -quit 2>/dev/null)" ]]; then
            echo "Error: The folder already exists and is not empty."
        else
            break
        fi
    else
        mkdir -p "$folder_name"
        break
    fi
done

cd "$folder_name" || exit



# ======================
# Configure DDEV project
# ======================
echo "Configuring DDEV project... ⚡️"
ddev config --project-type=craftcms --docroot=web --php-version=8.3 --database=mysql:8.0 --disable-upload-dirs-warning



# =============
# Install Craft
# =============
echo "Installing Craft... ⚡️"
ddev composer create --no-interaction --no-scripts "craftcms/craft"
ddev craft install



# ======================================
# Cloning Patches from GitHub Repository
# ======================================
echo "Cloning patches from GitHub... ⚡️"
git clone --depth=1 git@github.com:estebancastro/craft-starter.git craft-starter



# ============================
# Apply patches to the project
# ============================
echo "Applying patches... ⚡️"

# Set PATCHES_DIR variable to the correct location
PATCHES_DIR="craft-starter/patches"

# Copy configuration files from the patches directory to the project
cp -a "$PATCHES_DIR/config/." config

# Copy DDEV-related files from the patches directory to the project
cp -a "$PATCHES_DIR/ddev/." .ddev

# Copy root files from the patches directory to the project root
cp -a "$PATCHES_DIR/root/." ./



# ========================
# Set up Craft environment
# ========================
echo "Setting up Craft environment... ⚡️"

# Copy the example environment file to the active environment
cp .env.example.dev .env

# Set up the Craft app ID in the environment
ddev exec craft setup/app-id

# Set up the Craft security key in the environment
ddev exec craft setup/security-key



# =====================
# Install Craft plugins
# =====================
echo "Installing Craft plugins... ⚡️"

# Install the 'craft-vite' plugin and then install it using Craft
ddev composer require "nystudio107/craft-vite:^5.0.1" -W && ddev craft plugin/install vite

# Install the 'craft-minify' plugin and then install it using Craft
ddev composer require "nystudio107/craft-minify:^5.0.0" -W && ddev craft plugin/install minify



# ========================
# Install npm dependencies
# ========================
echo "Installing npm dependencies... ⚡️"

# Install required npm packages for the project
ddev exec npm install --save-dev vite @vitejs/plugin-legacy tailwindcss @tailwindcss/vite rimraf rollup-plugin-critical vite-plugin-compression vite-plugin-live-reload vite-plugin-favicon2 regenerator-runtime terser @types/node release-it



# ========================
# Restart DDEV environment
# ========================
echo "Restarting DDEV... ⚡️"

# Restart the DDEV environment to apply changes
ddev restart



# ============================================
# Set the ASSETS_URL based on PRIMARY_SITE_URL
# ============================================
echo "Setting assets URL... ⚡️"

# Replace the value of ASSETS_URL in the .env file with the value of PRIMARY_SITE_URL
sed -i '' 's|^ASSETS_URL=.*|ASSETS_URL="'"$(awk -F'=' '/^PRIMARY_SITE_URL/ {print $2}' .env | tr -d '"')"'"|' .env



# ======================
# Clean up project files
# ======================
echo "Cleaning project... ⚡️"

# Remove the 'craft-starter' directory and environment files
rm -rf "craft-starter" ".env.example.staging" ".env.example.production"



# ================
# Project is ready
# ================
echo "Ready for takeoff! 🚀"
echo "Run 'make dev' to start the Vite development server."
