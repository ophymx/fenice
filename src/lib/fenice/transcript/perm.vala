namespace Fenice {

public interface Tperm : TranscriptEntry {

    public abstract mode_t mode { get; protected set; }

    public abstract uid_t uid { get; protected set; }

    public abstract gid_t gid { get; protected set; }

    protected bool perm_equal(Tperm other) {
        return mode.equal(other.mode) && uid.equal(other.uid) &&
            gid.equal(other.gid);
    }
}

}
