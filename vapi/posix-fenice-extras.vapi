namespace Posix {
    [CCode (cprefix = "FNM_", cname = "int", has_type_id = false)]
    public enum FnmatchFlags {
        NOESCAPE,
        PATHNAME,
        PERIOD
    }

    [CCode (cheader_filename = "fnmatch.h")]
    public int fnmatch(string pattern, string str, FnmatchFlags flags);
}
