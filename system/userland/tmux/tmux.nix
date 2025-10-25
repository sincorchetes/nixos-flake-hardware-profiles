{
    programs.tmux = {
        enable = true;
        mouse = true;
        extraConfig = ''
            bind g setw synchronize-panes \; display-message "Sync panes toggled"
        '';
    }
}