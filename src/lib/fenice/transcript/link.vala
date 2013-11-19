namespace Fenice {

public class Tlink : Object, TranscriptEntry {
    private path_t _path;

    public path_t path { get { return _path; }}

    public target_t target { get; private set; }

    public ChangeType change_type { get; set; }

    public TranscriptEntryType entry_type() {
        return TranscriptEntryType.LINK;
    }

    public Tlink(path_t path, target_t target,
        ChangeType change_type = ChangeType.DEFAULT) {
        _path = path;
        this.target = target;
        this.change_type = change_type;
    }

    public bool equal(TranscriptEntry other) {
        return get_class() == other.get_class() &&
            target.equal((other as Tlink).target);
    }
}

}
