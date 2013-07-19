namespace Fenice {

public class Loadset : Object, Gee.Iterable<Tobject>, Transcript {

    public Type element_type { get { return typeof(Tobject); }}

    public Gee.ArrayList<Transcript> transcripts;

    public Loadset(Gee.ArrayList<Transcript> transcripts =
        new Gee.ArrayList<Transcript>()) {
        this.transcripts = transcripts;
    }

    public Gee.Iterator<Tobject> iterator() {
        Transcript previous = new TranscriptContainer.empty();
        foreach (Transcript transcript in transcripts) {
            previous = new TranscriptDiffer(previous, transcript, true);
        }
        return previous.iterator();
    }
}

}
