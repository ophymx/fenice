namespace Fenice {

public interface TranscriptEntry : Object {

    public abstract path_t path { get; protected set; }

    public abstract ChangeType change_type { get; set; }

    public abstract bool equal(TranscriptEntry other);

    public abstract TranscriptEntryType entry_type();

    public bool recurse() {
        return false;
    }

    public bool has_changed() {
        return change_type != ChangeType.UNCHANGED;
    }

    public bool was_removed() {
        return change_type == ChangeType.REMOVED;
    }

    protected bool object_equal(TranscriptEntry other) {
        return get_class() == other.get_class() && path.equal(other.path);
    }
}

}
