{ lib, ... }:

{
  programs =
    (lib.genAttrs [ "lazygit" "neovim" "ripgrep" "fd" "jq" "bottom" "trippy" ] (_: { enable = true; }))
    // (lib.genAttrs [ "navi" "broot" "yazi" "fzf" "zoxide" "atuin" ] (_: { enable = true; enableZshIntegration = true; }))
    // {

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = "$username$hostname$directory $git_branch$git_status $kubernetes $nix_shell$direnv$python$nodejs$golang$rust$terraform$docker_context$aws$cmd_duration\${custom.azure}\${custom.terragrunt}\${custom.ansible}$line_break$character";
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };
        nix_shell = {
          disabled = false;
          symbol = "❄️ ";
          format = "[$symbol$state( \\($name\\))]($style) ";
          style = "bold blue";
        };
        direnv = {
          disabled = false;
          format = "[$symbol$loaded/$allowed]($style) ";
          symbol = "📂 ";
          style = "bold orange";
        };
        cmd_duration = {
          min_time = 3000;
          format = "[⏱ $duration]($style) ";
          style = "bold yellow";
        };
        python = {
          format = "[🐍 $version( \\($virtualenv\\))]($style) ";
          style = "bold yellow";
        };
        nodejs = {
          format = "[⬢ $version]($style) ";
          style = "bold green";
        };
        golang = {
          format = "[🐹 $version]($style) ";
          style = "bold cyan";
        };
        rust = {
          format = "[🦀 $version]($style) ";
          style = "bold red";
        };
        terraform = {
          disabled = false;
          format = "[💠 $version( $workspace)]($style) ";
          style = "bold 105";
        };
        docker_context = {
          format = "[🐳 $context]($style) ";
          style = "bold blue";
        };
        aws = {
          disabled = false;
          format = "[☁️ $profile(/$region)]($style) ";
          style = "bold yellow";
        };
        azure = {
          disabled = true;
        };
        custom.terragrunt = {
          description = "Terragrunt workspace";
          command = "basename $(terragrunt output-module-groups 2>/dev/null | head -1) 2>/dev/null || echo tg";
          when = "test -f terragrunt.hcl";
          format = "[🏗️ terragrunt]($style) ";
          style = "bold 105";
        };
        custom.azure = {
          description = "Azure subscription (on-demand)";
          command = "az account show --query name -o tsv 2>/dev/null";
          when = "test -n \"$STARSHIP_SHOW_AZURE\"";
          format = "[🔷 $output]($style) ";
          style = "bold blue";
        };
        custom.ansible = {
          description = "Ansible indicator";
          when = "test -f ansible.cfg || test -f playbook.yml || test -f site.yml || test -d roles";
          format = "[🅰️ ansible]($style) ";
          style = "bold white";
        };
        username = {
          show_always = false;
          format = "[$user@]($style)";
          style_user = "bold blue";
          style_root = "bold red";
        };
        hostname = {
          ssh_only = true;
          format = "[$hostname ]($style)";
          style = "bold yellow";
        };
        directory = {
          style = "bold cyan";
          truncate_to_repo = true;
          truncation_length = 3;
        };
        git_branch = {
          symbol = "🌱 ";
          style = "bold purple";
        };
        git_status = {
          style = "bold red";
        };
        kubernetes = {
          disabled = false;
          format = "[☸ $context/$namespace]($style) ";
          style = "bold green";
          detect_env_vars = [ "STARSHIP_SHOW_K8S" ];
          contexts = [
            {
              context_pattern = ".*prod.*";
              style = "bold red";
            }
            {
              context_pattern = ".*pre.*";
              style = "bold yellow";
            }
            {
              context_pattern = ".*dev.*";
              style = "bold green";
            }
          ];
        };
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        unsetopt PROMPT_CR

        az() {
          export STARSHIP_SHOW_AZURE=1
          command az "$@"
        }

        k() {
          export STARSHIP_SHOW_K8S=1
          command kubecolor "$@"
        }

        compdef k=kubectl
      '';

      shellAliases = {
        cat = "bat --paging=never -p";
        c = "clear";
        ls = "eza";
        ll = "eza -l";
        open = "xdg-open";
        vim = "nvim";

        g = "git";
        t = "terraform";
        dc = "docker compose";
        gg = "google-cloud-sdk";

        nxupdate = "sudo nixos-rebuild switch --refresh --flake .#$(hostname) --impure";
        nxcboot = "sudo nixos-rebuild boot --flake .#$(hostname) --impure";
        nxcsys = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
        nxfull = "nxupdate && nxcsys && nxcboot";
      };
    };
  };
}
