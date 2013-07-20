namespace Fenice {

public class Tlink : Object, TranscriptEntry {
    private path_t _path;

    public path_t path {
        get { return _path; }
    }

    public target_t target { get; private set; }

    public ChangeType change_type { get; set; }

    public Tlink(path_t path, target_t target,
        ChangeType change_type = ChangeType.DEFAULT) {
        _path = path;
        this.target = target;
        this.change_type = change_type;
    }

    public char type_char() {
        return 'h';
    }

    public bool equal(TranscriptEntry other) {
        return get_class() == other.get_class() &&
            target.equal((other as Tlink).target);
    }

    public string to_string() {
        StringBuilder builder = object_string();
        builder.append(target.to_string());
        return builder.str;
    }
}

}
