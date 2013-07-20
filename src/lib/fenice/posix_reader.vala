namespace Fenice {

public class PosixReader : Object, FilesystemReader {

    public TranscriptEntry read(string filename,
        Gee.Map<ulong, Tpath?> inodes) {
        Posix.Stat stat;
        int major, minor;

        Posix.lstat(filename, out stat);
        ulong inode = (ulong) stat.st_ino;
        Tpath path = Tpath(filename);

        if (inodes.has_key(inode))
            return new Tlink(path, Ttarget(inodes[inode]));

        inodes[inode] = path;

        Tmode mode = Tmode((uint) stat.st_mode & Tmode.PERM_MASK);
        Tgid gid = Tgid((uint) stat.st_gid);
        Tuid uid = Tuid((uint) stat.st_uid);

        switch (stat.st_mode & Posix.S_IFMT) {
            case Posix.S_IFDIR:
                return new Tdir(path, mode, uid, gid);

            case Posix.S_IFCHR:
                major = Linux.major(stat.st_rdev);
                minor = Linux.minor(stat.st_rdev);
                return new Tchar(path, mode, uid, gid, major, minor);

            case Posix.S_IFBLK:
                major = Linux.major(stat.st_rdev);
                minor = Linux.minor(stat.st_rdev);
                return new Tblock(path, mode, uid, gid, major, minor);

            case Posix.S_IFLNK:
                Ttarget target = Ttarget.from_symlink(filename);
                return new Tsymlink(path, mode, uid, gid, target);

            case Posix.S_IFSOCK:
                return new Tsocket(path, mode, uid, gid);

            case Posix.S_IFIFO:
                return new Tpipe(path, mode, uid, gid);

            case Posix.S_IFREG:
            default:
                Tmtime mtime = Tmtime(stat.st_mtime);
                Tsize size = Tsize(stat.st_size);
                Tchecksum checksum = Tchecksum.from_file(filename);
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
