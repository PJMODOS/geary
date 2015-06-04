/* Copyright 2011-2015 Yorba Foundation
 *
 * This software is licensed under the GNU Lesser General Public License
 * (version 2.1 or later).  See the COPYING file in this distribution.
 */

public class PreferencesDialog : Object {
    private Gtk.Dialog dialog;
    private Gtk.ComboBoxText combo_reply_placement;
    private Configuration config;
    
    public PreferencesDialog(Gtk.Window parent) {
        Gtk.Builder builder = GearyApplication.instance.create_builder("preferences.glade");
        
        // Get all of the dialog elements.
        dialog = builder.get_object("dialog") as Gtk.Dialog;
        dialog.set_transient_for(parent);
        dialog.set_modal(true);

        combo_reply_placement = (Gtk.ComboBoxText) builder.get_object("combo: reply_placement");
        foreach (Geary.ReplyPlacement p in Geary.ReplyPlacement.get_placemens())
            combo_reply_placement.append_text(p.display_name());
        
        config = GearyApplication.instance.config;
        config.bind(Configuration.AUTOSELECT_KEY, builder.get_object("autoselect"), "active");
        config.bind(Configuration.DISPLAY_PREVIEW_KEY, builder.get_object("display_preview"), "active");
        config.bind(Configuration.FOLDER_LIST_PANE_HORIZONTAL_KEY,
            builder.get_object("three_pane_view"), "active");
        config.bind(Configuration.SPELL_CHECK_KEY, builder.get_object("spell_check"), "active");
        config.bind(Configuration.PLAY_SOUNDS_KEY, builder.get_object("play_sounds"), "active");
        config.bind(Configuration.SHOW_NOTIFICATIONS_KEY, builder.get_object("show_notifications"), "active");
        config.bind(Configuration.STARTUP_NOTIFICATIONS_KEY, builder.get_object("startup_notifications"), "active");

        set_reply_placement(config.reply_placement);
        combo_reply_placement.changed.connect(on_reply_placement_changed);
    }
    
    public void run() {
        // Sync startup notification option with file state
        GearyApplication.instance.controller.autostart_manager.sync_with_config();
        dialog.show_all();
        dialog.run();
        dialog.destroy();
    }
    
    private void on_reply_placement_changed() {
        config.reply_placement = get_reply_placement();
    }

    private Geary.ReplyPlacement get_reply_placement() {
        return (Geary.ReplyPlacement) combo_reply_placement.get_active();
    }
    
    private void set_reply_placement(Geary.ReplyPlacement placement) {
        foreach (Geary.ReplyPlacement p in Geary.ReplyPlacement.get_placemens()) {
            if (p == placement)
                combo_reply_placement.set_active(p);
        }
        
        if (combo_reply_placement.get_active() == -1)
            combo_reply_placement.set_active(0);
    }
}

