using Fenice;
public class target_tTests : TranscriptTests {

    public target_tTests() {
        base("target_t");
        add_test("parse required target", parse_required_target);
        add_test("parse optional target", parse_optional_target);
    }

    public void parse_required_target() {
        var target = target_t.parse("/var/lib");
        assert(target.target.path == "/var/lib");
        assert(target.check);
    }

    public void parse_optional_target() {
        var target = target_t.parse("-/var/tmp");
        assert(target.target.path == "/var/tmp");
        assert(!target.check);
    }
}
