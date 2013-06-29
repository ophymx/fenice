namespace Fenice {

public class LoadsetFile : Object, LoadsetEntry {

    public string path { get; set construct; }

    public LoadsetFile(string path) {
        this.path = path;
    }

    public char type_char() {
        return 'k';
    }
}

}
