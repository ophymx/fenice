namespace Fenice {

public class OptionsParser {
    private GLib.OptionEntry[] options = {};
    private string args_description;

    public OptionsParser(string args_description) {
        this.args_description = args_description;
    }

    public void add_flag(string long_name, char short_name,
        ref bool arg_reference, string description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = OptionArg.NONE;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = null;
        options += option;
    }

    public void add_option(string long_name, char short_name,
        ref string arg_reference, string description, string arg_description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = OptionArg.STRING;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = arg_description;
        options += option;
    }

    public void add_int(string long_name, char short_name,
        ref int arg_reference, string description, string arg_description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = OptionArg.INT;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = arg_description;
        options += option;
    }

    public void add_file(string long_name, char short_name,
        ref string arg_reference, string description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = OptionArg.FILENAME;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = "FILE";
        options += option;
    }

    public void add_directory(string long_name, char short_name,
        ref string arg_reference, string description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = OptionArg.FILENAME;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = "DIRECTORY";
        options += option;
    }

    public void parse(string[] args){
        var opt_context = new OptionContext(args_description);
        opt_context.set_help_enabled(true);
        opt_context.add_main_entries(options, null);
        opt_context.parse(ref args);
    }
}

}
