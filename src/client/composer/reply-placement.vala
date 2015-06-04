/* Copyright 2011-2015 Yorba Foundation
 *
 * This software is licensed under the GNU Lesser General Public License
 * (version 2.1 or later).  See the COPYING file in this distribution.
 */

/**
 * A representation of the top posting options
 */

public enum Geary.ReplyPlacement {
    AUTO,
    TOP,
    BOTTOM;
    
    public static ReplyPlacement[] get_placemens() {
        return { AUTO, TOP, BOTTOM };
    }
    
    /**
     * Returns the option in a serialized form.
     *
     * @see from_string
     */
    public string to_string() {
        switch (this) {
            case AUTO:
                return "AUTO";
            
            case TOP:
                return "TOP";
            
            case BOTTOM:
                return "BOTTOM";
            
            default:
                assert_not_reached();
        }
    }
    
    /**
     * Returns the option name in a translated UTF-8 string suitable for display to the
     * user.
     */
    public string display_name() {
        switch (this) {
            case AUTO:
                return _("Auto");
            
            case TOP:
                return _("Top");
            
            case BOTTOM:
                return _("Bottom");
            
            default:
                assert_not_reached();
        }
    }
    
    /**
     * Converts a string form of the option (returned by {@link to_string} to a
     * {@link ReplyPlacement} value.
     *
     * @see to_string
     */
    public static ReplyPlacement from_string(string str) {
        switch (str.up()) {
            case "AUTO":
                return AUTO;
            
            case "TOP":
                return TOP;
            
            case "BOTTOM":
                return BOTTOM;
            
            default:
                assert_not_reached();
        }
    }
}

