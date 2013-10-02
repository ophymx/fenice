using Fenice;
public class checksum_tTests : TranscriptTests {

    public checksum_tTests() {
        base("checksum_t");
        add_test("parses required checksum", parse_required_checksum);
        add_test("parses optional checksum", parse_optional_checksum);
    }

    public void parse_required_checksum() {
        var checksum = checksum_t.parse("foobar");
        assert(checksum.checksum == "foobar");
        assert(checksum.check);
    }

    public void parse_optional_checksum() {
        var checksum = checksum_t.parse("-foobar");
        assert(checksum.checksum == "foobar");
        assert(!checksum.check);
    }
}
