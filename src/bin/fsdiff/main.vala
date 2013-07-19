namespace Fenice {

public class Fsdiff {
    private static bool percent = false;
    private static bool only_one = false;
    private static bool applicable_transcript = false;
    private static bool creatable_transcript = true;
    private static string? checksum = null;
    private static bool case_insensitive = false;
    private static string? command_file = null;
    private static string? output_file = null;
    private static bool print_version = false;
    private static bool print_warnings = false;

    private const GLib.OptionEntry[] options = {
        /*
            public unowned string long_name
            public char short_name
            public int flags
            public OptionArg arg
            public void* arg_data
            public unowned string description
            public unowned string? arg_description
        */
        {  "percent",
            '%', 0, OptionArg.NONE, ref percent,
            "percentage done progress output. Requires -o option.",
            null
        },
        {   "one",
            '1', 0, OptionArg.NONE, ref only_one,
            "prints out a single transcript line for the given file. " +
                "This option can be used to build negative transcripts.",
            null
        },
        {   "apply",
            'A', 0, OptionArg.NONE, ref applicable_transcript,
            "produces an applicable transcript.",
            null
        },
        {   "create",
            'C', 0, OptionArg.NONE, ref creatable_transcript,
            "produces a creatable transcript.",
            null
        },
        {   "checksum",
            'c', 0, OptionArg.STRING, ref checksum,
            "enables checksuming.",
            "CHECKSUM"
        },
        {   "case-insensitive",
            'I', 0, OptionArg.NONE, ref case_insensitive,
            "be case insensitive when compairing paths.",
            null
        },
        {   "command-file",
            'K', 0, OptionArg.FILENAME, ref command_file,
            "specifies a command file name, by default RADMIND_COMMANDFILE",
            "FILE",
        },
        {   "output",
            'o', 0, OptionArg.FILENAME, ref output_file,
            "specifies an output file, default is the standard output.",
            "FILE"
        },
        {   "version",
            'V', 0, OptionArg.NONE, ref print_version,
            "displays the version number of fsdiff, a list of supported " +
                "checksumming algorithms in descending order of preference " +
                "and then exits.",
            null
        },
        {   "warnings",
            'W', 0, OptionArg.NONE, ref print_warnings,
            "prints a warning to the standard error when encountering an " +
                "object matching an exclude pattern.",
            null
        },
        { null }
    };

    public static int main(string[] args){
        checksum = "sha1";
        output_file = "-";
        command_file = "/dev/null"; // "/var/radmind/client/command.K";
        try {
            var opt_context = new OptionContext("PATH");
            opt_context.set_help_enabled(true);
            opt_context.add_main_entries(options, null);
            opt_context.parse(ref args);
        } catch (OptionError e) {
            stderr.printf("error: %s\n", e.message);
            return 1;
        }

        FileStream output;
        if (output_file == "-") {
            output = (owned) stdout;
        } else {
            output = FileStream.open(output_file, "w");
        }

        string path = args[1];

        if (args.length == 2) {
            Loadset loadset = new Loadset();
            loadset.transcripts.add(new TranscriptFile(command_file));

            Transcript transcript = new TranscriptDiffer(loadset, new Fswalker(path));

            foreach (Tobject object in transcript) {
                if (object.change_type.has_changed()) {
                    output.printf("%s\n", object.to_string());
                }
            }
        } else {
            stderr.printf("error: wrong number of arguments\n");
            return 1;
        }

        return 0;
    }
}

}
