# AHKSpotify


# GUI
- GUI shows  Interpret - Title
- GUI shows if automute is enabled (AM in front of Interpret if enabled)
- Show GUI with Ctrl + G
- Hide GUI with Ctrl + Shift + G

# Automute
- automatically mutes spotify when advertisement is playing by changing window focus, spotify mute macro
- Enable / Disable automute with Ctrl + M
- Get Status of automute with Ctrl + Shift + M (only works when GUI is closes)

# Problems
- advertisement detected by title of spotify, if spotify uses other titles, ad wont be muted
- a few milliseconds no focus on active program (espacially problematic in games) when muting, refreshing title in GUI
- problems with full screen apps (like games), some wont get focus after setting focus to spotify
-> suggest turning it completely off for such programs