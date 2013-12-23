namespace Fenice {

public class CompositeTranscript : Object, Transcript {

    public Transcript left;
    public Transcript right;

    public CompositeTranscript(Transcript left, Transcript right) {
        this.left = left;
        this.right = right;
    }

    public TranscriptIterator iterator() {
        return new Iterator(left.iterator(), right.iterator());
    }

    public class Iterator : Object, TranscriptIterator {

        private TranscriptIterator left;
        private TranscriptIterator right;

        private bool left_has_cur = false;
        private bool right_has_cur = false;

        public Iterator(TranscriptIterator left, TranscriptIterator right) {
            this.left = left;
            this.right = right;
        }

        public bool next() {
            var compare = compare_paths();
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
            if (compare_paths() >= 0) {
                return right.get();
            } else {
                return left.get();
            }
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

}
