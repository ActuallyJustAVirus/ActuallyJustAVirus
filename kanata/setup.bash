# This script sets up the kanata tool by downloading it from the latest release on GitHub

# Stop kanata if it's running
sudo systemctl stop kanata

# Download the latest release of kanata if it doesn't exist
if [ ! -f kanata ]; then
    echo "Downloading kanata..."
    URL="https://github.com/jtroo/kanata/releases/latest/download/kanata"
    curl -L $URL -o kanata
    # Check if the download was successful
    if [ $? -ne 0 ]; then
        echo "Failed to download kanata. Please check the URL or your internet connection."
        exit 1
    fi
    # Make the file executable
    chmod +x kanata
else
    echo "kanata already exists. Skipping download."
fi
# Move the file to a directory in your PATH
sudo cp kanata /usr/local/bin/
# Check if the move was successful
if [ $? -ne 0 ]; then
    echo "Failed to move kanata to /usr/local/bin/. Please check your permissions."
    exit 1
fi

# Move kanata.kbd to the home directory
mkdir -p ~/.config/kanata
cp kanata.kbd ~/.config/kanata/
# Check if the move was successful
if [ $? -ne 0 ]; then
    echo "Failed to move kanata.kbd to ~/.config/kanata/. Please check your permissions."
    exit 1
fi

# Move kanata.service to systemd directory
sudo cp kanata.service /etc/systemd/system/
# Check if the move was successful
if [ $? -ne 0 ]; then
    echo "Failed to move kanata.service to /etc/systemd/system/. Please check your permissions."
    exit 1
fi
# Enable the kanata service
sudo systemctl enable kanata
# Check if the enable was successful
if [ $? -ne 0 ]; then
    echo "Failed to enable kanata service. Please check your systemd configuration."
    exit 1
fi
# Start the kanata service
sudo systemctl start kanata
# Check if the start was successful
if [ $? -ne 0 ]; then
    echo "Failed to start kanata service. Please check your systemd configuration."
    exit 1
fi
# Print success message
echo "kanata has been successfully installed and started."
echo "You can check the status of the kanata service with 'systemctl status kanata'."