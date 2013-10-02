namespace Fenice {

public class NegativeTranscript : Object, LoadsetEntry {

    public string path { get; set construct; }

    public NegativeTranscript(string path) {
        this.path = path;
    }

    public char type_char() {
        return 'n';
    }
}

}
