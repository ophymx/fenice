namespace Fenice.Fsdiff {

public class Options {
    public bool   percent = false;
    public bool   only_one = false;
    public bool   applicable_transcript = false;
    public bool   creatable_transcript = true;
    public string checksum = "sha1";
    public bool   case_insensitive = false;
    public string command_file = "/dev/null"; // /var/radmind/client/command.K
    public string output_file = "-";
    public bool   print_version = false;
    public bool   print_warnings = false;

    private GLib.OptionEntry flag(string long_name, char short_name,
        ref bool arg_reference, string description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = OptionArg.NONE;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = null;
        return option;
    }

    private GLib.OptionEntry option(string long_name, char short_name,
        GLib.OptionArg arg_type, ref string arg_reference, string description,
        string arg_description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = arg_type;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = arg_description;
        return option;
    }

    private GLib.OptionEntry file(string long_name, char short_name,
        ref string arg_reference, string description) {
        GLib.OptionEntry option = GLib.OptionEntry();
        option.long_name        = long_name;
        option.short_name       = short_name;
        option.flags            = 0;
        option.arg              = OptionArg.FILENAME;
        option.arg_data         = (void*) arg_reference;
        option.description      = description;
        option.arg_description  = "FILE";
        return option;
    }

    public void parse(string[] args){
        GLib.OptionEntry[] options = {};

        options += flag("percent", '%', ref percent,
            "percentage done progress output. Requires -o option.");

        options += flag("one", '1', ref only_one,
            "prints out a single transcript line for the given file. " +
                "This option can be used to build negative transcripts.");

        options += flag("apply", 'A', ref applicable_transcript,
            "produces an applicable transcript.");

        options += flag("create", 'C', ref creatable_transcript,
            "produces a creatable transcript.");

        options += option("checksum", 'c', OptionArg.STRING, ref checksum,
            "enables checksuming.", "CHECKSUM");

        options += flag("case-insensitive", 'I', ref case_insensitive,
            "be case insensitive when compairing paths.");

        options += file( "command-file", 'K', ref command_file,
            "specifies a command file name, by default RADMIND_COMMANDFILE");

        options += file( "output", 'o', ref output_file,
            "specifies an output file, default is the standard output.");

        options += flag( "version", 'V', ref print_version,
            "displays the version number of fsdiff, " +
            "a list of supported checksumming algorithms in descending " +
            "order of preference and then exits.");

        options += flag( "warnings", 'W', ref print_warnings,
            "prints a warning to the standard error " +
            "when encountering an object matching an exclude pattern.");

        var opt_context = new OptionContext("PATH");
        opt_context.set_help_enabled(true);
        opt_context.add_main_entries(options, null);
        opt_context.parse(ref args);
    }
}

}
