using Fenice;
public class PosixFilesystemTests : TranscriptTests {

    public PosixFilesystemTests() {
        base("PosixFilesystem");
        add_test(".read() identifies dev null as a char device",
            test_dev_null);
        add_test(".read() identifies dev loop0 as a block device",
            test_dev_loop0);
        add_test(".read() identifies dev log as a socket",
            test_dev_log);
        add_test(".read() identifies named pipe files",
            test_named_pipe);
        add_test(".read() identifies regular files",
            test_regular_file);
        add_test(".read() identifies directories",
            test_directory);
    }

    protected Gee.Map<ulong, path_t?> inodes;
    protected Filesystem fs;

    public override void set_up() {
        inodes = new Gee.HashMap<ulong, path_t?>();
        fs = new PosixFilesystem();
    }

    public override void tear_down() {
        fs = null;
        inodes = null;
    }

    public void test_dev_null() {
        var path = "/dev/null";
        var object = fs.read(path, ref inodes);
        assert(object.equal(
            new Tchar(path_t(path), mode_t(0666), uid_t(0), gid_t(0), 1, 3)
        ));
    }

    public void test_dev_loop0() {
        var path = "/dev/loop0";
        var object = fs.read(path, ref inodes);
        assert(object.equal(
            new Tblock(path_t(path), mode_t(0660), uid_t(0), gid_t(6), 7, 0)
        ));
    }

    public void test_dev_log() {
        var path = "/dev/log";
        var object = fs.read(path, ref inodes);
        assert(object.equal(
            new Tsocket(path_t(path), mode_t(0666), uid_t(0), gid_t(0))
        ));
    }

    public void test_named_pipe() {
        var path = "/tmp/my_pipe";
        run({"mkfifo", path, null});
        var pipe = fs.read(path, ref inodes) as Tpipe;
        assert(pipe != null);
        assert(pipe.path.equal(path_t(path)));
        File.new_for_path(path).delete();
    }

    public void test_regular_file() {
        var path = ASSETS_DIR + "/test.T";
        var file = fs.read(path, ref inodes) as Tfile;
        assert(file != null);
        assert(file.path.equal(path_t(path)));
    }

    public void test_directory() {
        var path = DirUtils.make_tmp(null);
        var dir = fs.read(path, ref inodes) as Tdir;
        assert(dir != null);
        assert(dir.path.equal(path_t(path)));
        DirUtils.remove(path);
    }

    private bool run(string[] argv) {
        return Process.spawn_sync(null, argv, null, SpawnFlags.SEARCH_PATH,
            null);
    }
}
