namespace Fenice {

public class Tdir : Object, TranscriptEntry, Tperm {

    public path_t path { get; protected set; }

    public mode_t mode { get; protected set; }

    public uid_t uid { get; protected set; }

    public gid_t gid { get; protected set; }

    public bool check { get; protected set; }

    public ChangeType change_type { get; set; }

    public Tdir(path_t path, mode_t mode, uid_t uid, gid_t gid,
        ChangeType change_type = ChangeType.DEFAULT, bool check=true) {
        this.path = path;
        this.mode = mode;
        this.uid = uid;
        this.gid = gid;
        this.check = check;
        this.change_type = change_type;
    }

    public TranscriptEntryType entry_type() {
        return TranscriptEntryType.DIR;
    }

    public bool recurse() {
        return check;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) && perm_equal(other as Tperm);
    }
}

}
