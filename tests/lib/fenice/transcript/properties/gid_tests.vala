using Fenice;
public class gid_tTests : TranscriptTests {

    public gid_tTests() {
        base("gid_t");
        add_test("parses required gid", parse_required_gid);
        add_test("parses optional gid", parse_optional_gid);
    }

    public void parse_required_gid() {
        var gid = gid_t.parse("10");
        assert(gid.gid == 10);
        assert(gid.check);
    }

    public void parse_optional_gid() {
        var gid = gid_t.parse("-11");
        assert(gid.gid == 11);
        assert(!gid.check);
    }

}
