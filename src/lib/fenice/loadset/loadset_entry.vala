namespace Fenice {

public interface LoadsetEntry : Object {

    public abstract string path { get; private set; }

    public abstract char type_char();
}

}
