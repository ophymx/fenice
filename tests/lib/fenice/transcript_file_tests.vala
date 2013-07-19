using Fenice;
public class TranscriptFileTests : TranscriptTests {

    public TranscriptFileTests() {
        base("TranscriptFile");
        add_test("[TranscriptFile] simple transcript file", test_simple_file);
    }

    public override void set_up() {
        test_transcript = new TranscriptFile(ASSETS_DIR + "/test.T");
    }

    public override void tear_down() {
        test_transcript = null;
    }

    public void test_simple_file() {
        var iter = test_transcript.iterator();

        assert(iter.next());
        assert(iter.get().equal(
            new Tlink(Tpath("./hardlink"),
                Ttarget(Tpath("./hardlink-target"))
            )
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tdir(Tpath("./dir"), Tmode(0755), Tuid(10), Tgid(11))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tchar(Tpath("./dev/null"), Tmode(0666), Tuid(0), Tgid(0), 1, 3)
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tblock(Tpath("./dev/sda"), Tmode(0660), Tuid(0), Tgid(1), 8, 0)
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tsymlink(Tpath("./tmp"), Tmode(0777), Tuid(0), Tgid(0),
                Ttarget(Tpath("./var/tmp")))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tsocket(Tpath("./dev/log"), Tmode(0666), Tuid(0), Tgid(0))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tpipe(Tpath("./var/run/pipe"), Tmode(0644), Tuid(12), Tgid(0))
        ));

        assert(iter.next());
        assert(iter.get().equal(
            new Tfile(
                Tpath("./bar.txt"), Tmode(0644), Tuid(2), Tgid(8),
                Tmtime(1374205432), Tsize(5),
                Tchecksum("rLrvJ15Gp/FMHvRW//LIu+jIRyQ=")
            )
        ));

        assert(!iter.has_next());
    }
}
