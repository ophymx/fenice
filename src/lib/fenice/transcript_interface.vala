namespace Fenice {

public interface Transcript : Object {

    public abstract TranscriptIterator iterator();
    public abstract Gee.Set<string> excludes();
}

public interface TranscriptIterator : Object {

    public abstract bool next();
    public abstract bool first();
    public abstract bool has_next();
    public abstract TranscriptEntry get();
}

}
