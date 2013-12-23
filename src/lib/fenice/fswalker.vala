namespace Fenice {

public class Fswalker : Object, Transcript {

    private string path;
    private Filesystem fs;
    private Transcript transcript;

    public Fswalker(string path, Filesystem fs, Transcript transcript) {
        this.path = path;
        this.fs = fs;
        this.transcript = transcript;
    }

    public TranscriptIterator iterator() {
        return new FswalkerIterator(path, fs, transcript.iterator());
    }
}

public class FswalkerIterator : Object, TranscriptIterator {

    private Gee.Map<ulong, path_t?> inodes =
        new Gee.HashMap<ulong, path_t?>();

    private Gee.Deque<Gee.Iterator<string>> directory_iterators =
        new Gee.LinkedList<Gee.Iterator<string>>();

    private TranscriptEntry current;
    private TranscriptEntry expected;

    private Filesystem fs;
    private TranscriptIterator transcript;

    private string path;

    public FswalkerIterator(string path, Filesystem fs,
        TranscriptIterator transcript) {
        this.path = path;
        this.fs = fs;
        this.transcript = transcript;
    }

    public bool next() {
        var compare = compare_paths();
        if (compare == 0) {
            current = next_fs();
            expected = next_expected();
        } else if (compare < 0) {
            expected = next_expected();
        } else {
            current = next_fs();
        }

        return expected != null || current != null;
    }

    public new TranscriptEntry get() {
        TranscriptEntry result;
        if (compare_paths() >= 0) {
            result = (!) current;
            if (objects_match()) {
                result.change_type = ChangeType.UNCHANGED;
            }
        } else {
            result = (!) expected;
            result.change_type = ChangeType.REMOVED;
        }
        return result;
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

    private TranscriptEntry? next_fs() {
        if (current != null) {
            if (current.recurse())
                push_directory();

            if (directory_iterators.is_empty)
                return null;

            while (!directory_iterators.peek_head().next()) {
                pop_directory();
                if (directory_iterators.is_empty)
                    return null;
            }
        }
        return fs.read(current_path(), ref inodes);
    }

    private TranscriptEntry? next_expected() {
        if (transcript.next()) {
            return transcript.get();
        } else {
            return null;
        }
    }

    private bool objects_match() {
        return expected != null && current != null && expected.equal(current);
    }

    private int compare_paths() {
        if (expected == null && current == null)
            return 0;
        if (current == null)
            return -1;
        if (expected == null)
            return 1;
        return expected.path.compare_to(current.path);
    }
}

}
