USERNAME=optonox

# Set variables
export TERM=xterm-256color
export GDK_BACKEND=x11

export EDITOR=emacsclient
export VISUAL=emacsclient

# Set path
export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/sbin:/usr/bin:/usr/local/sbin

export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

export PATH=$PATH:~/.npm-global/bin

export PATH=$HOME/.cargo/bin:$PATH

# Vulkan variables
export VULKAN_SDK=~/vulkan/VulkanSDK/1.1.73.0/x86_64
export PATH=$PATH:$VULKAN_SDK/bin
export LD_LIBRARY_PATH=$VULKAN_SDK/
export VK_LAYER_PATH=$VULKAN_SDK/etc/explicit_layer.d

# Notify that .profile has loaded
echo "The $USERNAME .profile file has loaded"

# Source bashrc if it exists
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
