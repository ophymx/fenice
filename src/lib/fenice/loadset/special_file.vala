namespace Fenice {

public class SpecialFile : Object, LoadsetEntry {

    public string path { get; set construct; }

    public SpecialFile(string path) {
        this.path = path;
    }

    public char type_char() {
        return 's';
    }

}

}
