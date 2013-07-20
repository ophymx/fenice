namespace Fenice {

public interface FilesystemReader : Object {
    public abstract TranscriptEntry read(string path,
        ref Gee.Map<ulong, path_t?> inodes);
    public abstract Gee.Iterable<string> get_directory_entries(string dirname);
}

}
