{ pkgs, ... }:
{
  services.dunst = {
    settings = {
      global = {
        font = "SFProText Nerd Font 11";
        corner_radius = 10;
        frame_width = 0;
        border = 0;
        background = "#eeeeeea8";
        foreground = "#000000";
        timeout = 10;
        padding = 16;
        horizontal_padding = 16;
        width = 400;
        height = 300;
        offset = "10x10";
        origin = "top-right";
        notification_limit = 0;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        separator_color = "frame";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "top";
        show_age_threshold = 60;
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left-top";
        min_icon_size = 0;
        max_icon_size = 32;
        sticky_history = "yes";
        history_length = 20;
        browser = "librewolf -new-tab";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        startup_notification = false;
        verbosity = "mesg";
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        background = "#F0F0F073";
        foreground = "#000000";
        timeout = 10;
      };
      urgency_normal = {
        background = "#F0F0F073";
        foreground = "#000000";
        timeout = 0;
      };
      urgency_critical = {
        background = "#F0F0F073";
        foreground = "#000000";
        timeout = 0;
      };
    };
  };
}
