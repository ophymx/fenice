namespace Fenice.Fsdiff {

public class Options {
    public static bool     percent = false;
    public static bool     only_one = false;
    public static bool     applicable_transcript = false;
    public static bool     creatable_transcript = true;
    public static string   checksum;
    public static bool     case_insensitive = false;
    public static string   command_file;
    public static string   output_file;
    public static bool     print_version = false;
    public static bool     print_warnings = false;
    [CCode (array_length = false, array_null_terminated = true)]
    public static string[] paths;

    private const OptionEntry[] options = {
        { "percent", '%', 0, OptionArg.NONE, ref percent,
            "percentage done progress output. Requires -o option.",
            null },
        { "one", '1', 0, OptionArg.FILENAME, ref only_one,
            "prints out a single transcript line for the given file. " +
                "This option can be used to build negative transcripts.",
            "FILE" },
        { "apply", 'A', 0, OptionArg.NONE, ref applicable_transcript,
            "produces an applicable transcript.",
            null },
        { "create", 'C', 0, OptionArg.NONE, ref creatable_transcript,
            "produces a creatable transcript.",
            null },
        { "checksum", 'c', 0, OptionArg.STRING, ref checksum,
            "enables checksuming.",
            "CHECKSUM" },
        { "case-insensitive", 'I', 0, OptionArg.NONE, ref case_insensitive,
            "be case insensitive when compairing paths.",
            null },
        { "command-file", 'K', 0, OptionArg.FILENAME, ref command_file,
            "specifies a command file name, by default RADMIND_COMMANDFILE",
            "FILE" },
        { "output", 'o', 0, OptionArg.FILENAME, ref output_file,
            "specifies an output file, default is the standard output.",
            "FILE" },
        { "version", 'V', 0, OptionArg.NONE, ref print_version,
            "displays the version number of fsdiff, a list of supported " +
                "checksumming algorithms in descending order of preference " +
                "and then exits.",
            null },
        { "warnings", 'W', 0, OptionArg.NONE, ref print_warnings,
            "prints a warning to the standard error when encountering an " +
                "object matching an exclude pattern.",
            null },
        { "", 'W', 0, OptionArg.FILENAME_ARRAY, ref paths, null, "PATH" },
        { null }
    };

    public static int parse(string[] args) {
        set_defaults();
        try {
            var opt_context = new OptionContext();
            opt_context.set_help_enabled(true);
            opt_context.add_main_entries(options, null);
            opt_context.parse(ref args);
        } catch (OptionError e) {
            stdout.printf("%s\n", e.message);
            stdout.printf("Run '%s --help' to see a full list of available command line options.\n", args[0]);
            return 1;
        }
        return 0;
    }

    private static void set_defaults() {
        checksum = "sha1";
        command_file = "/dev/null";
        output_file = "-";
    }

    public static string path() {
        if (paths == null || paths.length == 0) {
            return "";
        } else {
            return paths[0];
        }

    }
}

}
