namespace Fenice {

public interface Tspecial : Tperm {

    public abstract uint major { get; }
    public abstract uint minor { get; }

    protected bool special_equal(Tspecial other) {
        return major == other.major && minor == other.minor;
    }

    public StringBuilder special_string() {
        var builder = perm_string();
        builder.append_printf(" %5u %5u", major, minor);
        return builder;
    }
}

}
