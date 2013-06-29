namespace Fenice {

public class Fswalker : Object, Gee.Iterable<Tobject>, Transcript {

    public Type element_type { get { return typeof(Tobject); }}

    private string path;

    public Fswalker(string path) {
        this.path = path;
    }

    public Gee.Iterator<Tobject> iterator() {
        return new FswalkerIterator(path);
    }
}

public class FswalkerIterator : Object, Gee.Iterator<Tobject> {

    private Gee.Map<ulong, Tpath?> inodes = new Gee.HashMap<ulong, Tpath?>();

    private Gee.Deque<Gee.Iterator<string>> directory_iterators =
        new Gee.LinkedList<Gee.Iterator<string>>();

    private Tobject current;
    private FilesystemReader fs_reader;

    private string path;

    public FswalkerIterator(string path, FilesystemReader fs_reader =
        new PosixReader()) {
        this.path = path;
        this.fs_reader = fs_reader;
    }

    public bool next() {
        if (current != null) {
            if (current is Tdir)
                push_directory();

            if (directory_iterators.is_empty)
                return false;

            while (!directory_iterators.peek_head().next()) {
                pop_directory();
                if (directory_iterators.is_empty)
                    return false;
            }
        }
        current = fs_reader.read(current_path(), inodes);
        return true;
    }

    public bool has_next() {
        foreach (var iter in directory_iterators) {
            if (iter.has_next())
                return true;
        }
        return false;
    }

    public bool first() {
        inodes.clear();
        directory_iterators.clear();
        current = null;
        return next();
    }

    public new Tobject get() {
        return current;
    }

    public void remove() {
        assert_not_reached();
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
