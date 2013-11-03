namespace Fenice {

public class WSVFile : Object {

    private string filename;
    private string base_dir;

    public struct Entry {
        public bool blank;
        public bool minus;
        public bool comment;
        public string[] args;
        public int line_number;

        public Entry() {
            blank = false;
            minus = false;
            comment = false;
            args = new string[0];
            line_number = 0;
        }
    }

    public WSVFile(string base_dir, string filename) {
        this.base_dir = base_dir;
        this.filename = filename;
    }

    public WSVFileIterator iterator() {
        DataInputStream data_stream;
        string path = Path.build_filename(base_dir, filename);
        try {
            File file = File.new_for_path(path);
            data_stream = new DataInputStream(file.read());
        } catch (Error e) {
            stderr.printf("%s: %s\n", e.message, path);
            Process.exit(1);
        }
        return new WSVFileIterator(data_stream);
    }
}

public class WSVFileIterator : Object {

    private DataInputStream data_stream;

    private WSVFile.Entry? current_entry;
    private WSVFile.Entry? next_entry;
    private int line_number = 0;

    public WSVFileIterator(DataInputStream data_stream) {
        this.data_stream = data_stream;
    }

    public bool next() {
        current_entry = next_entry;
        size_t size;
        string line;

        line_number++;

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
            if (current_entry.blank || current_entry.comment)
                return next();
            else
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

    public new WSVFile.Entry get() {
        return current_entry;
    }

    private WSVFile.Entry parse(string line) {
        string[] args = Regex.split_simple("[ \t]+", line);
        int start_arg = 0;
        WSVFile.Entry entry = WSVFile.Entry();
        entry.line_number = line_number;

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
