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
                next_object = parse_entry(line);
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

    private TranscriptEntry parse_entry(string line) {
        ChangeType change_type = ChangeType.UNCHANGED;
        int start = 0;

        if (line.has_prefix("- ")) {
            change_type = ChangeType.REMOVED;
            start = 2;
        }

        string[] attrs = Regex.split_simple("[ \t]+", line.substring(start));

        Tpath path = Tpath.parse(attrs[1]);

        if (attrs[0] == "h")
            return new Tlink(path, Ttarget(Tpath.parse(attrs[2])));

        Tmode mode = Tmode.parse(attrs[2]);
        Tuid uid = Tuid.parse(attrs[3]);
        Tgid gid = Tgid.parse(attrs[4]);
        int major, minor;

        switch (attrs[0]) {
            case "b":
                major = int.parse(attrs[5]);
                minor = int.parse(attrs[6]);
                return new Tblock(path, mode, uid, gid, major, minor,
                    change_type);

            case "c":
                major = int.parse(attrs[5]);
                minor = int.parse(attrs[6]);
                return new Tchar(path, mode, uid, gid, major, minor,
                    change_type);

            case "d":
                return new Tdir(path, mode, uid, gid, change_type);

            case "f":
                Tmtime mtime = Tmtime.parse(attrs[5]);
                Tsize size = Tsize.parse(attrs[6]);
                Tchecksum checksum = Tchecksum.parse(attrs[7]);
                return new Tfile(path, mode, uid, gid, mtime, size, checksum,
                    change_type);

            case "l":
                Ttarget target = Ttarget.parse(attrs[5]);
                return new Tsymlink(path, mode, uid, gid, target, change_type);

            case "p":
                return new Tpipe(path, mode, uid, gid, change_type);

            case "s":
                return new Tsocket(path, mode, uid, gid, change_type);

            default:
                assert_not_reached();
        }
    }
}

}
