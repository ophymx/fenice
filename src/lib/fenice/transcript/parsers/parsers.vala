namespace Fenice {

public class LinkParser {
    public Tlink parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var target = target_t(path_t.parse(args[2]));
        return new Tlink(path, target, change_type);
    }
}

public class BlockParser {
    public Tblock parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var mode = mode_t.parse(args[2]);
        var uid = uid_t.parse(args[3]);
        var gid = gid_t.parse(args[4]);
        var major = int.parse(args[5]);
        var minor = int.parse(args[6]);
        return new Tblock(path, mode, uid, gid, major, minor, change_type);
    }
}

public class CharParser {
    public Tchar parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var mode = mode_t.parse(args[2]);
        var uid = uid_t.parse(args[3]);
        var gid = gid_t.parse(args[4]);
        var major = int.parse(args[5]);
        var minor = int.parse(args[6]);
        return new Tchar(path, mode, uid, gid, major, minor, change_type);
    }
}

public class DirParser {
    public Tdir parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var mode = mode_t.parse(args[2]);
        var uid = uid_t.parse(args[3]);
        var gid = gid_t.parse(args[4]);
        return new Tdir(path, mode, uid, gid, change_type);
    }
}

public class FileParser {
    public Tfile parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var mode = mode_t.parse(args[2]);
        var uid = uid_t.parse(args[3]);
        var gid = gid_t.parse(args[4]);
        var mtime = mtime_t.parse(args[5]);
        var size = fsize_t.parse(args[6]);
        var checksum = checksum_t.parse(args[7]);
        return new Tfile(path, mode, uid, gid, mtime, size, checksum,
            change_type);
    }
}

public class SymlinkParser {
    public Tsymlink parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var mode = mode_t.parse(args[2]);
        var uid = uid_t.parse(args[3]);
        var gid = gid_t.parse(args[4]);
        var target = target_t(path_t.parse(args[5]));
        return new Tsymlink(path, mode, uid, gid, target, change_type);
    }
}

public class PipeParser {
    public Tpipe parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var mode = mode_t.parse(args[2]);
        var uid = uid_t.parse(args[3]);
        var gid = gid_t.parse(args[4]);
        return new Tpipe(path, mode, uid, gid, change_type);
    }
}

public class SocketParser {
    public Tsocket parse(string[] args, ChangeType change_type) {
        var path = path_t.parse(args[1]);
        var mode = mode_t.parse(args[2]);
        var uid = uid_t.parse(args[3]);
        var gid = gid_t.parse(args[4]);
        return new Tsocket(path, mode, uid, gid, change_type);
    }
}

}
