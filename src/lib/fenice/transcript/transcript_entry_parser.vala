namespace Fenice {

public class TranscriptEntryParser : Object {

    public TranscriptEntry parse(string line) {
        ChangeType change_type = ChangeType.UNCHANGED;
        int start = 0;

        if (line.has_prefix("- ")) {
            change_type = ChangeType.REMOVED;
            start = 2;
        }

        string[] attrs = Regex.split_simple("[ \t]+", line.substring(start));

        path_t path = path_t.parse(attrs[1]);

        if (attrs[0] == "h")
            return new Tlink(path, target_t(path_t.parse(attrs[2])));

        mode_t mode = mode_t.parse(attrs[2]);
        uid_t uid = uid_t.parse(attrs[3]);
        gid_t gid = gid_t.parse(attrs[4]);
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
                mtime_t mtime = mtime_t.parse(attrs[5]);
                fsize_t size = fsize_t.parse(attrs[6]);
                checksum_t checksum = checksum_t.parse(attrs[7]);
                return new Tfile(path, mode, uid, gid, mtime, size, checksum,
                    change_type);

            case "l":
                target_t target = target_t.parse(attrs[5]);
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
