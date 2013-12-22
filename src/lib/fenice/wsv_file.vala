namespace Fenice {

public class WSVFile : Object {
    private string filename;
    private string base_dir;

    public WSVFile(string base_dir, string filename) {
        this.base_dir = base_dir;
        this.filename = filename;
    }

    public Iterator iterator() {
        DataInputStream data_stream;
        var path = Path.build_filename(base_dir, filename);
        try {
            var file = File.new_for_path(path);
            data_stream = new DataInputStream(file.read());
        } catch (Error e) {
            stderr.printf("%s: %s\n", e.message, path);
            Process.exit(1);
        }
        return new Iterator(data_stream);
    }

    public struct Entry {
        public bool blank;
        public bool minus;
        public bool comment;
        public string[] args;
        public int line_number;

        private static Regex _separator;
        private static Regex separator() {
            if (_separator == null) {
                try {
                    _separator = new Regex("[ \t]+");
                } catch (RegexError e) {
                    assert_not_reached();
                }
            }
            return _separator;
        }

        public static Entry parse(int line_number, string line) {
            var entry = Entry() {
                blank = false,
                minus = false,
                comment = false,
                args = new string[0],
                line_number = line_number
            };

            var args = separator().split(line);
            int start = 0;

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

    public class Iterator : Object {
        private DataInputStream data_stream;
        private Entry? current;
        private int line_number = 0;

        public Iterator(DataInputStream data_stream) {
            this.data_stream = data_stream;
        }

        public bool next() {
            try {
                var line = data_stream.read_line_utf8(null);
                if (line != null) {
                    line_number++;
                    current = Entry.parse(line_number, line);
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

        public new Entry get() {
            return current;
        }
    }
}

}
