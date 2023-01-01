Config { font = "xft:Iosevka:styke=Regular:pixelsize=15;2:antialias=true:hinting=true"
       , additionalFonts = [ "xft:TerminessTTF Nerd Font:style=Regular:pixelsize=15;2" ]
       -- , bgColor = "#090611"
       , bgColor = "#ffffff"
       , fgColor = "#090611"
       -- , fgColor = "#ffffff"
       , position = TopSize C 100 30
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , commands = [
                    -- Time and date
                      Run Date "<fn=1> </fn> %a %d %b %Y <fc=#c9af82>%H:%M <fn=1> </fn></fc>" "date" 50
                      -- Network up and down
                    , Run DynNetwork ["-t", " ↓<rx>kb | ↑<tx>kb"] 20
                      -- Cpu usage in percent
                    , Run Cpu ["-t", "<fn=1> </fn><total>%",
                               "-H", "50",
                               "-h", "#c9af82"
                              ] 20
                      -- Ram used number and percent
                    , Run Memory ["-t", "<fn=1> </fn><usedratio>%"] 20
                      -- Disk space free
                    , Run DiskU [("/", "<fn=1> </fn><usedp>%")] [] 60
                      -- Temperature
                    , Run ThermalZone 0 ["-t", "<fn=1></fn> <temp>°C", 
                                         "-H", "65", 
                                         "-h", "#c9af82"
                                        ] 30
                      -- Audio
                    , Run Alsa "default" "Master" ["-t", "<status> <volume>%",
                                                   "--",
                                                   "-O", "",
                                                   "-o", "<fn=1> </fn>",
                                                   "-h", "<fn=1> </fn>",
                                                   "-m", "<fn=1> </fn>",
                                                   "-l", "<fn=1> </fn>",
                                                   "-C", "#090611",
                                                   "-c", "#724372"
                                                  ]
                      -- Wifi (is currently not used, can be inserted with %wi%)
                    , Run Wireless "" ["-t", "<fn=1> </fn><qualityvbar>"] 20
                      -- Battery
                    , Run Battery ["-t", "<acstatus> / <timeleft>",
                                   "--", 
                                   "-o", "<fn=1>  </fn><left>%",
                                   "-O", "<fc=#c9af82><fn=1>  </fn><left>%</fc>"
                                  ] 20
                      -- Check for updates
                    , Run Com "/home/anders/.config/xmobar/scripts/updates" [] "updates" 36000
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%UnsafeStdinReader% %battery% %updates% } %date% { %wi% %dynnetwork% %disku%  %cpu%   %memory%   %thermal0% %alsa:default:Master%"
       }
