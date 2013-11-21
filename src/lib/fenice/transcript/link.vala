namespace Fenice {

public class Tlink : Object, TranscriptEntry {

    public path_t path { get; protected set; }

    public target_t target { get; protected set; }

    public ChangeType change_type { get; set; }

    public Tlink(path_t path, target_t target,
        ChangeType change_type = ChangeType.DEFAULT) {
        this.path = path;
        this.target = target;
        this.change_type = change_type;
    }

    public TranscriptEntryType entry_type() {
        return TranscriptEntryType.LINK;
    }

    public bool equal(TranscriptEntry other) {
        return get_class() == other.get_class() &&
            target.equal((other as Tlink).target);
    }
}

}
