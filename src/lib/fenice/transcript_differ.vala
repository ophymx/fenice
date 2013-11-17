namespace Fenice {

public class TranscriptDiffer : Object, Transcript {

    public bool merge;
    public Transcript left;
    public Transcript right;

    public TranscriptDiffer(Transcript left, Transcript right,
        bool merge = false) {
        this.left = left;
        this.right = right;
        this.merge = merge;
    }

    public TranscriptIterator iterator() {
        return new TranscriptDifferIterator(left.iterator(),
            right.iterator(), merge);
    }
}

public class TranscriptDifferIterator : Object, TranscriptIterator {

    private TranscriptIterator left;
    private TranscriptIterator right;

    private bool merge;
    private bool left_has_cur = false;
    private bool right_has_cur = false;

    public TranscriptDifferIterator(TranscriptIterator left,
        TranscriptIterator right, bool merge) {
        this.left = left;
        this.right = right;
        this.merge = merge;
    }

    public bool next() {
        int compare = compare_paths();
        if (compare == 0) {
            left_has_cur = left.next();
            right_has_cur = right.next();
        } else if (compare < 0) {
            left_has_cur = left.next();
        } else {
            right_has_cur = right.next();
        }

        return left_has_cur || right_has_cur;
    }

    public new TranscriptEntry get() {
        TranscriptEntry result;
        if (compare_paths() >= 0) {
            result = right.get();
            if (!merge && objects_match()) {
                result.change_type = ChangeType.UNCHANGED;
            }
        } else {
            result = left.get();
            if (!merge) {
                result.change_type = ChangeType.REMOVED;
            }
        }
        return result;
    }

    private bool objects_match() {
        return left_has_cur && right_has_cur && left.get().equal(right.get());
    }

    private int compare_paths() {
        if (!left_has_cur && !right_has_cur)
            return 0;
        if (!right_has_cur)
            return -1;
        if (!left_has_cur)
            return 1;
        return left.get().path.compare_to(right.get().path);
    }
}

}
