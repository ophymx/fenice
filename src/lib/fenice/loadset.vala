namespace Fenice {

public class Loadset : Object, Transcript {

    public Gee.ArrayList<Transcript> transcripts;

    public Loadset(Gee.ArrayList<Transcript> transcripts =
        new Gee.ArrayList<Transcript>()) {
        this.transcripts = transcripts;
    }

    public Gee.Set<string> excludes() {
        Gee.HashSet<string> excludes = new Gee.HashSet<string>();
        foreach (Transcript transcript in transcripts) {
            excludes.add_all(transcript.excludes());
        }
        return excludes;
    }

    public TranscriptIterator iterator() {
        Transcript previous = new TranscriptContainer.empty();
        foreach (Transcript transcript in transcripts) {
            previous = new TranscriptDiffer(previous, transcript, true);
        }
        return previous.iterator();
    }
}

}
