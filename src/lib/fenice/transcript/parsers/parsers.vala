namespace Fenice {

public class LinkParser {
    public Tlink parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        target_t target = target_t(path_t.parse(args[2]));
        return new Tlink(path, target, change_type);
    }
}

public class BlockParser {
    public Tblock parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        mode_t mode = mode_t.parse(args[2]);
        uid_t uid = uid_t.parse(args[3]);
        gid_t gid = gid_t.parse(args[4]);
        int major = int.parse(args[5]);
        int minor = int.parse(args[6]);
        return new Tblock(path, mode, uid, gid, major, minor, change_type);
    }
}

public class CharParser {
    public Tchar parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        mode_t mode = mode_t.parse(args[2]);
        uid_t uid = uid_t.parse(args[3]);
        gid_t gid = gid_t.parse(args[4]);
        int major = int.parse(args[5]);
        int minor = int.parse(args[6]);
        return new Tchar(path, mode, uid, gid, major, minor, change_type);
    }
}

public class DirParser {
    public Tdir parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        mode_t mode = mode_t.parse(args[2]);
        uid_t uid = uid_t.parse(args[3]);
        gid_t gid = gid_t.parse(args[4]);
        return new Tdir(path, mode, uid, gid, change_type);
    }
}

public class FileParser {
    public Tfile parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        mode_t mode = mode_t.parse(args[2]);
        uid_t uid = uid_t.parse(args[3]);
        gid_t gid = gid_t.parse(args[4]);
        mtime_t mtime = mtime_t.parse(args[5]);
        fsize_t size = fsize_t.parse(args[6]);
        checksum_t checksum = checksum_t.parse(args[7]);
        return new Tfile(path, mode, uid, gid, mtime, size, checksum,
            change_type);
    }
}

public class SymlinkParser {
    public Tsymlink parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        mode_t mode = mode_t.parse(args[2]);
        uid_t uid = uid_t.parse(args[3]);
        gid_t gid = gid_t.parse(args[4]);
        target_t target = target_t(path_t.parse(args[5]));
        return new Tsymlink(path, mode, uid, gid, target, change_type);
    }
}

public class PipeParser {
    public Tpipe parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        mode_t mode = mode_t.parse(args[2]);
        uid_t uid = uid_t.parse(args[3]);
        gid_t gid = gid_t.parse(args[4]);
        return new Tpipe(path, mode, uid, gid, change_type);
    }
}

public class SocketParser {
    public Tsocket parse(string[] args, ChangeType change_type) {
        path_t path = path_t.parse(args[1]);
        mode_t mode = mode_t.parse(args[2]);
        uid_t uid = uid_t.parse(args[3]);
        gid_t gid = gid_t.parse(args[4]);
        return new Tsocket(path, mode, uid, gid, change_type);
    }
}

}
