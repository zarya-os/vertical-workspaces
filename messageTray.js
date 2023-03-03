/**
 * V-Shell (Vertical Workspaces)
 * messageTray.js
 *
 * @author     GdH <G-dH@github.com>
 * @copyright  2022 - 2023
 * @license    GPL-3.0
 *
 */

'use strict';

const { Clutter } = imports.gi;
const Me = imports.misc.extensionUtils.getCurrentExtension();
const Main = imports.ui.main;

let opt;

function update(reset = false) {
    if (reset) {
        opt = null;
        setNotificationPosition(1);
        return;
    }

    opt = Me.imports.settings.opt;
    setNotificationPosition(opt.NOTIFICATION_POSITION);
}

function setNotificationPosition(position) {
    switch (position) {
    case 0:
        Main.messageTray._bannerBin.x_align = Clutter.ActorAlign.START;
        Main.messageTray._bannerBin.y_align = Clutter.ActorAlign.START;
        break;
    case 1:
        Main.messageTray._bannerBin.x_align = Clutter.ActorAlign.CENTER;
        Main.messageTray._bannerBin.y_align = Clutter.ActorAlign.START;
        break;
    case 2:
        Main.messageTray._bannerBin.x_align = Clutter.ActorAlign.END;
        Main.messageTray._bannerBin.y_align = Clutter.ActorAlign.START;
        break;
    case 3:
        Main.messageTray._bannerBin.x_align = Clutter.ActorAlign.START;
        Main.messageTray._bannerBin.y_align = Clutter.ActorAlign.END;
        break;
    case 4:
        Main.messageTray._bannerBin.x_align = Clutter.ActorAlign.CENTER;
        Main.messageTray._bannerBin.y_align = Clutter.ActorAlign.END;
        break;
    case 5:
        Main.messageTray._bannerBin.x_align = Clutter.ActorAlign.END;
        Main.messageTray._bannerBin.y_align = Clutter.ActorAlign.END;
        break;
    }
}
