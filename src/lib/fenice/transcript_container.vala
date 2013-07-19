namespace Fenice {

public class TranscriptContainer : Object, Gee.Iterable<Tobject>, Transcript {

    public Gee.Iterable<Tobject> objects;

    public Type element_type { get { return typeof(Tobject); }}

    public TranscriptContainer(Gee.Iterable<Tobject> objects) {
        this.objects = objects;
    }

    public TranscriptContainer.empty() {
        this.objects = new Gee.ArrayList<Tobject>();
    }

    public Gee.Iterator<Tobject> iterator() {
        return objects.iterator();
    }

}

}
