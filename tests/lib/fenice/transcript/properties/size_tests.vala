using Fenice;
public class size_tTests : TranscriptTests {

    public size_tTests() {
        base("fsize_t");
        add_test("parse required file size", parse_required_fsize);
        add_test("parse optional file size", parse_optional_fsize);
    }

    public void parse_required_fsize() {
        var fsize = fsize_t.parse("12");
        assert(fsize.size == 12);
        assert(fsize.check);
    }

    public void parse_optional_fsize() {
        var fsize = fsize_t.parse("-1022");
        assert(fsize.size == 1022);
        assert(!fsize.check);
    }
}
