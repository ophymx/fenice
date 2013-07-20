namespace Fenice {

public class TranscriptContainer : Object, Transcript {

    public Gee.Iterable<Tobject> objects;

    public TranscriptContainer(Gee.Iterable<Tobject> objects) {
        this.objects = objects;
    }

    public TranscriptContainer.empty() {
        this.objects = new Gee.ArrayList<Tobject>();
    }

    public TranscriptIterator iterator() {
        return new TranscriptContainerIterator(objects.iterator());
    }

}

public class TranscriptContainerIterator : Object, TranscriptIterator {

    private Gee.Iterator<Tobject> iterator;

    public TranscriptContainerIterator(Gee.Iterator<Tobject> iterator) {
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

    public new Tobject get() {
        return iterator.get();
    }
}

}
