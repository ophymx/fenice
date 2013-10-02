using Fenice;
public class path_tTests : TranscriptTests {

    public path_tTests() {
        base("path_t");
        add_test("unescapes white space when parsing", parse_escape_whitespace);
    }

    public void parse_escape_whitespace() {
        var path = path_t.parse("/var/tmp\\bfile/foo\\tbar");
        assert(path.path == "/var/tmp file/foo\tbar");
    }
}
