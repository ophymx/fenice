namespace Fenice {

public class Fswalker : Object, Transcript {

    private string path;
    private Filesystem fs;

    public Fswalker(string path, Filesystem fs) {
        this.path = path;
        this.fs = fs;
    }

    public TranscriptIterator iterator() {
        return new FswalkerIterator(path, fs);
    }
}

public class FswalkerIterator : Object, TranscriptIterator {

    private Gee.Map<ulong, path_t?> inodes = new Gee.HashMap<ulong, path_t?>();

    private Gee.Deque<Gee.Iterator<string>> directory_iterators =
        new Gee.LinkedList<Gee.Iterator<string>>();

    private TranscriptEntry current;
    private Filesystem fs;

    private string path;

    public FswalkerIterator(string path, Filesystem fs) {
        this.path = path;
        this.fs = fs;
    }

    public bool next() {
        if (current != null) {
            if (current.recurse())
                push_directory();

            if (directory_iterators.is_empty)
                return false;

            while (!directory_iterators.peek_head().next()) {
                pop_directory();
                if (directory_iterators.is_empty)
                    return false;
            }
        }
        current = fs.read(current_path(), ref inodes);
        return true;
    }

    public new TranscriptEntry get() {
        return current;
    }

    private void push_directory() {
        var dirents = fs.dir_entries(current.path.path);
        directory_iterators.offer_head(dirents.iterator());
    }

    private void pop_directory() {
        directory_iterators.poll_head();
    }

    private string current_path() {
        var builder = new StringBuilder();
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
