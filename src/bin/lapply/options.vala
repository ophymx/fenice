namespace Fenice.Lapply {

public class Options {
    public bool   percent = false;
    public string checksum = "sha1";
    public bool   create_missing_dirs = false;
    public string event = "lapply";
    public string host = "radmind";
    public bool   line_buffer = false;
    public bool   case_insensitive = false;
    public bool   unset_user_flags = false;
    public bool   no_network = false;
    public int    port = 6222;
    public string cert_dir = "";
    public bool   quiet = false;
    public bool   use_randfile_env = false;
    public string umask = "0077";
    public bool   print_version = false;
    public bool   verbose = false;
    public int    auth_level = 0;
    public string ca_file = "/var/radmind/cert/ca.pem";
    public string cert_file = "/var/radmind/cert/cert.pem";
    public string key_file = "/var/radmind/cert/cert.pem";
    public int    compression_level = 0;

    public void parse(string[] args){
        OptionsParser parser = new OptionsParser("");

        parser.add_flag("percent", '%', ref percent,
            "percentage done progress output.");

        parser.add_option("checksum", 'c', ref checksum,
            "enables checksuming.",
            "CHECKSUM");

        parser.add_flag("missing-dirs", 'C', ref create_missing_dirs,
            "create missing intermediate directories.");

        parser.add_option("event", 'e', ref event,
            "",
            "EVENT");

        parser.add_option("host", 'h', ref host,
            "",
            "HOST");

        parser.add_flag("line-buffer", 'i', ref line_buffer,
            "");

        parser.add_flag("case-insensitive", 'I', ref case_insensitive,
            "be case insensitive when compairing paths.");

        parser.add_flag("without-flags", 'F', ref unset_user_flags,
            "");

        parser.add_flag("no-network", 'n', ref no_network,
            "");

        parser.add_int("port", 'p', ref port,
            "",
            "PORT");

        parser.add_directory("certdir", 'P', ref cert_dir,
            "");

        parser.add_flag("quiet", 'q', ref quiet,
            "");

        parser.add_flag("randfile", 'r', ref use_randfile_env,
            "");

        parser.add_option("umask", 'u', ref umask,
            "", "UMASK");

        parser.add_flag("version", 'V', ref print_version,
            "");

        parser.add_flag("verbose", 'v', ref verbose,
            "");

        parser.add_int("auth-level", 'w', ref auth_level,
            "",
            "LEVEL");

        parser.add_file("ca", 'x', ref ca_file,
            "");

        parser.add_file("cert", 'y',  ref cert_file,
            "");

        parser.add_file("privkey", 'z', ref key_file,
            "");

        parser.add_int("compression", 'Z', ref compression_level,
            "",
            "LEVEL");

        parser.parse(args);
    }
}

}
