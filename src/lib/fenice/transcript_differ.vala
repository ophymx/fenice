namespace Fenice {

public class TranscriptDiffer : Object, Transcript {

    public bool merge;
    public Transcript transcript1;
    public Transcript transcript2;

    public TranscriptDiffer(Transcript transcript1, Transcript transcript2,
        bool merge = false) {
        this.transcript1 = transcript1;
        this.transcript2 = transcript2;
        this.merge = merge;
    }

    public TranscriptIterator iterator() {
        return new TranscriptDifferIterator(transcript1.iterator(),
            transcript2.iterator(), merge);
    }
}

public class TranscriptDifferIterator : Object, TranscriptIterator {

    private TranscriptIterator iterator1;
    private TranscriptIterator iterator2;

    private bool merge = false;
    private bool started = false;
    private bool iterator1_next = false;
    private bool iterator2_next = false;

    public TranscriptDifferIterator(TranscriptIterator iterator1,
        TranscriptIterator iterator2, bool merge = false) {
        this.iterator1 = iterator1;
        this.iterator2 = iterator2;
        this.merge = merge;
    }

    public bool next() {
        if (!started) {
            iterator1_next = iterator1.next();
            iterator2_next = iterator2.next();
            started = true;
            return iterator1_next || iterator2_next;
        }

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

    public new TranscriptEntry get() {
        TranscriptEntry result;
        if (compare_paths() >= 0) {
            result = iterator2.get();
            if (objects_match() && !merge) {
                result.change_type = ChangeType.UNCHANGED;
            }
        } else {
            result = iterator1.get();
            if (!merge) {
                result.change_type = ChangeType.REMOVED;
            }
        }
        return result;
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
