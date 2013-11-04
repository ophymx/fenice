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

    private WSVFile.Entry? current;
    private int line_number = 0;

    public WSVFileIterator(DataInputStream data_stream) {
        this.data_stream = data_stream;
    }

    public bool next() {
        try {
            size_t size;
            string line = data_stream.read_line_utf8(out size);
            if (line != null) {
                line_number++;
                current = parse(line);
            } else {
                current = null;
            }
        } catch (Error e) {
            stderr.printf("%s\n", e.message);
            return false;
        }

        if (current == null)
            return false;

        if (current.blank || current.comment)
            return next();

        return true;
    }

    public new WSVFile.Entry get() {
        return current;
    }

    private WSVFile.Entry parse(string line) {
        string[] args = Regex.split_simple("[ \t]+", line);
        int start = 0;
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
            start = 1;
        }

        if (args.length > start) {
            entry.args = args[start:args.length];
        }

        return entry;
    }
}

}
