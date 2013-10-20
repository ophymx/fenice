namespace Fenice {

public class Loadset : Object, Transcript {

    public Gee.ArrayList<Transcript> transcripts;
    private Gee.HashSet<string> _excludes = new Gee.HashSet<string>();

    public Loadset(Gee.ArrayList<Transcript> transcripts =
        new Gee.ArrayList<Transcript>()) {
        this.transcripts = transcripts;
    }

    public void add_exclude(string pattern) {
        _excludes.add(pattern);
    }

    public Gee.Set<string> excludes() {
        Gee.HashSet<string> excludes = new Gee.HashSet<string>();
        foreach (Transcript transcript in transcripts) {
            if (transcript is Loadset) {
                Loadset loadset = transcript as Loadset;
                excludes.add_all(loadset.excludes());
            }
        }
        excludes.add_all(_excludes);
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
