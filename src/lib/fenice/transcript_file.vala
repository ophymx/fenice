namespace Fenice {

public class TranscriptFile : Object, Transcript {

    private File file;

    public TranscriptFile(string filename) {
        this.file = File.new_for_path(filename);
    }

    public TranscriptIterator iterator() {
        DataInputStream data_stream = new DataInputStream(file.read());
        return new TranscriptFileIterator(data_stream);
    }
}

public class TranscriptFileIterator : Object, TranscriptIterator {

    private DataInputStream data_stream;

    private TranscriptEntry current;
    private TranscriptEntry next_object;

    private TranscriptEntryLineParser line_parser =
        new TranscriptEntryLineParser();

    public TranscriptFileIterator(DataInputStream data_stream) {
        this.data_stream = data_stream;
    }

    public bool next() {
        current = next_object;
        size_t size;
        string line;

        try {
            line = data_stream.read_line_utf8(out size);
            if (line != null) {
                next_object = line_parser.parse(line);
            } else {
                next_object = null;
            }
        } catch (Error e) {
            stderr.printf("%s\n", e.message);
            return false;
        }

        if (current == null) {
            if (next_object == null)
                return false;
            else
                return next();
        } else {
            return true;
        }
    }

    public bool has_next() {
        return next_object != null;
    }

    public bool first() {
        if (data_stream.seek(0, SeekType.SET)) {
            current = null;
            next_object = null;
            return next();
        }
        return false;
    }

    public new TranscriptEntry get() {
        return current;
    }
}

}
