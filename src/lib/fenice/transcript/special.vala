namespace Fenice {

public interface Tspecial : Tperm {

    public abstract int major { get; }
    public abstract int minor { get; }

    protected bool special_equal(Tspecial other) {
        return major == other.major && minor == other.minor;
    }
}

}
