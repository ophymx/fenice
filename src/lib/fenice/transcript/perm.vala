namespace Fenice {

public interface Tperm : TranscriptEntry {

    public abstract Tmode mode { get; }

    public abstract Tuid uid { get; }

    public abstract Tgid gid { get; }

    protected bool perm_equal(Tperm other) {
        return mode.equal(other.mode) && uid.equal(other.uid) &&
            gid.equal(other.gid);
    }

    public StringBuilder perm_string() {
        var builder = object_string();
        builder.append_printf("%s %5s %5s", mode.to_string(), uid.to_string(),
            gid.to_string());
        return builder;
    }
}

}
