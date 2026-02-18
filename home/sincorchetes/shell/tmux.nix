{
    programs.tmux = {
        enable = true;
        mouse = true;
        extraConfig = ''
            bind g setw synchronize-panes \; display-message "Sync panes toggled"
            bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
        '';
    };
}
