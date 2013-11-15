namespace Fenice {

public class Fswalker : Object, Transcript {

    private string path;
    private Gee.Set<string> _excludes;

    public Fswalker(string path, Gee.Set<string> excludes) {
        this.path = path;
        _excludes = excludes;
    }

    public TranscriptIterator iterator() {
        return new FswalkerIterator(path);
    }
}

public class FswalkerIterator : Object, TranscriptIterator {

    private Gee.Map<ulong, path_t?> inodes = new Gee.HashMap<ulong, path_t?>();

    private Gee.Deque<Gee.Iterator<string>> directory_iterators =
        new Gee.LinkedList<Gee.Iterator<string>>();

    private TranscriptEntry current;
    private FilesystemReader fs_reader;

    private string path;

    public FswalkerIterator(string path, FilesystemReader fs_reader =
        new PosixReader()) {
        this.path = path;
        this.fs_reader = fs_reader;
    }

    public bool next() {
        if (current != null) {
            if (current is Tdir) {
                if ((current as Tdir).check) {
                    push_directory();
                }
            }

            if (directory_iterators.is_empty)
                return false;

            while (!directory_iterators.peek_head().next()) {
                pop_directory();
                if (directory_iterators.is_empty)
                    return false;
            }
        }
        current = fs_reader.read(current_path(), ref inodes);
        return true;
    }

    public new TranscriptEntry get() {
        return current;
    }

    private void push_directory() {
        var dirents = fs_reader.get_directory_entries(current.path.path);
        directory_iterators.offer_head(dirents.iterator());
    }

    private void pop_directory() {
        directory_iterators.poll_head();
    }

    private string current_path() {
        StringBuilder builder = new StringBuilder();
        foreach (var iter in directory_iterators) {
            if (builder.len != 0)
                builder.prepend_c(Path.DIR_SEPARATOR);
            builder.prepend(iter.get());
        }
        if (builder.len != 0)
            builder.prepend_c(Path.DIR_SEPARATOR);
        builder.prepend(path);
        return builder.str;
    }
}

}
