namespace Fenice {

public class WSVFile : Object {

    private File file;

    public WSVFile(string filename) {
        this.file = File.new_for_path(filename);
    }

    public WSVFileIterator iterator() {
        DataInputStream data_stream;
        try {
            data_stream = new DataInputStream(file.read());
        } catch (Error e) {
            stderr.printf("%s: %s\n", e.message, file.get_path());
            Process.exit(1);
        }
        return new WSVFileIterator(data_stream);
    }
}

public class WSVFileIterator : Object {

    private DataInputStream data_stream;

    public struct Entry {
        public bool blank;
        public bool minus;
        public bool comment;
        public string[] args;

        public Entry() {
            blank = false;
            minus = false;
            comment = false;
            args = new string[0];
        }
    }

    private Entry? current_entry;
    private Entry? next_entry;

    public WSVFileIterator(DataInputStream data_stream) {
        this.data_stream = data_stream;
    }

    public bool next() {
        current_entry = next_entry;
        size_t size;
        string line;

        try {
            line = data_stream.read_line_utf8(out size);
            if (line != null) {
                next_entry = parse(line);
            } else {
                next_entry = null;
            }
        } catch (Error e) {
            stderr.printf("%s\n", e.message);
            return false;
        }

        if (current_entry == null) {
            if (next_entry == null)
                return false;
            else
                return next();
        } else {
            return true;
        }
    }

    public bool has_next() {
        return next_entry != null;
    }

    public bool first() {
        if (data_stream.seek(0, SeekType.SET)) {
            current_entry = null;
            next_entry = null;
            return next();
        }
        return false;
    }

    public new Entry get() {
        return current_entry;
    }

    private Entry parse(string line) {
        string[] args = Regex.split_simple("[ \t]+", line);
        int start_arg = 0;
        Entry entry = Entry();

        if (args.length == 0) {
            entry.blank = true;
            return entry;
        }

        if (args[0].has_prefix("#")) {
            entry.comment = true;
            return entry;
        }

        if (args[0] == "-") {
            entry.minus = true;
            start_arg = 1;
        }

        if (args.length > start_arg) {
            entry.args = args[(start_arg):(args.length)];
        }

        return entry;
    }
}

}
