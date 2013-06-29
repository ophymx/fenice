namespace Fenice {

public interface Tobject : Object {

    public abstract Tpath path { get; }

    public abstract ChangeType change_type { get; set; }

    public abstract char type_char();

    public abstract bool equal(Tobject other);

    public abstract string to_string();

    public StringBuilder object_string() {
        var builder = new StringBuilder();
        if (change_type == ChangeType.REMOVED)
            builder.append("- ");
        builder.append_printf("%c %-35s\t", type_char(), path.to_string());
        return builder;
    }

    protected bool object_equal(Tobject other) {
        return get_class() == other.get_class() && path.equal(other.path);
    }

}

}
