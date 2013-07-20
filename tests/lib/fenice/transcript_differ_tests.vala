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

    protected Gee.ArrayList<Tobject> l1;
    protected Gee.ArrayList<Tobject> l2;
    protected Transcript t1;
    protected Transcript t2;

    public Tmode mode1 = Tmode(0644);
    public Tuid uid1 = Tuid(0);
    public Tgid gid1 = Tgid(0);

    public override void set_up() {
        l1 = new Gee.ArrayList<Tobject>();
        l2 = new Gee.ArrayList<Tobject>();
        t1 = new TranscriptContainer(l1);
        t2 = new TranscriptContainer(l2);
        test_transcript = new TranscriptDiffer(t1, t2);
    }

    public override void tear_down() {
        test_transcript = null;
    }

    public void test_merge_sorted() {
        var a = new Tdir(Tpath("./a"), mode1, uid1, gid1);
        var b = new Tdir(Tpath("./b"), mode1, uid1, gid1);
        var c = new Tdir(Tpath("./c"), mode1, uid1, gid1);
        var d = new Tdir(Tpath("./d"), mode1, uid1, gid1);
        var e = new Tdir(Tpath("./e"), mode1, uid1, gid1);
        var f = new Tdir(Tpath("./f"), mode1, uid1, gid1);
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
        var symlink = new Tsymlink(Tpath("./tmp"), mode1, uid1, gid1,
            Ttarget(Tpath("./var/tmp")));
        l1.add(symlink);

        var iter = test_transcript.iterator();

        assert(iter.next());
        assert(iter.get().equal(symlink));
        assert(iter.get().change_type == ChangeType.REMOVED);
        assert(iter.get().change_type.has_changed());
        assert(!iter.next());
    }

    public void test_unchanged_file() {
        var symlink = new Tsymlink(Tpath("./tmp"), mode1, uid1, gid1,
            Ttarget(Tpath("./var/tmp")));
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
