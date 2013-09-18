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

    public void parse(string[] args){
        OptionsParser parser = new OptionsParser("PATH");

        parser.add_flag("percent", '%', ref percent,
            "percentage done progress output. Requires -o option.");

        parser.add_flag("one", '1', ref only_one,
            "prints out a single transcript line for the given file. " +
                "This option can be used to build negative transcripts.");

        parser.add_flag("apply", 'A', ref applicable_transcript,
            "produces an applicable transcript.");

        parser.add_flag("create", 'C', ref creatable_transcript,
            "produces a creatable transcript.");

        parser.add_option("checksum", 'c', ref checksum,
            "enables checksuming.", "CHECKSUM");

        parser.add_flag("case-insensitive", 'I', ref case_insensitive,
            "be case insensitive when compairing paths.");

        parser.add_file("command-file", 'K', ref command_file,
            "specifies a command file name, by default RADMIND_COMMANDFILE");

        parser.add_file("output", 'o', ref output_file,
            "specifies an output file, default is the standard output.");

        parser.add_flag("version", 'V', ref print_version,
            "displays the version number of fsdiff, " +
            "a list of supported checksumming algorithms in descending " +
            "order of preference and then exits.");

        parser.add_flag("warnings", 'W', ref print_warnings,
            "prints a warning to the standard error " +
            "when encountering an object matching an exclude pattern.");

        parser.parse(args);
    }
}

}
