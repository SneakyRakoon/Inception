#! /bin/bash

# Prompt for VM details
read -p "Enter VM username: " VM_USER
read -p "Enter VM host (IP or hostname): " VM_HOST
read -p "Enter destination directory on VM: " VM_DEST

VM_USER=root
VM_HOST=localhost
VM_DEST=/home/$VM_USER/Inception

# SSH into VM
echo "Connecting to $VM_USER@$VM_HOST..."
ssh $VM_USER@$VM_HOST

# Rsync all files from local to VM
echo "Syncing files to $VM_USER@$VM_HOST:$VM_DEST..."
rsync -avz --progress ./ $VM_USER@$VM_HOST:$VM_DEST

# Check if inotifywait is installed
if ! command -v inotifywait &> /dev/null; then
    echo "inotifywait could not be found. Please install inotify-tools."
    exit 1
fi

# Function to sync files
sync_files() {
    echo "Syncing files to $VM_USER@$VM_HOST:$VM_DEST..."
    rsync -avz --progress ./ $VM_USER@$VM_HOST:$VM_DEST
}

# Initial sync
sync_files

echo "Watching for file changes..."
# Watch for changes and sync on change
inotifywait -m -r -e modify,create,delete,move --exclude ".git|node_modules" . |
while read path action file; do
    echo "Detected $action in $path$file. Syncing..."
    sync_files
    echo "Watching for file changes..."
done