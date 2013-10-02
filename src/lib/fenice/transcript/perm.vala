namespace Fenice {

public interface Tperm : TranscriptEntry {

    public abstract mode_t mode { get; }

    public abstract uid_t uid { get; }

    public abstract gid_t gid { get; }

    protected bool perm_equal(Tperm other) {
        return mode.equal(other.mode) && uid.equal(other.uid) &&
            gid.equal(other.gid);
    }
}

}
