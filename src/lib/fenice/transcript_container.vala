namespace Fenice {

public class TranscriptContainer : Object, Transcript {

    public Gee.Iterable<TranscriptEntry> objects;

    public TranscriptContainer(Gee.Iterable<TranscriptEntry> objects) {
        this.objects = objects;
    }

    public TranscriptContainer.empty() {
        this.objects = new Gee.ArrayList<TranscriptEntry>();
    }

    public TranscriptIterator iterator() {
        return new TranscriptContainerIterator(objects.iterator());
    }
}

public class TranscriptContainerIterator : Object, TranscriptIterator {

    private Gee.Iterator<TranscriptEntry> iterator;

    public TranscriptContainerIterator(Gee.Iterator<TranscriptEntry> iterator) {
        this.iterator = iterator;
    }

    public bool first() {
        return iterator.first();
    }

    public bool next() {
        return iterator.next();
    }

    public bool has_next() {
        return iterator.has_next();
    }

    public new TranscriptEntry get() {
        return iterator.get();
    }
}

}
