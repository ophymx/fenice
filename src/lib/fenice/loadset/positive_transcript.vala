namespace Fenice {

public class PositiveTranscript : Object, LoadsetEntry {

    public string path { get; set construct; }

    public PositiveTranscript(string path) {
        this.path = path;
    }

    public char type_char() {
        return 'p';
    }

}

}
