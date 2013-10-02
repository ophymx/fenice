using Fenice;
public class uid_tTests : TranscriptTests {

    public uid_tTests() {
        base("uid_t");
        add_test("parses required uid", parse_required_uid);
        add_test("parses optional uid", parse_optional_uid);
    }

    public void parse_required_uid() {
        var uid = uid_t.parse("10");
        assert(uid.uid == 10);
        assert(uid.check);
    }

    public void parse_optional_uid() {
        var uid = uid_t.parse("-11");
        assert(uid.uid == 11);
        assert(!uid.check);
    }

}
