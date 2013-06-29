namespace Fenice {

public class Lapply {
    private static bool percent = false;
    private static string checksum = "sha1";
    private static bool create_missing_dirs = false;
    private static string event = "lapply";
    private static string host = "radmind";
    private static bool line_buffer = false;
    private static bool case_insensitive = false;
    private static bool unset_user_flags = false;
    private static bool no_network = false;
    private static int port = 6222;
    private static string cert_dir = "";
    private static bool quiet = false;
    private static bool use_randfile_env = false;
    private static string umask = "0077";
    private static bool print_version = false;
    private static bool verbose = false;
    private static int auth_level = 0;
    private static string ca_file = "/var/radmind/cert/ca.pem";
    private static string cert_file = "/var/radmind/cert/cert.pem";
    private static string key_file = "/var/radmind/cert/cert.pem";
    private static int compression_level = 0;

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
            "percentage done progress output.",
            null
        },
        {   "checksum",
            'c', 0, OptionArg.STRING, ref checksum,
            "enables checksuming.",
            "CHECKSUM"
        },
        {   "missing-dirs",
            'C', 0, OptionArg.NONE, ref create_missing_dirs,
            "create missing intermediate directories.",
            null
        },
        {   "event",
            'e', 0, OptionArg.STRING, ref event,
            "",
            "EVENT"
        },
        {   "host",
            'h', 0, OptionArg.STRING, ref host,
            "",
            "HOST"
        },
        {   "line-buffer",
            'i', 0, OptionArg.NONE, ref line_buffer,
            "",
            null
        },
        {   "case-insensitive",
            'I', 0, OptionArg.NONE, ref case_insensitive,
            "be case insensitive when compairing paths.",
            null
        },
        {   "without-flags",
            'F', 0, OptionArg.NONE, ref unset_user_flags,
            "",
            null
        },
        {   "no-network",
            'n', 0, OptionArg.NONE, ref no_network,
            "",
            null
        },
        {   "port",
            'p', 0, OptionArg.INT, ref port,
            "",
            "PORT"
        },
        {   "certdir",
            'P', 0, OptionArg.FILENAME, ref cert_dir,
            "",
            "DIRECTORY"
        },
        {   "quiet",
            'q', 0, OptionArg.NONE, ref quiet,
            "",
            null
        },
        {   "randfile",
            'r', 0, OptionArg.NONE, ref use_randfile_env,
            "",
            null
        },
        {   "umask",
            'u', 0, OptionArg.STRING, ref umask,
            "",
            "UMASK"
        },
        {   "version",
            'V', 0, OptionArg.NONE, ref print_version,
            "",
            null
        },
        {   "verbose",
            'v', 0, OptionArg.NONE, ref verbose,
            "",
            null
        },
        {   "auth-level",
            'w', 0, OptionArg.INT, ref auth_level,
            "",
            "LEVEL"
        },
        {   "ca",
            'x', 0, OptionArg.FILENAME, ref ca_file,
            "",
            "FILE"
        },
        {   "cert",
            'y', 0, OptionArg.FILENAME, ref cert_file,
            "",
            "FILE"
        },
        {   "privkey",
            'z', 0, OptionArg.FILENAME, ref key_file,
            "",
            "FILE"
        },
        {   "compression",
            'Z', 0, OptionArg.INT, ref compression_level,
            "",
            "LEVEL"
        },
        { null }
    };

    public static int main(string[] args){
        try {
            var opt_context = new OptionContext("PATH");
            opt_context.set_help_enabled(true);
            opt_context.add_main_entries(options, null);
            opt_context.parse(ref args);
        } catch (OptionError e) {
            stderr.printf("error: %s\n", e.message);
            return 0;
        }

        stdout.printf("%d\n", args.length);

        return 0;
    }

}

}
