using Fenice;
public class mode_tTests : TranscriptTests {

    public mode_tTests() {
        base("mode_t");
        add_test("parses mode without mask", parse_mode_without_mask);
        add_test("parses mod with mask", parse_mode_with_mask);
    }

    public void parse_mode_without_mask() {
        var mode = mode_t.parse("0000");
        assert(mode.mode == 0);
        assert(mode.mask == 4095);
    }

    public void parse_mode_with_mask() {
        var mode = mode_t.parse("0427-0077");
        assert(mode.mode == 279);
        assert(mode.mask == 4032);
    }
}
