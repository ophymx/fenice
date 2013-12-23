namespace Fenice {

public class Loadset : Object, Transcript {

    public Gee.ArrayList<Transcript> transcripts;
    private Gee.HashSet<string> _excludes = new Gee.HashSet<string>();
    private Gee.HashSet<string> _specials = new Gee.HashSet<string>();

    public Loadset(Gee.ArrayList<Transcript> transcripts =
        new Gee.ArrayList<Transcript>()) {
        this.transcripts = transcripts;
    }

    public void add_exclude(string pattern) {
        _excludes.add(pattern);
    }

    public void add_special(string pattern) {
        _specials.add(pattern);
    }

    public Gee.Set<string> excludes() {
        var excludes = new Gee.HashSet<string>();
        foreach (var transcript in transcripts) {
            if (transcript is Loadset) {
                var loadset = transcript as Loadset;
                excludes.add_all(loadset.excludes());
            }
        }
        excludes.add_all(_excludes);
        return excludes;
    }

    public Gee.Set<string> specials() {
        var specials = new Gee.HashSet<string>();
        foreach (var transcript in transcripts) {
            if (transcript is Loadset) {
                var loadset = transcript as Loadset;
                specials.add_all(loadset.specials());
            }
        }
        specials.add_all(_specials);
        return specials;
    }

    public TranscriptIterator iterator() {
        Transcript previous = Transcript.empty();
        foreach (var transcript in transcripts) {
            previous = new CompositeTranscript(previous, transcript);
        }
        return previous.iterator();
    }
}

}
