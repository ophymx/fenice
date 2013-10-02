using Fenice;
public class mtime_tTests : TranscriptTests {

    public mtime_tTests() {
        base("mtime_t");
        add_test("parse required mtime", parse_required_mtime);
        add_test("parse optional mtime", parse_optional_mtime);
    }

    public void parse_required_mtime() {
        var mtime = mtime_t.parse("0");
        assert(mtime.mtime == 0);
        assert(mtime.check);
    }

    public void parse_optional_mtime() {
        var mtime = mtime_t.parse("-0");
        assert(mtime.mtime == 0);
        assert(!mtime.check);
    }
}
