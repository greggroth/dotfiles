# Author: atraides <atr AT diii DOT eu>
# Homepage: http://github.com/atraides/gnotify
# Version: 0.3
#
# gnotify requires Growl Python Bindings
# See here: http://growl.info/documentation/developer/bindings.php
# Requires Weechat 0.3.0
# Released under GNU GPL v2
#
# gnotify is derived from notify http://www.weechat.org/files/scripts/notify.py
# gnotify is forked from gnotify http://github.com/tobypadilla/gnotify
# Original authors: lavaramano <lavaramano AT gmail DOT com>, tobypadilla <tobypadilla AT gmail DOT com>

import weechat, gntp.notifier, string

weechat.register("gnotify", "atraides", "0.3", "GPL", "gnotify: Growl notifications for Weechat", "", "")

# script options
settings = {
    "show_hilights"             : "on",
    "show_priv_msg"             : "on",
    "sticky"                    : "on",
}

# Init everything
for option, default_value in settings.items():
    if weechat.config_get_plugin(option) == "":
        weechat.config_set_plugin(option, default_value)

# Hook commands to setup stickynote command
hook = weechat.hook_command("stickynote", "Set stickyness of gnotify Growl notifications",
    "[on|off|toggle]",
    "'on' makes sticky, 'off' makes not sticky, 'toggle' toggles stickyness",
    "on || off || toggle",
    "stickynote_cmd",
    "")

def stickynote_cmd(data, buffer, args):
    isSticky = weechat.config_get_plugin('sticky')
    if (args == 'toggle'):
        isSticky = ('on' if isSticky == 'off' else 'off')
    elif (args == 'on' or args == 'off'):
        isSticky = args
    else:
        weechat.prnt("","Invalid stickynote option: "+args)
    weechat.config_set_plugin('sticky',isSticky)
    weechat.prnt("","Growl notification stickyness is "+isSticky)
    return weechat.WEECHAT_RC_OK

# Hook privmsg/hilights
weechat.hook_signal("weechat_pv", "notify_show_priv", "")
weechat.hook_signal("weechat_highlight", "notify_show_hi", "")

# Functions
def notify_show_hi( data, signal, message ):
    """Sends highlight message to be printed on notification"""
    if weechat.config_get_plugin('show_hilights') == "on":
        show_notification("Weechat",  message, 'highlight')
    return weechat.WEECHAT_RC_OK

def notify_show_priv( data, signal, message ):
    """Sends private message to be printed on notification"""
    if weechat.config_get_plugin('show_priv_msg') == "on":
        show_notification("Weechat Private Message",  message, 'privmsg')
    return weechat.WEECHAT_RC_OK

def show_notification(title,message,ntype):
    growl = gntp.notifier.GrowlNotifier(
        applicationName = 'gnotify',
        notifications = ['highlight','privmsg'],
        defaultNotifications = ['highlight'],
    )
    growl.register()

    isSticky = (True if weechat.config_get_plugin('sticky') == "on" else False)
    growl.notify(
        noteType = ntype,
        title = title,
        description = message,
        icon = 'http://gh.sapstar.eu/weechaticn.png',
        sticky = isSticky,
    )