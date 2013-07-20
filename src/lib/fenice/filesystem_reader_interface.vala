namespace Fenice {

public interface FilesystemReader : Object {
    public abstract TranscriptEntry read(string path,
        Gee.Map<ulong, Tpath?> inodes);
    public abstract Gee.Iterable<string> get_directory_entries(string dirname);
}

}
