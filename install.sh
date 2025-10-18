#!/bin/bash

# Volt Installation Script
# Installs and configures Hyprland + Waybar + Walker

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root"
    exit 1
fi

# Welcome message
clear
echo -e "${BLUE}"
echo "╔═══════════════════════════════════════╗"
echo "║          Volt Installation            ║"
echo "║       Hyprland + Waybar + Walker      ║"
echo "╚═══════════════════════════════════════╝"
echo -e "${NC}"
echo ""

# Confirm installation
read -p "This will install Hyprland, Waybar, and Walker. Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Installation cancelled"
    exit 0
fi

# Update system
print_info "Updating system packages..."
sudo pacman -Syu --noconfirm

# Install dependencies
print_info "Installing dependencies..."
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    wget \
    curl

# Install Hyprland and related packages
print_info "Installing Hyprland..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    xdg-desktop-portal-hyprland \
    qt5-wayland \
    qt6-wayland \
    polkit-kde-agent \
    kitty \
    dunst \
    rofi-wayland \
    swww \
    grim \
    slurp \
    wl-clipboard \
    cliphist \
    brightnessctl \
    playerctl \
    pavucontrol \
    network-manager-applet \
    bluez \
    bluez-utils \
    blueman

# Install Waybar
print_info "Installing Waybar..."
sudo pacman -S --needed --noconfirm \
    waybar \
    otf-font-awesome \
    ttf-jetbrains-mono-nerd \
    ttf-firacode-nerd

# Install Walker (from AUR if needed)
print_info "Installing Walker..."
if ! command -v yay &> /dev/null; then
    print_info "Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

yay -S --needed --noconfirm walker-git || yay -S --needed --noconfirm walker

# Create config directories
print_info "Creating configuration directories..."
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/walker
mkdir -p ~/.config/kitty
mkdir -p ~/.config/dunst

# Configure Hyprland
print_info "Configuring Hyprland..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# Volt Hyprland Configuration

# Monitor configuration
monitor=,preferred,auto,1

# Execute at launch
exec-once = waybar
exec-once = dunst
exec-once = /usr/lib/polkit-kde-authentication-agent-1
exec-once = swww init
exec-once = nm-applet --indicator
exec-once = blueman-applet

# Environment variables
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct

# Input configuration
input {
    kb_layout = us
    follow_mouse = 1
    touchpad {
        natural_scroll = true
    }
    sensitivity = 0
}

# General settings
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
    allow_tearing = false
}

# Decoration
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
    }
    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animations
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layouts
dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_status = master
}

# Gestures
gestures {
    workspace_swipe = true
}

# Window rules
windowrulev2 = suppressevent maximize, class:.*

# Keybindings
$mainMod = SUPER

bind = $mainMod, RETURN, exec, kitty
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, walker
bind = $mainMod, P, pseudo,
bind = $mainMod, J, togglesplit,

# Move focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move window to workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through workspaces
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Screenshots
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
bind = SHIFT, Print, exec, grim - | wl-copy

# Media keys
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# Brightness
bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
EOF

# Configure Waybar
print_info "Configuring Waybar..."
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "cpu", "memory", "battery", "tray"],
    
    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "10": "10"
        }
    },
    
    "hyprland/window": {
        "max-length": 50
    },
    
    "clock": {
        "format": "{:%H:%M}",
        "format-alt": "{:%Y-%m-%d}",
        "tooltip-format": "<tt><small>{calendar}</small></tt>",
        "calendar": {
            "mode": "year",
            "mode-mon-col": 3,
            "weeks-pos": "right",
            "on-scroll": 1,
            "format": {
                "months": "<span color='#ffead3'><b>{}</b></span>",
                "days": "<span color='#ecc6d9'><b>{}</b></span>",
                "weeks": "<span color='#99ffdd'><b>W{}</b></span>",
                "weekdays": "<span color='#ffcc66'><b>{}</b></span>",
                "today": "<span color='#ff6699'><b><u>{}</u></b></span>"
            }
        }
    },
    
    "cpu": {
        "format": " {usage}%",
        "tooltip": false
    },
    
    "memory": {
        "format": " {}%"
    },
    
    "battery": {
        "states": {
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
        "format-plugged": " {capacity}%",
        "format-alt": "{icon} {time}",
        "format-icons": ["", "", "", "", ""]
    },
    
    "network": {
        "format-wifi": " {essid}",
        "format-ethernet": " {ipaddr}",
        "format-linked": " {ifname}",
        "format-disconnected": "⚠ Disconnected",
        "tooltip-format": "{ifname}: {ipaddr}"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-bluetooth": "{icon} {volume}%",
        "format-bluetooth-muted": " {icon}",
        "format-muted": " {volume}%",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },
    
    "tray": {
        "spacing": 10
    }
}
EOF

cat > ~/.config/waybar/style.css << 'EOF'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrains Mono Nerd Font", monospace;
    font-size: 13px;
    min-height: 0;
}

window#waybar {
    background-color: rgba(26, 27, 38, 0.9);
    color: #cdd6f4;
}

#workspaces button {
    padding: 0 10px;
    color: #cdd6f4;
    background-color: transparent;
}

#workspaces button.active {
    color: #89b4fa;
    background-color: rgba(137, 180, 250, 0.2);
}

#workspaces button:hover {
    background-color: rgba(205, 214, 244, 0.1);
}

#window,
#clock,
#battery,
#cpu,
#memory,
#network,
#pulseaudio,
#tray {
    padding: 0 10px;
    margin: 0 4px;
    background-color: rgba(30, 30, 46, 0.8);
    border-radius: 5px;
}

#battery.charging {
    color: #a6e3a1;
}

#battery.warning:not(.charging) {
    color: #f9e2af;
}

#battery.critical:not(.charging) {
    color: #f38ba8;
}

#network.disconnected {
    color: #f38ba8;
}

#pulseaudio.muted {
    color: #f38ba8;
}
EOF

# Configure Walker
print_info "Configuring Walker..."
cat > ~/.config/walker/config.json << 'EOF'
{
    "theme": "dark",
    "show_icons": true,
    "placeholder": "Search...",
    "max_entries": 10,
    "terminal": "kitty"
}
EOF

# Enable services
print_info "Enabling Bluetooth service..."
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Create .xinitrc or session starter
print_info "Creating Hyprland session starter..."
if [ ! -f ~/.bash_profile ]; then
    cat > ~/.bash_profile << 'EOF'
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec Hyprland
fi
EOF
fi

# Installation complete
clear
print_success "Installation completed successfully!"
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║     Volt Installation Complete       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Reboot your system"
echo "2. Log in to your user account"
echo "3. Hyprland will start automatically"
echo ""
echo -e "${YELLOW}Keybindings:${NC}"
echo "  SUPER + RETURN  - Open terminal"
echo "  SUPER + R       - Open Walker launcher"
echo "  SUPER + Q       - Close window"
echo "  SUPER + M       - Exit Hyprland"
echo ""
echo -e "${BLUE}Join our community:${NC}"
echo "  Discord: https://discord.gg/6naeNfwEtY"
echo ""
read -p "Press Enter to continue..."
