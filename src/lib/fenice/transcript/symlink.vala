namespace Fenice {

public class Tsymlink : Object, TranscriptEntry, Tperm {

    public path_t path { get; protected set; }

    public mode_t mode { get; protected set; }

    public uid_t uid { get; protected set; }

    public gid_t gid { get; protected set; }

    public target_t target { get; protected set; }

    public ChangeType change_type { get; set; }

    public Tsymlink(path_t path, mode_t mode, uid_t uid, gid_t gid,
        target_t target, ChangeType change_type = ChangeType.DEFAULT) {
        this.path = path;
        this.mode = mode;
        this.uid = uid;
        this.gid = gid;
        this.target = target;
        this.change_type = change_type;
    }

    public TranscriptEntryType entry_type() {
        return TranscriptEntryType.SYMLINK;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) &&
            perm_equal(other as Tperm) &&
            target.equal((other as Tsymlink).target);
    }
}

}
