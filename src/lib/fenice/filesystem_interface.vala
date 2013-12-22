namespace Fenice {

public interface Filesystem : Object {
    public abstract TranscriptEntry read(string path,
        ref Gee.Map<ulong, path_t?> inodes);
    public abstract Gee.Iterable<string> dir_entries(string dirname);
}

}
