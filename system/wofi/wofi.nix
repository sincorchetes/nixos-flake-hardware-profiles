{
    programs = {
        wofi = {
            enable = true;

            settings = {
                show = "drun";
                insensitive = true;  
            };

            style = ''
            window {
                margin: 0px;
                border: 1px solid transparent;
                background-color: rgba(43, 48, 59, 0.9);
                border-radius: 5px;
                }

                #input {
                margin: 5px;
                border: none;
                color: #d8dee9;
                background-color: rgba(43, 48, 59, 0.9);
                border-radius: 5px;
                }

                #inner-box {
                margin: 5px;
                border: none;
                background-color: rgba(43, 48, 59, 0.9);
                border-radius: 5px;
                }

                #outer-box {
                margin: 5px;
                border: none;
                background-color: rgba(43, 48, 59, 0.9);
                }

                #scroll {
                margin: 0px;
                border: none;
                }

                #text {
                margin: 5px;
                border: none;
                color: #d8dee9;
                }

                #entry:selected {
                background-color: rgb(60, 64, 73);
                }
            '';
        };
    };
};