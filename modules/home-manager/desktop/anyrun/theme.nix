{ pkgs, ... }:
{
  programs.anyrun = {
    extraCss = /*css */ ''
      @define-color accent #5599d2;
      @define-color bg-color #101418;
      @define-color fg-color #eeeeee;
      @define-color desc-color #cccccc;
      
      window {
        background: transparent;
      }
      
      box.main {
        padding: 5px;
        margin: 10px;
        border-radius: 10px;
        background-color: @bg-color;
        box-shadow: 0 0 5px #343434;
      }
      
      
      text {
        font-family: "SFPro Text Nerd Font Medium";
        min-height: 30px;
        padding: 5px;
        border-radius: 5px;
        color: @fg-color;
      }
      
      .matches {
        padding-left: 5px;
        padding-right: 5px;
        padding-bottom: 5px;
        background-color: rgba(0, 0, 0, 0);
        border-radius: 10px;
      }
      
      box.plugin:first-child {
        margin-top: 10px;
      }
      
      box.plugin.info {
        min-width: 200px;
      }
      
      list.plugin {
        background-color: rgba(0, 0, 0, 0);
      }
      
      label.match {
        color: @fg-color;
      }
      
      label.match.description {
        font-size: 10px;
        color: @desc-color;
      }
      
      label.plugin.info {
        font-size: 14px;
        color: @fg-color;
      }
      
      .match {
        background: transparent;
        margin-top: 1px;
        margin-bottom: 1px;
      }
      
      .match:selected {
        border-left: 4px solid @accent;
        padding-left: 10px;
        background: transparent;
        animation: fade 0.1s linear;
      }
      
      @keyframes fade {
        0% {
          opacity: 0;
        }
      
        100% {
          opacity: 1;
        }
      }
    '';
  };
}
