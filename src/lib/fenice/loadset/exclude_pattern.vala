namespace Fenice {

public class ExcludePattern : Object, LoadsetEntry {

    public string path { get; set construct; }

    public ExcludePattern(string path) {
        this.path = path;
    }

    public char type_char() {
        return 'x';
    }
}

}
