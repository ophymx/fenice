using Fenice;
public class TranscriptDifferTests : TranscriptTests {

    public TranscriptDifferTests() {
        base("TranscriptDiffer");
        add_test("[TranscriptDiffer] merges simple sorted transcripts",
            test_merge_sorted);
        add_test("[TranscriptDiffer] detects removed objects",
            test_removed_file);
        add_test("[TranscriptDiffer] detects unchanged objects",
            test_unchanged_file);
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
        test_transcript = new TranscriptDiffer(t1, t2);
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

    public void test_removed_file() {
        var symlink = new Tsymlink(path_t("./tmp"), mode1, uid1, gid1,
            target_t(path_t("./var/tmp")));
        l1.add(symlink);

        var iter = test_transcript.iterator();

        assert(iter.next());
        assert(iter.get().equal(symlink));
        assert(iter.get().change_type == ChangeType.REMOVED);
        assert(iter.get().change_type.has_changed());
        assert(!iter.next());
    }

    public void test_unchanged_file() {
        var symlink = new Tsymlink(path_t("./tmp"), mode1, uid1, gid1,
            target_t(path_t("./var/tmp")));
        l1.add(symlink);
        l2.add(symlink);

        var iter = test_transcript.iterator();

        assert(iter.next());
        assert(iter.get().equal(symlink));
        assert(iter.get().change_type == ChangeType.UNCHANGED);
        assert(!iter.get().change_type.has_changed());
        assert(!iter.next());
    }
}
