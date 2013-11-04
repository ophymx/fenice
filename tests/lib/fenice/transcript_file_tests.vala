using Fenice;
public class TranscriptFileTests : TranscriptTests {

    public TranscriptFileTests() {
        base("TranscriptFile");
        add_test(".iterator() simple transcript file", test_simple_file);
    }

    public void test_simple_file() {
        var test_transcript = new TranscriptFile("test.T", ASSETS_DIR);
        var iter = test_transcript.iterator();

        assert(iter.next());
        assert(iter.get().equal(
            new Tlink(path_t("./hardlink"),
                target_t(path_t("./hardlink-target"))
            )
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tdir(path_t("./dir"), mode_t(0755), uid_t(10), gid_t(11))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tchar(path_t("./dev/null"), mode_t(0666), uid_t(0), gid_t(0), 1,
                3)
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tblock(path_t("./dev/sda"), mode_t(0660), uid_t(0), gid_t(1), 8,
                0)
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tsymlink(path_t("./tmp"), mode_t(0777), uid_t(0), gid_t(0),
                target_t(path_t("./var/tmp")))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tsocket(path_t("./dev/log"), mode_t(0666), uid_t(0), gid_t(0))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tpipe(path_t("./var/run/pipe"), mode_t(0644), uid_t(12),
                gid_t(0))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tfile(
                path_t("./bar.txt"), mode_t(0644), uid_t(2), gid_t(8),
                mtime_t(1374205432), fsize_t(5),
                checksum_t("rLrvJ15Gp/FMHvRW//LIu+jIRyQ=")
            )
        ));

        assert(!iter.next());
    }
}
