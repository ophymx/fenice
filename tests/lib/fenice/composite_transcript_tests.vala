using Fenice;
public class CompositeTranscriptTests : TranscriptTests {

    public CompositeTranscriptTests() {
        base("CompositeTranscript");
        add_test(".iterator() merges simple sorted transcripts",
            test_merge_sorted);
    }

    protected Gee.ArrayList<TranscriptEntry> l1;
    protected Gee.ArrayList<TranscriptEntry> l2;
    protected Transcript t1;
    protected Transcript t2;

    public mode_t mode1 = mode_t(0644);
    public uid_t uid1 = uid_t(0);
    public gid_t gid1 = gid_t(0);

    public override void set_up() {
        l1 = new Gee.ArrayList<TranscriptEntry>();
        l2 = new Gee.ArrayList<TranscriptEntry>();
        t1 = new TranscriptContainer(l1);
        t2 = new TranscriptContainer(l2);
        test_transcript = new CompositeTranscript(t1, t2);
    }

    public override void tear_down() {
        test_transcript = null;
    }

    public void test_merge_sorted() {
        var a = new Tdir(path_t("./a"), mode1, uid1, gid1);
        var b = new Tdir(path_t("./b"), mode1, uid1, gid1);
        var c = new Tdir(path_t("./c"), mode1, uid1, gid1);
        var d = new Tdir(path_t("./d"), mode1, uid1, gid1);
        var e = new Tdir(path_t("./e"), mode1, uid1, gid1);
        var f = new Tdir(path_t("./f"), mode1, uid1, gid1);
        l1.add(a);
        l2.add(b);
        l1.add(c);
        l2.add(d);
        l1.add(e);
        l1.add(f);

        var iter = test_transcript.iterator();

        assert(iter.next());
        assert(iter.get().equal(a));
        assert(iter.next());
        assert(iter.get().equal(b));
        assert(iter.next());
        assert(iter.get().equal(c));
        assert(iter.next());
        assert(iter.get().equal(d));
        assert(iter.next());
        assert(iter.get().equal(e));
        assert(iter.next());
        assert(iter.get().equal(f));
        assert(!iter.next());
    }
}
