# Helper Function for downloading non-core plugins
function download_plugin() {
    # $1 = vendor/plugin_name
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    git clone "https://github.com/$1.git" "$ZSH_CUSTOM/plugins/$PLUGIN_NAME"
}