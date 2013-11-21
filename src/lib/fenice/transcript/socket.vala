namespace Fenice {

public class Tsocket : Object, TranscriptEntry, Tperm {

    public path_t path { get; protected set; }

    public mode_t mode { get; protected set; }

    public uid_t uid { get; protected set; }

    public gid_t gid { get; protected set; }

    public ChangeType change_type { get; set; }

    public Tsocket(path_t path, mode_t mode, uid_t uid, gid_t gid,
        ChangeType change_type = ChangeType.DEFAULT) {
        this.path = path;
        this.mode = mode;
        this.uid = uid;
        this.gid = gid;
        this.change_type = change_type;
    }

    public TranscriptEntryType entry_type() {
        return TranscriptEntryType.SOCKET;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) && perm_equal(other as Tperm);
    }
}

}
