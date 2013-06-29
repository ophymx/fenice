namespace Fenice {

public interface Tspecial : Tperm {

    public abstract int major { get; }
    public abstract int minor { get; }

    protected bool special_equal(Tspecial other) {
        return major == other.major && minor == other.minor;
    }

    public StringBuilder special_string() {
        var builder = perm_string();
        builder.append_printf(" %5d %5d", major, minor);
        return builder;
    }
}

}
