namespace Fenice {

public class PosixFilesystem : Object, Filesystem {

    public TranscriptEntry read(string filename,
        ref Gee.Map<ulong, path_t?> inodes) {
        Posix.Stat stat;

        Posix.lstat(filename, out stat);
        var inode = (ulong) stat.st_ino;
        var path = path_t(filename);

        if (inodes.has_key(inode))
            return new Tlink(path, target_t(inodes[inode]));

        inodes[inode] = path;

        var mode = mode_t((uint) stat.st_mode & mode_t.PERM_MASK);
        var gid = gid_t((uint) stat.st_gid);
        var uid = uid_t((uint) stat.st_uid);

        switch (stat.st_mode & Posix.S_IFMT) {
            case Posix.S_IFDIR:
                return new Tdir(path, mode, uid, gid);

            case Posix.S_IFCHR:
                var major = Linux.major(stat.st_rdev);
                var minor = Linux.minor(stat.st_rdev);
                return new Tchar(path, mode, uid, gid, major, minor);

            case Posix.S_IFBLK:
                var major = Linux.major(stat.st_rdev);
                var minor = Linux.minor(stat.st_rdev);
                return new Tblock(path, mode, uid, gid, major, minor);

            case Posix.S_IFLNK:
                var target = target_t.from_symlink(filename);
                return new Tsymlink(path, mode, uid, gid, target);

            case Posix.S_IFSOCK:
                return new Tsocket(path, mode, uid, gid);

            case Posix.S_IFIFO:
                return new Tpipe(path, mode, uid, gid);

            case Posix.S_IFREG:
            default:
                var mtime = mtime_t(stat.st_mtime);
                var size = fsize_t(stat.st_size);
                var checksum = checksum_t.from_file(filename);
                return new Tfile(path, mode, uid, gid, mtime, size, checksum);
        }
    }

    public Gee.Iterable<string> dir_entries(string dirname) {
        var entries = new Gee.TreeSet<string>();

        try {
            var dir = Dir.open(dirname);
            string? name;
            while ((name = dir.read_name()) != null) {
                entries.add(name);
            }
        } catch (FileError e) {
            stdout.printf("%s\n", e.message);
        }

        return entries;
    }
}

}
