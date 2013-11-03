namespace Fenice {

public errordomain TranscriptEntryParserError {
    UNKNOWN_TYPE
}

public class TranscriptFile : Object, Transcript {

    private string filename;
    private string base_dir;

    public TranscriptFile(string filename, string base_dir) {
        this.filename = filename;
        this.base_dir = base_dir;
    }

    public TranscriptIterator iterator() {
        WSVFile wsv_file = new WSVFile(base_dir, filename);
        return new TranscriptFileIterator(filename, wsv_file.iterator());
    }
}

public class TranscriptFileIterator : Object, TranscriptIterator {

    private WSVFileIterator file_iter;
    private string filename;

    public TranscriptFileIterator(string filename, WSVFileIterator file_iter) {
        this.file_iter = file_iter;
        this.filename = filename;
    }

    public bool next() {
        return file_iter.next();
    }

    public bool has_next() {
        return file_iter.has_next();
    }

    public bool first() {
        return file_iter.first();
    }

    public new TranscriptEntry get() {
        return parse(file_iter.get());
    }

    private TranscriptEntry parse(WSVFile.Entry entry)
        throws TranscriptEntryParserError {
        ChangeType change_type = ChangeType.UNCHANGED;

        string type = entry.args[0];

        switch (type) {
            case "b":
                return (new BlockParser()).parse(entry.args, change_type);

            case "c":
                return (new CharParser()).parse(entry.args, change_type);

            case "d":
                return (new DirParser()).parse(entry.args, change_type);

            case "f":
                return (new FileParser()).parse(entry.args, change_type);

            case "h":
                return (new LinkParser()).parse(entry.args, change_type);

            case "l":
                return (new SymlinkParser()).parse(entry.args, change_type);

            case "p":
                return (new PipeParser()).parse(entry.args, change_type);

            case "s":
                return (new SocketParser()).parse(entry.args, change_type);

            default:
                throw new TranscriptEntryParserError.UNKNOWN_TYPE(
                    "%s:%d: unknown transcript entry type '%s'", filename,
                    entry.line_number, type);
        }
    }
}

}
