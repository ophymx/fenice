namespace Fenice {

public enum ChangeType {
    UNCHANGED,
    UPDATED,
    REMOVED,
    EXCLUDED;

    public const ChangeType DEFAULT = ChangeType.UPDATED;

    public bool has_changed() {
        return this != UNCHANGED;
    }
}

}
