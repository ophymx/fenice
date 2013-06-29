namespace Fenice {

public class TranscriptDiffer : Object, Gee.Iterable<Tobject>, Transcript {

    public Type element_type { get { return typeof(Tobject); }}

    public Gee.Iterable<Tobject> transcript1;
    public Gee.Iterable<Tobject> transcript2;

    public TranscriptDiffer(Transcript transcript1, Transcript transcript2) {
        this.transcript1 = transcript1;
        this.transcript2 = transcript2;
    }

    public Gee.Iterator<Tobject> iterator() {
        return new TranscriptDifferIterator(transcript1.iterator(),
            transcript2.iterator());
    }
}

public class TranscriptDifferIterator : Object, Gee.Iterator<Tobject> {

    private Gee.Iterator<Tobject> iterator1;
    private Gee.Iterator<Tobject> iterator2;

    private bool started = false;
    private bool iterator1_next = false;
    private bool iterator2_next = false;

    public TranscriptDifferIterator(Gee.Iterator<Tobject> iterator1,
        Gee.Iterator<Tobject> iterator2) {
        this.iterator1 = iterator1;
        this.iterator2 = iterator2;
    }

    public bool next() {
        if (!started)
            return first();

        int compare = compare_paths();
        if (compare == 0) {
            iterator1_next = iterator1.next();
            iterator2_next = iterator2.next();
        } else if (compare < 0) {
            iterator1_next = iterator1.next();
        } else {
            iterator2_next = iterator2.next();
        }

        return iterator1_next || iterator2_next;
    }

    public bool has_next() {
        return iterator1.has_next() || iterator2.has_next();
    }

    public bool first() {
        iterator1_next = iterator1.first();
        iterator2_next = iterator2.first();
        started = true;
        return iterator1_next || iterator2_next;
    }

    public new Tobject get() {
        Tobject result;
        if (compare_paths() >= 0) {
            result = iterator2.get();
            if (objects_match()) {
                result.change_type = ChangeType.UNCHANGED;
            }
        } else {
            result = iterator1.get();
            result.change_type = ChangeType.REMOVED;
        }
        return result;
    }

    public void remove() {
        assert_not_reached();
    }

    private bool objects_match() {
        return iterator1_next && iterator2_next &&
        iterator1.get().equal(iterator2.get());
    }

    private int compare_paths() {
        if (!iterator1_next)
            return 1;
        if (!iterator2_next)
            return -1;
        return iterator1.get().path.compare_to(iterator2.get().path);
    }
}

}
