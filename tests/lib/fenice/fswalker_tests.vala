using Fenice;
public class FswalkerTests : TranscriptTests {

    public FswalkerTests() {
        base("Fswalker");
        add_test("[Fswalker] identifies dev null as a char device",
            test_dev_null);
        add_test("[Fswalker] identifies dev loop0 as a block device",
            test_dev_loop0);
        add_test("[Fswalker] identifies dev log as a socket",
            test_dev_log);
        add_test("[Fswalker] identifies named pipe files",
            test_named_pipe);
        add_test("[Fswalker] identifies regular files",
            test_regular_file);
        add_test("[Fswalker] identifies directories",
            test_directory);
    }

    public override void set_up() {
        test_transcript = new Fswalker(ASSETS_DIR + "/walker_tests");
    }

    public override void tear_down() {
        test_transcript = null;
    }

    public void test_dev_null() {
        test_transcript = new Fswalker("/dev/null");
        foreach (var object in test_transcript) {
            assert(object.equal(
                new Tchar(Tpath("/dev/null"), Tmode(0666), Tuid(0), Tgid(0),
                    1, 3)
            ));
        }
    }

    public void test_dev_loop0() {
        test_transcript = new Fswalker("/dev/loop0");
        foreach (var object in test_transcript) {
            assert(object.equal(
                new Tblock(Tpath("/dev/loop0"), Tmode(0660), Tuid(0), Tgid(6),
                    7, 0)
            ));
        }
    }

    public void test_dev_log() {
        test_transcript = new Fswalker("/dev/log");
        foreach (var object in test_transcript) {
            assert(object.equal(
                new Tsocket(Tpath("/dev/log"), Tmode(0666), Tuid(0), Tgid(0))
            ));
        }
    }

    public void test_named_pipe() {
        run({"mkfifo", "/tmp/my_pipe", null});
        test_transcript = new Fswalker("/tmp/my_pipe");
        foreach (var object in test_transcript) {
            assert(object is Tpipe);
            var pipe = object as Tpipe;
            assert(pipe.path.equal(Tpath("/tmp/my_pipe")));
        }
        File.new_for_path("/tmp/my_pipe").delete();
    }

    public void test_regular_file() {
        test_transcript = new Fswalker(ASSETS_DIR + "/test.T");
        foreach (var object in test_transcript) {
            assert(object is Tfile);
            var file = object as Tfile;
            assert(file.path.equal(Tpath(ASSETS_DIR + "/test.T")));
        }
    }

    public void test_directory() {
        string test_dir = DirUtils.make_tmp(null);
        test_transcript = new Fswalker(test_dir);
        foreach (var object in test_transcript) {
            assert(object is Tdir);
            var dir = object as Tdir;
            assert(dir.path.equal(Tpath(test_dir)));
        }
        DirUtils.remove(test_dir);
    }

    private bool run(string[] argv) {
        return Process.spawn_sync(null, argv, null, SpawnFlags.SEARCH_PATH,
            null);
    }
}
