using Fenice;
public class TranscriptFileTests : TranscriptTests {

    public TranscriptFileTests() {
        base("TranscriptFile");
        add_test(".iterator() simple transcript file", test_simple_file);
    }

    public void test_simple_file() {
        TranscriptEntry[] expected = {
            new Tlink(path_t("./hardlink"),
                target_t(path_t("./hardlink-target"))),
            new Tdir(path_t("./dir"), mode_t(0755), uid_t(10), gid_t(11)),
            new Tchar(path_t("./dev/null"), mode_t(0666), uid_t(0), gid_t(0),
                1, 3),
            new Tblock(path_t("./dev/sda"), mode_t(0660), uid_t(0), gid_t(1),
                8, 0),
            new Tsymlink(path_t("./tmp"), mode_t(0777), uid_t(0), gid_t(0),
                target_t(path_t("./var/tmp"))),
            new Tsocket(path_t("./dev/log"), mode_t(0666), uid_t(0), gid_t(0)),
            new Tpipe(path_t("./var/run/pipe"), mode_t(0644), uid_t(12),
                gid_t(0)),
            new Tfile(path_t("./bar.txt"), mode_t(0644), uid_t(2), gid_t(8),
                mtime_t(1374205432), fsize_t(5),
                checksum_t("rLrvJ15Gp/FMHvRW//LIu+jIRyQ="))
        };

        var test_transcript = new TranscriptFile("test.T", ASSETS_DIR);

        var iter = test_transcript.iterator();

        foreach (var expected_entry in expected) {
            assert(iter.next());
            assert(expected_entry.equal(iter.get()));
        }

        assert(!iter.next());
    }
}
