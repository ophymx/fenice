namespace Fenice.Lapply {

public class Options {
    public static bool   percent = false;
    public static string checksum;
    public static bool   create_missing_dirs = false;
    public static string event;
    public static string host;
    public static bool   line_buffer = false;
    public static bool   case_insensitive = false;
    public static bool   unset_user_flags = false;
    public static bool   no_network = false;
    public static int    port = 6222;
    public static string cert_dir;
    public static bool   quiet = false;
    public static bool   use_randfile_env = false;
    public static string umask;
    public static bool   print_version = false;
    public static bool   verbose = false;
    public static int    auth_level = 0;
    public static string ca_file;
    public static string cert_file;
    public static string key_file;
    public static int    compression_level = 0;
    [CCode (array_length = false, array_null_terminated = true)]
    public static static string[] transcripts;

    private const OptionEntry[] options = {
        { "percent", '%', 0, OptionArg.NONE, ref percent,
            "percentage done progress output.",
            null },
        { "checksum", 'c', 0, OptionArg.STRING, ref checksum,
            "enables checksuming.",
            "CHECKSUM" },
        { "missing-dirs", 'C', 0, OptionArg.NONE, ref create_missing_dirs,
            "create missing intermediate directories.",
            null },
        { "event", 'e', 0, OptionArg.STRING, ref event,
            "",
            "EVENT" },
        { "host", 'h', 0, OptionArg.STRING, ref host,
            "",
            "HOST" },
        { "line-buffer", 'i', 0, OptionArg.NONE, ref line_buffer,
            "",
            null },
        { "case-insensitive", 'I', 0, OptionArg.NONE, ref case_insensitive,
            "be case insensitive when compairing paths.",
            null },
        { "without-flags", 'F', 0, OptionArg.NONE, ref unset_user_flags,
            "",
            null },
        { "no-network", 'n', 0, OptionArg.NONE, ref no_network,
            "",
            null },
        { "port", 'p', 0, OptionArg.INT, ref port,
            "",
            "PORT" },
        { "certdir", 'P', 0, OptionArg.FILENAME, ref cert_dir,
            "",
            null },
        { "quiet", 'q', 0, OptionArg.NONE, ref quiet,
            "",
            null },
        { "randfile", 'r', 0, OptionArg.NONE, ref use_randfile_env,
            "",
            null },
        { "umask", 'u', 0, OptionArg.STRING, ref umask, "",
            "UMASK" },
        { "version", 'V', 0, OptionArg.NONE, ref print_version,
            "",
            null },
        { "verbose", 'v', 0, OptionArg.NONE, ref verbose,
            "",
            null },
        { "auth-level", 'w', 0, OptionArg.INT, ref auth_level,
            "",
            "LEVEL" },
        { "ca", 'x', 0, OptionArg.FILENAME, ref ca_file,
            "",
            null },
        { "cert", 'y', 0, OptionArg.FILENAME, ref cert_file,
            "",
            null },
        { "privkey", 'z', 0, OptionArg.FILENAME, ref key_file,
            "",
            null },
        { "compression", 'Z', 0, OptionArg.INT, ref compression_level,
            "",
            "LEVEL" },
        { "", 0, 0, OptionArg.FILENAME_ARRAY, ref transcripts,
            null,
            "TRANSCRIPT" },
        { null }
    };

    private static void set_defaults() {
        checksum = "sha1";
        event = "lapply";
        host = "radmind";
        cert_dir = "";
        umask = "0077";
        ca_file = "/var/radmind/cert/ca.pem";
        cert_file = "/var/radmind/cert/cert.pem";
        key_file = "/var/radmind/cert/cert.pem";
    }

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

    public static string transcript() {
        if (transcripts == null || transcripts.length == 0) {
            return "";
        } else {
            return transcripts[0];
        }

    }
}

}
