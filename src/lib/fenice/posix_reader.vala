namespace Fenice {

public class PosixReader : Object, FilesystemReader {

    public TranscriptEntry read(string filename,
        ref Gee.Map<ulong, path_t?> inodes) {
        Posix.Stat stat;
        uint major, minor;

        Posix.lstat(filename, out stat);
        ulong inode = (ulong) stat.st_ino;
        path_t path = path_t(filename);

        if (inodes.has_key(inode))
            return new Tlink(path, target_t(inodes[inode]));

        inodes[inode] = path;

        mode_t mode = mode_t((uint) stat.st_mode & mode_t.PERM_MASK);
        gid_t gid = gid_t((uint) stat.st_gid);
        uid_t uid = uid_t((uint) stat.st_uid);

        switch (stat.st_mode & Posix.S_IFMT) {
            case Posix.S_IFDIR:
                return new Tdir(path, mode, uid, gid);

            case Posix.S_IFCHR:
                major = Posix.major(stat.st_rdev);
                minor = Posix.minor(stat.st_rdev);
                return new Tchar(path, mode, uid, gid, major, minor);

            case Posix.S_IFBLK:
                major = Posix.major(stat.st_rdev);
                minor = Posix.minor(stat.st_rdev);
                return new Tblock(path, mode, uid, gid, major, minor);

            case Posix.S_IFLNK:
                target_t target = target_t.from_symlink(filename);
                return new Tsymlink(path, mode, uid, gid, target);

            case Posix.S_IFSOCK:
                return new Tsocket(path, mode, uid, gid);

            case Posix.S_IFIFO:
                return new Tpipe(path, mode, uid, gid);

            case Posix.S_IFREG:
            default:
                mtime_t mtime = mtime_t(stat.st_mtime);
                fsize_t size = fsize_t(stat.st_size);
                checksum_t checksum = checksum_t.from_file(filename);
                return new Tfile(path, mode, uid, gid, mtime, size, checksum);
        }
    }

    public Gee.Iterable<string> get_directory_entries(string dirname) {
        Gee.TreeSet<string> entries = new Gee.TreeSet<string>();

        try {
            Dir dir = Dir.open(dirname);
            string dirent = dir.read_name();
            while (dirent != null) {
                entries.add(dirent);
                dirent = dir.read_name();
            }
        } catch (FileError e) {
            stdout.printf("%s\n", e.message);
        }

        return entries;
    }
}

}
