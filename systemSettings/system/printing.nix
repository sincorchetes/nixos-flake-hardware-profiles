{ pkgs, ... }:

{
  
services = {

  # Printer Settings
  printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };
 };
}
